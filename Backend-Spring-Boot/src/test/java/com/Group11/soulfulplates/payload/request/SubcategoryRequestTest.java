package com.Group11.soulfulplates.payload.request;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class SubcategoryRequestTest {

    @Test
    public void testEmptyConstructorSetsDefaultValues() {
        SubcategoryRequest request = new SubcategoryRequest();

        assertNull(request.getCategoryId());
        assertNull(request.getSubcategoryName());
        assertNull(request.getStoreId());
    }

    @Test
    public void testSetterMethodsUpdateFieldsCorrectly() {
        SubcategoryRequest request = new SubcategoryRequest();

        Long expectedCategoryId = 1L;
        String expectedSubcategoryName = "Desserts";
        Long expectedStoreId = 5L;

        request.setCategoryId(expectedCategoryId);
        request.setSubcategoryName(expectedSubcategoryName);
        request.setStoreId(expectedStoreId);

        assertEquals(expectedCategoryId, request.getCategoryId());
        assertEquals(expectedSubcategoryName, request.getSubcategoryName());
        assertEquals(expectedStoreId, request.getStoreId());
    }
}
