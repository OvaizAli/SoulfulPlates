package com.Group11.soulfulplates.payload.response;

import org.junit.jupiter.api.Test;
import org.mockito.Mock;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class OrdersResponseTest {

    @Mock
    private OrdersResponse mockedOrdersResponse;

    @Mock
    private OrdersResponse.OrderData mockedOrderData;

    @Mock
    private OrdersResponse.OrderData.ItemData mockedItemData;

    @Test
    public void testConstructorAndGetters() {
        Integer code = 200;
        String description = "Success";
        List<OrdersResponse.OrderData> data = new ArrayList<>();

        // Mocking order data
        OrdersResponse.OrderData mockedOrderData = mock(OrdersResponse.OrderData.class);
        when(mockedOrderData.getOrderId()).thenReturn(1L);
        when(mockedOrderData.getOrderStatus()).thenReturn("Pending");
        when(mockedOrderData.getCreatedDate()).thenReturn(new Date());
        when(mockedOrderData.getUserId()).thenReturn(100L);
        when(mockedOrderData.getStoreId()).thenReturn(10L);
        when(mockedOrderData.getRating()).thenReturn(4);
        when(mockedOrderData.getFeedback()).thenReturn("Good service");
        when(mockedOrderData.getPaymentStatus()).thenReturn("Paid");
        when(mockedOrderData.getTotalAmount()).thenReturn(50.0);
        when(mockedOrderData.getInstructions()).thenReturn("Handle with care");
        List<OrdersResponse.OrderData.ItemData> items = new ArrayList<>();

        // Mocking item data
        OrdersResponse.OrderData.ItemData mockedItemData = mock(OrdersResponse.OrderData.ItemData.class);
        when(mockedItemData.getItemId()).thenReturn(1L);
        when(mockedItemData.getStoreId()).thenReturn(10L);
        when(mockedItemData.getItemName()).thenReturn("Burger");
        when(mockedItemData.getItemPrice()).thenReturn("10.00");
        when(mockedItemData.getType()).thenReturn("Fast Food");
        when(mockedItemData.getCategoryId()).thenReturn(1L);
        when(mockedItemData.getCategory()).thenReturn("Food");
        when(mockedItemData.getSubCategoryId()).thenReturn(1L);
        when(mockedItemData.getSubCategory()).thenReturn("Burger");
        when(mockedItemData.getServingType()).thenReturn(1);
        when(mockedItemData.getPortion()).thenReturn("Large");
        when(mockedItemData.getInStock()).thenReturn(true);
        when(mockedItemData.getIsRecommended()).thenReturn(true);
        when(mockedItemData.getDescription()).thenReturn("Tasty burger");

        items.add(mockedItemData);
        when(mockedOrderData.getItems()).thenReturn(items);
        data.add(mockedOrderData);

        OrdersResponse ordersResponse = new OrdersResponse(code, description, data);

        // Assertions
        assertNotNull(ordersResponse);
        assertEquals(code, ordersResponse.getCode());
        assertEquals(description, ordersResponse.getDescription());
        assertEquals(data.size(), ordersResponse.getData().size());
        assertEquals(1L, ordersResponse.getData().get(0).getOrderId());
        assertEquals("Pending", ordersResponse.getData().get(0).getOrderStatus());
        assertEquals(1, ordersResponse.getData().get(0).getItems().size());
        assertEquals("Burger", ordersResponse.getData().get(0).getItems().get(0).getItemName());
    }

    @Test
    public void testSetters() {
        // Initialize a mock OrdersResponse instance
        OrdersResponse ordersResponse = new OrdersResponse();

        // Mock the setters
        Integer newCode = 404;
        String newDescription = "Not Found";
        List<OrdersResponse.OrderData> newData = new ArrayList<>();
        ordersResponse.setCode(newCode);
        ordersResponse.setDescription(newDescription);
        ordersResponse.setData(newData);

        // Verify that the setters were called with the expected values
        assertEquals(newCode, ordersResponse.getCode());
        assertEquals(newDescription, ordersResponse.getDescription());
        assertEquals(newData, ordersResponse.getData());
    }

    @Test
    public void testEmptyConstructor() {
        // Initialize a mock OrdersResponse instance
        OrdersResponse ordersResponse = new OrdersResponse();

        // Verify that the values are null after initialization
        assertNull(ordersResponse.getCode());
        assertNull(ordersResponse.getDescription());
        assertNull(ordersResponse.getData());
    }

    @Test
    public void testOrderDataConstructor() {
        // Initialize a mock OrderData instance
        OrdersResponse.OrderData orderData = new OrdersResponse.OrderData();

        // Verify that all fields are null after initialization
        assertNull(orderData.getOrderId());
        assertNull(orderData.getOrderStatus());
        assertNull(orderData.getCreatedDate());
        assertNull(orderData.getUserId());
        assertNull(orderData.getStoreId());
        assertNull(orderData.getRating());
        assertNull(orderData.getFeedback());
        assertNull(orderData.getPaymentStatus());
        assertNull(orderData.getTotalAmount());
        assertNull(orderData.getInstructions());
        assertNull(orderData.getItems());
    }

    @Test
    public void testItemDataConstructor() {
        // Initialize a mock ItemData instance
        OrdersResponse.OrderData.ItemData itemData = new OrdersResponse.OrderData.ItemData();

        // Verify that all fields are null after initialization
        assertNull(itemData.getItemId());
        assertNull(itemData.getStoreId());
        assertNull(itemData.getItemName());
        assertNull(itemData.getItemImage());
        assertNull(itemData.getItemPrice());
        assertNull(itemData.getType());
        assertNull(itemData.getCategoryId());
        assertNull(itemData.getCategory());
        assertNull(itemData.getSubCategoryId());
        assertNull(itemData.getSubCategory());
        assertNull(itemData.getServingType());
        assertNull(itemData.getPortion());
        assertNull(itemData.getInStock());
        assertNull(itemData.getIsRecommended());
        assertNull(itemData.getDescription());
    }
}




