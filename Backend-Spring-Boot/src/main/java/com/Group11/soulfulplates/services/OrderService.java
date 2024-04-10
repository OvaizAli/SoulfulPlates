package com.Group11.soulfulplates.services;

import com.Group11.soulfulplates.models.Order;
import com.Group11.soulfulplates.payload.request.CreateOrderRequest;
import com.Group11.soulfulplates.payload.response.CreateOrderResponse;
import com.Group11.soulfulplates.payload.response.OrderDetailsResponse;
import com.Group11.soulfulplates.payload.response.OrdersResponse;

/**
 This service interface defines methods related to order management.
 It provides functionality to create orders, update order status, retrieve order details, and retrieve orders for users and stores.
 Additionally, it includes a method to get the order count for a store in a specific month.
 */

public interface OrderService {
    CreateOrderResponse createOrder(CreateOrderRequest request);
    Order updateOrderStatus(Long orderId, String status);
    OrderDetailsResponse getOrderDetails(Long userId, Long orderId) throws Exception;
    OrdersResponse getOrdersForUser(Long userId, String status, Integer limit, Integer offset) throws Exception;
    OrdersResponse getOrdersForStore(Long storeId, String status, Integer limit, Integer offset) throws Exception;
    Long getOrderCountForStoreAndMonth(int storeId, int month);
}
