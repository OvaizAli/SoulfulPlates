package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.*;
import com.Group11.soulfulplates.payload.request.CreateOrderRequest;
import com.Group11.soulfulplates.payload.response.CreateOrderResponse;
import com.Group11.soulfulplates.payload.response.OrderDetailsResponse;
import com.Group11.soulfulplates.payload.response.OrdersResponse;
import com.Group11.soulfulplates.repository.*;
import com.Group11.soulfulplates.services.OrderService;
import com.Group11.soulfulplates.utils.CartItemUtils;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * This class implements the OrderService interface.
 * It provides methods to create orders, update order status, fetch order details,
 * fetch orders for users and stores, and count orders for a store within a specific month.
 */


@Service
public class OrderServiceImpl implements OrderService {
    private final UserRepository userRepository;
    private final StoreRepository storeRepository;
    private final OrderRepository orderRepository;
    private final CartItemRepository cartItemRepository;
    private final PaymentRepository paymentRepository;
    private final MenuItemRepository menuItemRepository;
    private final CategoryRepository categoryRepository;
    private final SubcategoryRepository subCategoryRepository;

    @Autowired
    public OrderServiceImpl(UserRepository userRepository, StoreRepository storeRepository, OrderRepository orderRepository, CartItemRepository cartItemRepository, MenuItemRepository menuItemRepository, PaymentRepository paymentRepository, CategoryRepository categoryRepository, SubcategoryRepository subCategoryRepository) {
        this.userRepository = userRepository;
        this.storeRepository = storeRepository;
        this.orderRepository = orderRepository;
        this.cartItemRepository = cartItemRepository;
        this.menuItemRepository = menuItemRepository;
        this.paymentRepository = paymentRepository;
        this.categoryRepository = categoryRepository;
        this.subCategoryRepository = subCategoryRepository;
    }

    @Transactional
    public CreateOrderResponse createOrder(CreateOrderRequest request) {
        // Find user by orderId
        Optional<User> user = userRepository.findById(request.getUserId());
        // Find store by storeId
        Store store = storeRepository.getReferenceById(request.getStoreId());

        // If user is missing, return null
        if (!user.isPresent()) {
            return null;
        }

        Order order = new Order();
        order.setUser(user.get());
        order.setStore(store);
        order.setInstructions(request.getInstructions());
        order.setStatus("Pending");
        order.setRating(null);
        order.setUpdatedAt(new Date());
        order.setCreatedAt(new Date());

        order = orderRepository.save(order);

        // Check if selectedItems is not null before iterating
        if (request.getSelectedItems() != null) {
            // Logic to create and save CartItem entities
            for (CreateOrderRequest.SelectedItem item : request.getSelectedItems()) {
                CartItem cartItem = new CartItem();
                cartItem.setOrder(order);
                cartItem.setItemId(item.getMenuItemId());
                cartItem.setName(item.getItemName());
                cartItem.setQuantity(item.getQuantity());
                cartItem.setPrice(item.getPrice());
                // Save each CartItem
                cartItemRepository.save(cartItem);
            }
        }

        // Check if order is not null before accessing its properties
        if (order != null) {
            CreateOrderResponse.Data temp = new CreateOrderResponse.Data(order.getOrderId());
            return new CreateOrderResponse(1, temp, "Order Created.");
        } else {
            // Handle the case where order is null
            return new CreateOrderResponse(-1, null, "Failed to create order.");
        }
    }


    @Override
    public Order updateOrderStatus(Long orderId, String status) {
        if (!orderRepository.existsById(orderId)) {
            return null;
        }
        RuntimeException orderNotFound = new RuntimeException("Order not found with id: " + orderId);
        Order order = orderRepository.findById(orderId).orElseThrow(() -> orderNotFound);
        order.setStatus(status);
        return orderRepository.save(order);
    }

    @Override
    public OrderDetailsResponse getOrderDetails(Long userId, Long orderId) throws Exception {
        // Find the order by id and check if it belongs to the user
        RuntimeException orderNotFound = new RuntimeException("Order not found or does not belong to the user");
        Order order = orderRepository.findByOrderIdAndUserId(orderId, userId).orElseThrow(() -> orderNotFound);

        // Convert the order entity to OrderDetailsData
        OrderDetailsResponse.OrderDetails data = mapOrderToOrderDetailsData(order);

        // Construct the response object
        return new OrderDetailsResponse(1, "Success", data);
    }

    private OrderDetailsResponse.OrderDetails mapOrderToOrderDetailsData(Order order) throws Exception {
        OrderDetailsResponse.OrderDetails orderDetails = new OrderDetailsResponse.OrderDetails();

        orderDetails.setOrderId(order.getOrderId());
        orderDetails.setOrderStatus(order.getStatus());
        orderDetails.setCreatedDate(order.getCreatedAt());

        // Check if user is null
        if (order.getUser() != null) {
            orderDetails.setUserId(order.getUser().getId());
            orderDetails.setUsername(order.getUser().getUsername());
            orderDetails.setUserPhone(order.getUser().getContactNumber());
            orderDetails.setUserEmail(order.getUser().getEmail());
        } else {
            throw new Exception("User not found for order");
        }

        orderDetails.setStoreId(order.getStore().getStoreId());
        orderDetails.setStoreName(order.getStore().getStoreName());
        orderDetails.setStorePhone(order.getStore().getContactNumber());
        orderDetails.setStoreEmail(order.getStore().getStoreEmail());

        orderDetails.setInstructions(order.getInstructions());

        if (order.getRating() != null) {
            orderDetails.setRating(order.getRating().getRating());
            orderDetails.setFeedback(order.getRating().getFeedback());
        } else {
            orderDetails.setRating(null);
            orderDetails.setFeedback(null);
        }

        if (order.getOrderId() != null) {
            Optional<Payment> payment = paymentRepository.findFirstByOrderOrderIdOrderByPaymentIdDesc(order.getOrderId());
            if (payment.isPresent()) {
                orderDetails.setPaymentStatus(payment.get().getStatus());
            }
        }

        List<CartItem> cartItems = cartItemRepository.findByOrderOrderId(order.getOrderId());
        List<Long> itemIds = CartItemUtils.extractItemIds(cartItems);
        Double totalAmount = CartItemUtils.getTotalForOrderId(cartItems);

        if (itemIds.isEmpty()) {
            throw new Exception("Menu Items not found");
        }

        orderDetails.setTotalAmount(totalAmount);

        List<MenuItem> menuItems = menuItemRepository.findAllById(itemIds);

        orderDetails.setItems(menuItems.stream()
                .map(this::mapMenuItemToDTO)
                .collect(Collectors.toList()));

        return orderDetails;
    }

    private OrderDetailsResponse.OrderDetails.MenuItemDTO mapMenuItemToDTO(MenuItem menuItem) {
        OrderDetailsResponse.OrderDetails.MenuItemDTO menuItemDTO = new OrderDetailsResponse.OrderDetails.MenuItemDTO();
        menuItemDTO.setItemId(menuItem.getItemId());
        menuItemDTO.setStoreId(menuItem.getStoreId());
        menuItemDTO.setItemName(menuItem.getItemName());
        menuItemDTO.setItemImage(menuItem.getItemImage());
        menuItemDTO.setItemPrice(menuItem.getItemPrice());
        menuItemDTO.setType(menuItem.getType());
        menuItemDTO.setCategoryId(menuItem.getCategoryId());
        Category category = categoryRepository.getReferenceById(menuItem.getCategoryId());
        if (category != null) {
            menuItemDTO.setCategory(category.getCategoryName());
        }

        menuItemDTO.setSubCategoryId(menuItem.getSubcategoryId());
        Subcategory subCategory = subCategoryRepository.getReferenceById(menuItem.getSubcategoryId());
        if (subCategory != null) {
            menuItemDTO.setSubCategory(subCategory.getSubCategoryName());
        }

        menuItemDTO.setServingType(menuItem.getServingType());
        menuItemDTO.setPortion(menuItem.getPortion());
        menuItemDTO.setInStock(menuItem.isInStock());
        menuItemDTO.setIsRecommended(menuItem.isRecommended());
        menuItemDTO.setDescription(menuItem.getDescription());

        return menuItemDTO;
    }

    public OrdersResponse getOrdersForUser(Long userId, String status, Integer limit, Integer offset) throws Exception {
        // Create a PageRequest object for pagination and sorting
        PageRequest pageRequest = PageRequest.of(offset, limit, Sort.by(Sort.Direction.DESC, "createdAt"));

        Page<Order> ordersPage;
        if(status.isEmpty()){
            ordersPage = orderRepository.findByUserIdOrderByCreatedAtDesc(userId, status, pageRequest);
        }
        else{
            // Fetch the orders using the repository
            ordersPage = orderRepository.findByUserIdAndStatusOrderByCreatedAtDesc(userId, status, pageRequest);
        }

        // Convert the Page<Order> to List<OrderData>
        List<OrdersResponse.OrderData> orderDataList = ordersPage.getContent().stream()
                .map(this::convertToOrderData)
                .collect(Collectors.toList());

        // Return the response
        return new OrdersResponse(1, "Success", orderDataList);
    }

    OrdersResponse.OrderData convertToOrderData(Order order) {
        OrdersResponse.OrderData orderData = new OrdersResponse.OrderData();
        orderData.setOrderId(order.getOrderId());
        orderData.setOrderStatus(order.getStatus());
        orderData.setCreatedDate(order.getCreatedAt());

        if (order.getUser() != null) {
            orderData.setUserId(order.getUser().getId());
            orderData.setUsername(order.getUser().getUsername());
            orderData.setUserPhone(order.getUser().getContactNumber());
            orderData.setUserEmail(order.getUser().getEmail());
        } else {
            orderData.setUserId(null);
            orderData.setUsername("");
            orderData.setUserPhone("");
            orderData.setUserEmail("");

        }

        // Check if the store is null
        if (order.getStore() != null) {
            orderData.setStoreId(order.getStore().getStoreId());
            orderData.setStoreName(order.getStore().getStoreName());
            orderData.setStorePhone(order.getStore().getStoreContactNumber());
            orderData.setStoreEmail(order.getStore().getStoreEmail());
        } else {
            // Handle the case when the store is null
            orderData.setStoreId(null);
            orderData.setStoreName("");
            orderData.setStorePhone("");
            orderData.setStoreEmail("");

        }

        orderData.setInstructions(order.getInstructions());

        if (order.getRating() != null) {
            orderData.setRating(order.getRating().getRating());
            orderData.setFeedback(order.getRating().getFeedback());
        }

        if (order.getOrderId() != null) {
            Optional<Payment> payment = paymentRepository.findFirstByOrderOrderIdOrderByPaymentIdDesc(order.getOrderId());
            if (!payment.isEmpty()) {
                orderData.setPaymentStatus(payment.get().getStatus());
            }
        }
        orderData.setPaymentStatus(order.getStatus());

        List<CartItem> cartItems = cartItemRepository.findByOrderOrderId(order.getOrderId());
        List<Long> itemIds = null;
        Double totalAmount = null;
        if (cartItems.size() > 0) {
            itemIds = CartItemUtils.extractItemIds(cartItems);
            totalAmount = CartItemUtils.getTotalForOrderId(cartItems);
        }

        orderData.setTotalAmount(totalAmount);

        if (itemIds != null) {
            List<MenuItem> menuItems = menuItemRepository.findAllById(itemIds);
            orderData.setItems(menuItems.stream()
                    .map(this::convertToItemData)
                    .collect(Collectors.toList()));
        }

        return orderData;
    }

    OrdersResponse.OrderData.ItemData convertToItemData(MenuItem menuItem) {
        OrdersResponse.OrderData.ItemData itemData = new OrdersResponse.OrderData.ItemData();
        itemData.setItemId(menuItem.getItemId());
        itemData.setStoreId(menuItem.getStoreId());
        itemData.setItemName(menuItem.getItemName());
        itemData.setItemImage(menuItem.getItemImage());
        itemData.setItemPrice(String.valueOf(menuItem.getItemPrice()));
        itemData.setType(menuItem.getType());

        itemData.setCategoryId(menuItem.getCategoryId());
        Category category = categoryRepository.getReferenceById(menuItem.getCategoryId());
        if (category != null) {
            itemData.setCategory(category.getCategoryName());
        } else {
            itemData.setCategory(null);
        }

        itemData.setSubCategoryId(menuItem.getSubcategoryId());
        Subcategory subCategory = subCategoryRepository.getReferenceById(menuItem.getSubcategoryId());
        if (subCategory != null) {
            itemData.setSubCategory(subCategory.getSubCategoryName());
        } else {
            itemData.setSubCategory(null);
        }

        itemData.setServingType(menuItem.getServingType());
        itemData.setPortion(menuItem.getPortion());
        itemData.setInStock(menuItem.isInStock());
        itemData.setIsRecommended(menuItem.isRecommended());
        itemData.setDescription(menuItem.getDescription());

        return itemData;
    }

    public OrdersResponse getOrdersForStore(Long storeId, String status, Integer limit, Integer offset) throws Exception {
        // Create a PageRequest object for pagination and sorting
        PageRequest pageRequest = PageRequest.of(offset, limit, Sort.by(Sort.Direction.DESC, "createdAt"));
        Page<Order> ordersPage;
        if(status.isEmpty()){
            ordersPage = orderRepository.findByStoreStoreIdOrderByCreatedAtDesc(storeId, status, pageRequest);
        }
        else{
            // Fetch the orders using the repository
            ordersPage = orderRepository.findByStoreStoreIdAndStatusOrderByCreatedAtDesc(storeId, status, pageRequest);
        }

        // Convert the Page<Order> to List<OrderData>
        List<OrdersResponse.OrderData> orderDataList = ordersPage.getContent().stream()
                .map(this::convertToOrderData)
                .collect(Collectors.toList());

        // Return the response
        return new OrdersResponse(1, "Success", orderDataList);
    }

    @Override
    public Long getOrderCountForStoreAndMonth(int storeId, int month) {
        return orderRepository.countByStoreIdAndMonth(storeId, month);
    }
}
