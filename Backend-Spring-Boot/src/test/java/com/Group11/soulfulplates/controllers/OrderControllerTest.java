package com.Group11.soulfulplates.controllers;

import com.Group11.soulfulplates.models.Order;
import com.Group11.soulfulplates.payload.request.CreateOrderRequest;
import com.Group11.soulfulplates.payload.request.GetOrderDetailsRequest;
import com.Group11.soulfulplates.payload.request.GetOrdersRequest;
import com.Group11.soulfulplates.payload.request.GetStoreOrders;
import com.Group11.soulfulplates.payload.response.CreateOrderResponse;
import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.Group11.soulfulplates.payload.response.OrderDetailsResponse;
import com.Group11.soulfulplates.payload.response.OrdersResponse;
import com.Group11.soulfulplates.services.OrderService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

class OrderControllerTest {

    @Mock
    private OrderService orderService;

    @InjectMocks
    private OrderController orderController;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }


    @Test
    void testUpdateOrderStatus() {
        // Mock data
        OrderController.UpdateOrderStatusRequest request = new OrderController.UpdateOrderStatusRequest();
        request.setOrderId(1L);
        request.setStatus("status");
        Order order = new Order();

        // Mock service method
        when(orderService.updateOrderStatus(anyLong(), anyString())).thenReturn(order);

        // Call controller method
        ResponseEntity<?> result = orderController.updateOrderStatus(request);

        // Assertions
        assertEquals(HttpStatus.OK, result.getStatusCode());
        assertEquals(new MessageResponse(1, null, "Order status updated."), result.getBody());
    }

    @Test
    void testGetOrderDetails() throws Exception {
        // Mock data
        GetOrderDetailsRequest request = mock(GetOrderDetailsRequest.class);
        OrderDetailsResponse response = mock(OrderDetailsResponse.class);

        // Mock service method
        when(orderService.getOrderDetails(anyLong(), anyLong())).thenReturn(response);

        // Call controller method
        ResponseEntity<OrderDetailsResponse> result = orderController.getOrderDetails(request);

        // Assertions
        assertEquals(HttpStatus.OK, result.getStatusCode());
        assertEquals(response, result.getBody());
    }

    @Test
    void testCreateOrder() {
        // Mock data
        CreateOrderRequest request = mock(CreateOrderRequest.class);
        CreateOrderResponse response = mock(CreateOrderResponse.class);

        // Mock service method
        when(orderService.createOrder(request)).thenReturn(response);

        // Call controller method
        ResponseEntity<CreateOrderResponse> result = orderController.createOrder(request);

        // Assertions
        assertEquals(HttpStatus.CREATED, result.getStatusCode());
        assertEquals(response, result.getBody());
    }

    @Test
    void testGetOrdersForUser() throws Exception {
        // Mock data
        GetOrdersRequest request = new GetOrdersRequest();
        request.setUserId(1L);
        request.setStatus("status");
        request.setLimit(10);
        request.setOffset(0);
        OrdersResponse response = mock(OrdersResponse.class);

        // Mock service method
        when(orderService.getOrdersForUser(anyLong(), anyString(), anyInt(), anyInt())).thenReturn(response);

        // Call controller method
        ResponseEntity<?> result = orderController.getOrdersForUser(request);

        // Assertions
        assertEquals(HttpStatus.OK, result.getStatusCode());
        assertEquals(response, result.getBody());
    }

    @Test
    void testGetOrdersForStore() throws Exception {
        // Mock data
        GetStoreOrders request = new GetStoreOrders();
        request.setStoreId(1L);
        request.setStatus("status");
        request.setLimit(10);
        request.setOffset(0);
        OrdersResponse response = mock(OrdersResponse.class);

        // Mock service method
        when(orderService.getOrdersForStore(anyLong(), anyString(), anyInt(), anyInt())).thenReturn(response);

        // Call controller method
        ResponseEntity<?> result = orderController.getOrdersForStore(request);

        // Assertions
        assertEquals(HttpStatus.OK, result.getStatusCode());
        assertEquals(response, result.getBody());
    }

    @Test
    void testGetOrderDetails_ExceptionCaught() throws Exception {
        // Mock data
        GetOrderDetailsRequest request = new GetOrderDetailsRequest();
        request.setUserId(1L);
        request.setOrderId(123L);
        Exception exception = new RuntimeException("Some error occurred.");

        // Mock service behavior
        when(orderService.getOrderDetails(request.getUserId(), request.getOrderId())).thenThrow(exception);

        // Call the method
        ResponseEntity<OrderDetailsResponse> responseEntity = orderController.getOrderDetails(request);

        // Assertions
        assertEquals(-1, responseEntity.getBody().getCode());
        assertEquals("Error getting order details:", responseEntity.getBody().getDescription());
        assertEquals(null, responseEntity.getBody().getData());

        // Verify behavior
        verify(orderService, times(1)).getOrderDetails(request.getUserId(), request.getOrderId());
    }

    @Test
    void getOrdersForUser_ExceptionCaught() throws Exception {
        // Mock data
        GetOrdersRequest request = new GetOrdersRequest();
        request.setUserId(1L);
        request.setStatus("pending");
        request.setLimit(10);
        request.setOffset(0);
        Exception exception = new RuntimeException("Some error occurred.");

        // Mock service behavior
        when(orderService.getOrdersForUser(request.getUserId(), request.getStatus(), request.getLimit(), request.getOffset()))
                .thenThrow(exception);

        // Call the method
        ResponseEntity responseEntity = orderController.getOrdersForUser(request);

        // Assertions
        assertEquals(400, responseEntity.getStatusCodeValue());
        // Assuming you meant to create an OrderDetailsResponse instance, not an OrdersResponse instance
        assertEquals(-1, ((OrderDetailsResponse) responseEntity.getBody()).getCode());
        assertEquals("Error getting order details: Some error occurred.", ((OrderDetailsResponse) responseEntity.getBody()).getDescription());
        assertEquals(null, ((OrderDetailsResponse) responseEntity.getBody()).getData());

        // Verify behavior
        verify(orderService, times(1))
                .getOrdersForUser(request.getUserId(), request.getStatus(), request.getLimit(), request.getOffset());
    }

    @Test
    void getOrdersForStore_ExceptionCaught() throws Exception {
        // Mock data
        GetStoreOrders request = new GetStoreOrders();
        request.setStoreId(1L);
        request.setStatus("pending");
        request.setLimit(10);
        request.setOffset(0);
        Exception exception = new RuntimeException("Some error occurred.");

        // Mock service behavior
        when(orderService.getOrdersForStore(request.getStoreId(), request.getStatus(), request.getLimit(), request.getOffset()))
                .thenThrow(exception);

        // Call the method
        ResponseEntity responseEntity = orderController.getOrdersForStore(request);

        // Assertions
        assertEquals(400, responseEntity.getStatusCodeValue());
        // Assuming you meant to create an OrderDetailsResponse instance, not an OrdersResponse instance
        assertEquals(-1, ((OrderDetailsResponse) responseEntity.getBody()).getCode());
        assertEquals("Error getting order details: Some error occurred.", ((OrderDetailsResponse) responseEntity.getBody()).getDescription());
        assertEquals(null, ((OrderDetailsResponse) responseEntity.getBody()).getData());

        // Verify behavior
        verify(orderService, times(1))
                .getOrdersForStore(request.getStoreId(), request.getStatus(), request.getLimit(), request.getOffset());
    }
}

