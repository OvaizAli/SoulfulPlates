package com.Group11.soulfulplates.payload.response;

import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class OrderDetailsResponseTest {

    @Test
    public void testOrderDetailsResponse() {
        Integer code = 200;
        String description = "Success";
        OrderDetailsResponse.OrderDetails orderDetails = createOrderDetails();
        OrderDetailsResponse orderDetailsResponse = new OrderDetailsResponse(code, description, orderDetails);

        assertEquals(code, orderDetailsResponse.getCode());
        assertEquals(description, orderDetailsResponse.getDescription());
        assertNotNull(orderDetailsResponse.getData());
        assertEquals(orderDetails, orderDetailsResponse.getData());
    }

    private OrderDetailsResponse.OrderDetails createOrderDetails() {
        OrderDetailsResponse.OrderDetails orderDetails = new OrderDetailsResponse.OrderDetails();
        orderDetails.setOrderId(1L);
        orderDetails.setOrderStatus("Pending");
        orderDetails.setCreatedDate(new Date());
        orderDetails.setUserId(101L);
        orderDetails.setStoreId(201L);
        orderDetails.setRating(4);
        orderDetails.setFeedback("Great service!");
        orderDetails.setPaymentStatus("Paid");
        orderDetails.setTotalAmount(50.99);
        orderDetails.setInstructions("No onions please");

        List<OrderDetailsResponse.OrderDetails.MenuItemDTO> items = new ArrayList<>();
        OrderDetailsResponse.OrderDetails.MenuItemDTO menuItemDTO = new OrderDetailsResponse.OrderDetails.MenuItemDTO();
        menuItemDTO.setItemId(1L);
        menuItemDTO.setStoreId(201L);
        menuItemDTO.setItemName("Burger");
        menuItemDTO.setItemImage("burger.jpg");
        menuItemDTO.setItemPrice("$9.99");
        menuItemDTO.setType("Main Course");
        menuItemDTO.setCategoryId(301L);
        menuItemDTO.setCategory("Fast Food");
        menuItemDTO.setSubCategoryId(401L);
        menuItemDTO.setSubCategory("Burgers");
        menuItemDTO.setServingType(1);
        menuItemDTO.setPortion("Regular");
        menuItemDTO.setInStock(true);
        menuItemDTO.setIsRecommended(true);
        menuItemDTO.setDescription("Delicious burger with fries");
        items.add(menuItemDTO);

        orderDetails.setItems(items);

        return orderDetails;
    }
}
