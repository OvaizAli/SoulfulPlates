package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.*;
import com.Group11.soulfulplates.payload.request.CreateOrderRequest;
import com.Group11.soulfulplates.payload.response.CreateOrderResponse;
import com.Group11.soulfulplates.payload.response.OrdersResponse;
import com.Group11.soulfulplates.repository.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

import java.util.Arrays;
import java.util.Collections;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class OrderServiceImplTest {

    @InjectMocks
    private OrderServiceImpl orderService;

    @Mock
    private OrderRepository orderRepository;

    @Mock
    private CategoryRepository categoryRepository;

    @Mock
    private SubcategoryRepository subcategoryRepository;

    @Mock
    private MenuItemRepository menuItemRepository;

    @Mock
    private PaymentRepository paymentRepository;


    @Mock
    private UserRepository userRepository;

    @Mock
    private StoreRepository storeRepository;

    @Mock
    private CartItemRepository cartItemRepository;

    @Mock
    private SubcategoryRepository subCategoryRepository;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        orderService = new OrderServiceImpl(
                    userRepository,
                    storeRepository,
                    orderRepository,
                    cartItemRepository,
                    menuItemRepository,
                    paymentRepository,
                    categoryRepository,
                    subCategoryRepository
            );
    }

    @Test
    void testCreateOrder_SuccessfullyCreated() {
        // Given
        Long userId = 1L;
        Long storeId = 2L;
        String instructions = "Some instructions";

        CreateOrderRequest request = new CreateOrderRequest();
        request.setUserId(userId);
        request.setStoreId(storeId);
        request.setInstructions(instructions);

        User user = new User();
        user.setId(userId);
        Optional<User> optionalUser = Optional.of(user);
        when(userRepository.findById(userId)).thenReturn(optionalUser);

        Store store = new Store();
        store.setStoreId(storeId);
        when(storeRepository.getReferenceById(storeId)).thenReturn(store);

        Order savedOrder = new Order();
        savedOrder.setOrderId(1L);
        when(orderRepository.save(any(Order.class))).thenReturn(savedOrder);

        CreateOrderRequest.SelectedItem item = new CreateOrderRequest.SelectedItem();
        item.setMenuItemId(1L);
        item.setItemName("Item");
        item.setQuantity(2);
        item.setPrice(10.0);

        request.setSelectedItems(Collections.singletonList(item));

        // When
        CreateOrderResponse response = orderService.createOrder(request);

        // Then
        assertEquals(1, response.getCode());
        assertNotNull(response.getData());
        assertEquals("Order Created.", response.getDescription());
        verify(userRepository, times(1)).findById(userId);
        verify(orderRepository, times(1)).save(any(Order.class));
        verify(cartItemRepository, times(1)).save(any(CartItem.class));
    }

    @Test
    void testUpdateOrderStatus_OrderNotFound_ReturnsNull() {
        // Given
        Long orderId = 1L;
        String status = "Pending";

        when(orderRepository.existsById(orderId)).thenReturn(false);

        // When
        Order result = orderService.updateOrderStatus(orderId, status);

        // Then
        assertNull(result);
        verify(orderRepository, times(1)).existsById(orderId);
        verify(orderRepository, never()).findById(orderId);
        verify(orderRepository, never()).save(any(Order.class));
    }

    @Test
    void testUpdateOrderStatus_OrderFound_SuccessfullyUpdated() {
        // Given
        Long orderId = 1L;
        String status = "Cancelled";

        Order order = new Order();
        order.setOrderId(orderId);

        when(orderRepository.existsById(orderId)).thenReturn(true);
        when(orderRepository.findById(orderId)).thenReturn(Optional.of(order));
        when(orderRepository.save(any(Order.class))).thenReturn(order);

        // When
        Order result = orderService.updateOrderStatus(orderId, status);

        // Then
        assertNotNull(result);
        assertEquals(orderId, result.getOrderId());
        assertEquals(status, result.getStatus());
        verify(orderRepository, times(1)).existsById(orderId);
        verify(orderRepository, times(1)).findById(orderId);
        verify(orderRepository, times(1)).save(order);
    }

    @Test
    void testGetOrderDetails_OrderNotFound_ThrowsException() {
        // Given
        Long userId = 1L;
        Long orderId = 1L;

        when(orderRepository.findByOrderIdAndUserId(orderId, userId)).thenReturn(Optional.empty());

        // When, Then
        assertThrows(Exception.class, () -> orderService.getOrderDetails(userId, orderId));
        verify(orderRepository, times(1)).findByOrderIdAndUserId(orderId, userId);
    }
    @Test
    void testConvertToOrderData() {
        // Given
        Order order = new Order();
        order.setOrderId(1L);
        order.setStatus("Pending");
        order.setCreatedAt(null); // Set created date as needed
        order.setUser(null); // Set user as needed
        order.setStore(null); // Set store as needed
        order.setInstructions("Some instructions");
        order.setRating(null); // Set rating as needed

        OrdersResponse.OrderData expectedOrderData = new OrdersResponse.OrderData();
        expectedOrderData.setOrderId(1L);
        expectedOrderData.setOrderStatus("Pending");
        expectedOrderData.setCreatedDate(null); // Set created date as needed
        expectedOrderData.setUserId(null); // Set user ID as needed
        expectedOrderData.setStoreId(null); // Set store ID as needed
        expectedOrderData.setInstructions("Some instructions");
        expectedOrderData.setRating(null); // Set rating as needed

        // When
        OrdersResponse.OrderData result = orderService.convertToOrderData(order);

        // Then
        assertEquals(expectedOrderData.getOrderId(), result.getOrderId());
        assertEquals(expectedOrderData.getOrderStatus(), result.getOrderStatus());
        assertEquals(expectedOrderData.getCreatedDate(), result.getCreatedDate());
        assertEquals(expectedOrderData.getUserId(), result.getUserId());
        assertEquals(expectedOrderData.getStoreId(), result.getStoreId());
        assertEquals(expectedOrderData.getInstructions(), result.getInstructions());
        assertEquals(expectedOrderData.getRating(), result.getRating());
    }

    @Test
    void testConvertToItemData() {
        // Given
        MenuItem menuItem = new MenuItem();
        menuItem.setItemId(1L);
        menuItem.setStoreId(1L);
        menuItem.setItemName("Item");
        menuItem.setItemImage("image.jpg");
        menuItem.setItemPrice("10.00");
        menuItem.setType("Type");
        menuItem.setCategoryId(1L);
        menuItem.setSubcategoryId(1L);
        menuItem.setServingType(1);
        menuItem.setPortion("Portion");
        menuItem.setInStock(true);
        menuItem.setRecommended(true);
        menuItem.setDescription("Description");

        when(categoryRepository.getReferenceById(1L)).thenReturn(null);
        when(subcategoryRepository.getReferenceById(1L)).thenReturn(null);

        OrdersResponse.OrderData.ItemData expectedItemData = new OrdersResponse.OrderData.ItemData();
        expectedItemData.setItemId(1L);
        expectedItemData.setStoreId(1L);
        expectedItemData.setItemName("Item");
        expectedItemData.setItemImage("image.jpg");
        expectedItemData.setItemPrice("10.00");
        expectedItemData.setType("Type");
        expectedItemData.setCategoryId(1L);
        expectedItemData.setCategory(null);
        expectedItemData.setSubCategoryId(1L);
        expectedItemData.setSubCategory(null);
        expectedItemData.setServingType(1);
        expectedItemData.setPortion("Portion");
        expectedItemData.setInStock(true);
        expectedItemData.setIsRecommended(true);
        expectedItemData.setDescription("Description");

        // When
        OrdersResponse.OrderData.ItemData result = orderService.convertToItemData(menuItem);

        // Then
        assertEquals(expectedItemData.getItemId(), result.getItemId());
        assertEquals(expectedItemData.getStoreId(), result.getStoreId());
        assertEquals(expectedItemData.getItemName(), result.getItemName());
        assertEquals(expectedItemData.getItemImage(), result.getItemImage());
        assertEquals(expectedItemData.getItemPrice(), result.getItemPrice());
        assertEquals(expectedItemData.getType(), result.getType());
        assertEquals(expectedItemData.getCategoryId(), result.getCategoryId());
        assertEquals(expectedItemData.getCategory(), result.getCategory());
        assertEquals(expectedItemData.getSubCategoryId(), result.getSubCategoryId());
        assertEquals(expectedItemData.getSubCategory(), result.getSubCategory());
        assertEquals(expectedItemData.getServingType(), result.getServingType());
        assertEquals(expectedItemData.getPortion(), result.getPortion());
        assertEquals(expectedItemData.getInStock(), result.getInStock());
        assertEquals(expectedItemData.getIsRecommended(), result.getIsRecommended());
        assertEquals(expectedItemData.getDescription(), result.getDescription());
    }

    @Test
    void testGetOrdersForStore_Success() throws Exception {
        // Given
        Long storeId = 1L;
        String status = "Pending";
        Integer limit = 10;
        Integer offset = 0;

        // Mock PageRequest and Page
        PageRequest pageRequest = PageRequest.of(offset, limit, Sort.by(Sort.Direction.DESC, "createdAt"));
        Page<Order> ordersPage = mock(Page.class);

        when(orderRepository.findByStoreStoreIdAndStatusOrderByCreatedAtDesc(storeId, status, pageRequest)).thenReturn(ordersPage);
        when(ordersPage.getContent()).thenReturn(Collections.emptyList());

        // When
        OrdersResponse response = orderService.getOrdersForStore(storeId, status, limit, offset);

        // Then
        assertNotNull(response);
        assertEquals(1, response.getCode());
        assertEquals("Success", response.getDescription());
        assertNotNull(response.getData());
        assertEquals(0, response.getData().size());

        verify(orderRepository, times(1)).findByStoreStoreIdAndStatusOrderByCreatedAtDesc(storeId, status, pageRequest);
    }

    @Test
    void testGetOrdersForUser_Success() throws Exception {
        // Given
        Long userId = 1L;
        String status = "Pending";
        Integer limit = 10;
        Integer offset = 0;

        // Mock PageRequest and Page
        PageRequest pageRequest = PageRequest.of(offset, limit, Sort.by(Sort.Direction.DESC, "createdAt"));
        Page<Order> ordersPage = mock(Page.class);

        when(orderRepository.findByUserIdAndStatusOrderByCreatedAtDesc(userId, status, pageRequest)).thenReturn(ordersPage);
        when(ordersPage.getContent()).thenReturn(Collections.emptyList());

        // When
        OrdersResponse response = orderService.getOrdersForUser(userId, status, limit, offset);

        // Then
        assertNotNull(response);
        assertEquals(1, response.getCode());
        assertEquals("Success", response.getDescription());
        assertNotNull(response.getData());
        assertEquals(0, response.getData().size());

        verify(orderRepository, times(1)).findByUserIdAndStatusOrderByCreatedAtDesc(userId, status, pageRequest);
    }

    @Test
    void testGetOrdersForUser_OrdersFound_Success() throws Exception {
        // Given
        Long userId = 1L;
        String status = "Pending";
        Integer limit = 10;
        Integer offset = 0;

        // Mock PageRequest and Page
        PageRequest pageRequest = PageRequest.of(offset, limit, Sort.by(Sort.Direction.DESC, "createdAt"));
        Page<Order> ordersPage = mock(Page.class);

        Order order1 = new Order();
        order1.setOrderId(1L);
        Order order2 = new Order();
        order2.setOrderId(2L);

        when(orderRepository.findByUserIdAndStatusOrderByCreatedAtDesc(userId, status, pageRequest)).thenReturn(ordersPage);
        when(ordersPage.getContent()).thenReturn(Arrays.asList(order1, order2));

        // When
        OrdersResponse response = orderService.getOrdersForUser(userId, status, limit, offset);

        // Then
        assertNotNull(response);
        assertEquals(1, response.getCode());
        assertEquals("Success", response.getDescription());
        assertNotNull(response.getData());
        assertEquals(2, response.getData().size());

        verify(orderRepository, times(1)).findByUserIdAndStatusOrderByCreatedAtDesc(userId, status, pageRequest);
    }

    @Test
    void testGetOrdersForStore_OrdersFound_Success() throws Exception {
        // Given
        Long storeId = 1L;
        String status = "Pending";
        Integer limit = 10;
        Integer offset = 0;

        // Mock PageRequest and Page
        PageRequest pageRequest = PageRequest.of(offset, limit, Sort.by(Sort.Direction.DESC, "createdAt"));
        Page<Order> ordersPage = mock(Page.class);

        Order order1 = new Order();
        order1.setOrderId(1L);
        Order order2 = new Order();
        order2.setOrderId(2L);

        when(orderRepository.findByStoreStoreIdAndStatusOrderByCreatedAtDesc(storeId, status, pageRequest)).thenReturn(ordersPage);
        when(ordersPage.getContent()).thenReturn(Arrays.asList(order1, order2));

        // When
        OrdersResponse response = orderService.getOrdersForStore(storeId, status, limit, offset);

        // Then
        assertNotNull(response);
        assertEquals(1, response.getCode());
        assertEquals("Success", response.getDescription());
        assertNotNull(response.getData());
        assertEquals(2, response.getData().size());

        verify(orderRepository, times(1)).findByStoreStoreIdAndStatusOrderByCreatedAtDesc(storeId, status, pageRequest);
    }

    @Test
    void testCreateOrder_MissingUser_ReturnsNull() {
        // Given
        Long userId = 1L;
        Long storeId = 2L;
        String instructions = "Some instructions";

        CreateOrderRequest request = new CreateOrderRequest();
        request.setUserId(userId);
        request.setStoreId(storeId);
        request.setInstructions(instructions);
        // Ensure that selectedItems is null
        request.setSelectedItems(null);

        when(userRepository.findById(userId)).thenReturn(Optional.empty());


        // When
        CreateOrderResponse response = orderService.createOrder(request);

        // Then
        assertNull(response); // Check that response is null
        verify(userRepository, times(1)).findById(userId); // Verify that findById was called once with the provided userId
        verify(orderRepository, never()).save(any(Order.class)); // Verify that orderRepository.save was never called
        verify(cartItemRepository, never()).save(any(CartItem.class)); // Verify that cartItemRepository.save was never called
    }


    @Test
    void testGetOrderDetails_NonExistentOrder_ThrowsException() {
        // Given
        Long userId = 1L;
        Long orderId = 1L;

        when(orderRepository.findByOrderIdAndUserId(orderId, userId)).thenReturn(Optional.empty());

        // When, Then
        assertThrows(Exception.class, () -> orderService.getOrderDetails(userId, orderId));
        verify(orderRepository, times(1)).findByOrderIdAndUserId(orderId, userId);
    }


}
