package com.Group11.soulfulplates.payload.response;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class MenuItemResponseTest {

    @Test
    public void testMenuItemResponse() {
        Long itemId = 1L;
        String itemName = "Test Item";
        String description = "Test description";
        String itemPrice = "$10.99";
        String type = "Main Course";
        boolean inStock = true;
        String itemImage = "image.jpg";
        int servingType = 2;
        String portion = "Regular";
        String categoryName = "Main Dishes";
        String subcategoryName = "Pasta";
        boolean recommended = true;
        Long subcategoryId = 101L;
        Long categoryId = 201L;

        MenuItemResponse menuItemResponse = new MenuItemResponse();
        menuItemResponse.setItemId(itemId);
        menuItemResponse.setItemName(itemName);
        menuItemResponse.setDescription(description);
        menuItemResponse.setItemPrice(itemPrice);
        menuItemResponse.setType(type);
        menuItemResponse.setInStock(inStock);
        menuItemResponse.setItemImage(itemImage);
        menuItemResponse.setServingType(servingType);
        menuItemResponse.setPortion(portion);
        menuItemResponse.setCategoryName(categoryName);
        menuItemResponse.setSubcategoryName(subcategoryName);
        menuItemResponse.setRecommended(recommended);
        menuItemResponse.setSubcategoryId(subcategoryId);
        menuItemResponse.setCategoryId(categoryId);

        // Verify that values are set correctly
        assertEquals(itemId, menuItemResponse.getItemId());
        assertEquals(itemName, menuItemResponse.getItemName());
        assertEquals(description, menuItemResponse.getDescription());
        assertEquals(itemPrice, menuItemResponse.getItemPrice());
        assertEquals(type, menuItemResponse.getType());
        assertTrue(menuItemResponse.isInStock());
        assertEquals(itemImage, menuItemResponse.getItemImage());
        assertEquals(servingType, menuItemResponse.getServingType());
        assertEquals(portion, menuItemResponse.getPortion());
        assertEquals(categoryName, menuItemResponse.getCategoryName());
        assertEquals(subcategoryName, menuItemResponse.getSubcategoryName());
        assertTrue(menuItemResponse.isRecommended());
        assertEquals(subcategoryId, menuItemResponse.getSubcategoryId());
        assertEquals(categoryId, menuItemResponse.getCategoryId());
    }

    @Test
    public void testMenuItemResponseDefaultValues() {
        MenuItemResponse menuItemResponse = new MenuItemResponse();

        // Verify default values
        assertEquals(null, menuItemResponse.getItemId());
        assertEquals(null, menuItemResponse.getItemName());
        assertEquals(null, menuItemResponse.getDescription());
        assertEquals(null, menuItemResponse.getItemPrice());
        assertEquals(null, menuItemResponse.getType());
        assertFalse(menuItemResponse.isInStock());
        assertEquals(null, menuItemResponse.getItemImage());
        assertEquals(0, menuItemResponse.getServingType());
        assertEquals(null, menuItemResponse.getPortion());
        assertEquals(null, menuItemResponse.getCategoryName());
        assertEquals(null, menuItemResponse.getSubcategoryName());
        assertFalse(menuItemResponse.isRecommended());
        assertEquals(null, menuItemResponse.getSubcategoryId());
        assertEquals(null, menuItemResponse.getCategoryId());
    }
}
