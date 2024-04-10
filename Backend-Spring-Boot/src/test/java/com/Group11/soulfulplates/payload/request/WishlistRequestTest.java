package com.Group11.soulfulplates.payload.request;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class WishlistRequestTest {

    @Test
    public void testEmptyConstructor() {
        WishlistRequest wishlistRequest = new WishlistRequest();
        assertNotNull(wishlistRequest);
        assertNull(wishlistRequest.getUserId());
        assertNull(wishlistRequest.getStoreId());
        assertNull(wishlistRequest.getStoreEmail());
        assertNull(wishlistRequest.getStoreName());
        assertNull(wishlistRequest.getMenuItemId());
        assertNull(wishlistRequest.getItemName());
        assertEquals(0.0, wishlistRequest.getItemPrice());
    }

    @Test
    public void testParameterizedConstructor() {
        Long userId = 1L;
        Long storeId = 2L;
        String storeEmail = "example@store.com";
        String storeName = "Example Store";
        Long menuItemId = 3L;
        String itemName = "Example Item";
        double itemPrice = 10.0;

        WishlistRequest wishlistRequest = new WishlistRequest(userId, storeId, storeEmail, storeName, menuItemId, itemName, itemPrice);

        assertEquals(userId, wishlistRequest.getUserId());
        assertEquals(storeId, wishlistRequest.getStoreId());
        assertEquals(storeEmail, wishlistRequest.getStoreEmail());
        assertEquals(storeName, wishlistRequest.getStoreName());
        assertEquals(menuItemId, wishlistRequest.getMenuItemId());
        assertEquals(itemName, wishlistRequest.getItemName());
        assertEquals(itemPrice, wishlistRequest.getItemPrice());
    }

    @Test
    public void testSettersAndGetters() {
        WishlistRequest wishlistRequest = new WishlistRequest();

        wishlistRequest.setUserId(1L);
        wishlistRequest.setStoreId(2L);
        wishlistRequest.setStoreEmail("example@store.com");
        wishlistRequest.setStoreName("Example Store");
        wishlistRequest.setMenuItemId(3L);
        wishlistRequest.setItemName("Example Item");
        wishlistRequest.setItemPrice(10.0);

        assertEquals(1L, wishlistRequest.getUserId());
        assertEquals(2L, wishlistRequest.getStoreId());
        assertEquals("example@store.com", wishlistRequest.getStoreEmail());
        assertEquals("Example Store", wishlistRequest.getStoreName());
        assertEquals(3L, wishlistRequest.getMenuItemId());
        assertEquals("Example Item", wishlistRequest.getItemName());
        assertEquals(10.0, wishlistRequest.getItemPrice());
    }
}
