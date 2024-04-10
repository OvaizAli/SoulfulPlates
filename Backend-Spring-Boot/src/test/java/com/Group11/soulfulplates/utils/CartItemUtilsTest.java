package com.Group11.soulfulplates.utils;

import com.Group11.soulfulplates.models.CartItem;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

class CartItemUtilsTest {

    @Test
    void testExtractItemIds() {
        List<CartItem> cartItems = new ArrayList<>();
        CartItem item1 = new CartItem();
        item1.setItemId(1L);
        cartItems.add(item1);

        CartItem item2 = new CartItem();
        item2.setItemId(2L);
        cartItems.add(item2);

        CartItem item3 = new CartItem();
        item3.setItemId(3L);
        cartItems.add(item3);

        List<Long> expectedItemIds = List.of(1L, 2L, 3L);
        assertEquals(expectedItemIds, CartItemUtils.extractItemIds(cartItems));
    }

    @Test
    void testGetTotalForOrderId() {
        List<CartItem> cartItems = new ArrayList<>();
        CartItem item1 = new CartItem();
        item1.setPrice(10.0);
        item1.setQuantity(2);
        cartItems.add(item1);

        CartItem item2 = new CartItem();
        item2.setPrice(20.0);
        item2.setQuantity(3);
        cartItems.add(item2);

        CartItem item3 = new CartItem();
        item3.setPrice(30.0);
        item3.setQuantity(1);
        cartItems.add(item3);

        // Total = (10 * 2) + (20 * 3) + (30 * 1) = 20 + 60 + 30 = 110.0
        assertEquals(110.0, CartItemUtils.getTotalForOrderId(cartItems));
    }
}
