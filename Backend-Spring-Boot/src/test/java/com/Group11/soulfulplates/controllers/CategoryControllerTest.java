package com.Group11.soulfulplates.controllers;

import com.Group11.soulfulplates.models.Category;
import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.Group11.soulfulplates.payload.response.OrderDetailsResponse;
import com.Group11.soulfulplates.services.impl.CategoryServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class CategoryControllerTest {

    @Mock
    private CategoryServiceImpl categoryService;



    @InjectMocks
    private CategoryController categoryController;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testCreateCategory() {
        // Mock data
        Category request = new Category();
        request.setCategoryName("Test Category");
        request.setStoreId("1");

        // Mock service method
        when(categoryService.createCategory(any(Category.class))).thenReturn(request);

        // Call controller method
        ResponseEntity<?> responseEntity = categoryController.createCategory(request);

        // Then
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Category created.", ((MessageResponse) responseEntity.getBody()).getDescription());
        assertEquals(request, ((MessageResponse) responseEntity.getBody()).getData());
    }

    @Test
    void testEditCategory() {
        // Mock data
        Long categoryId = 1L;
        Category request = new Category();
        request.setCategoryId(categoryId);
        request.setCategoryName("Updated Test Category");

        // Mock service method
        when(categoryService.findById(categoryId)).thenReturn(request);

        // Call controller method
        ResponseEntity<?> responseEntity = categoryController.updateCategory( categoryId,request);

        // Then
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Category updated.", ((MessageResponse) responseEntity.getBody()).getDescription());
    }

    @Test
    void testDeleteCategory() {
        // Mock data
        Long categoryId = 1L;

        // Mock service method
        doNothing().when(categoryService).deleteCategory(categoryId);
        when(categoryService.findById(categoryId)).thenReturn(new Category());

        // Call controller method
        ResponseEntity<?> responseEntity = categoryController.deleteCategory(categoryId);

        // Assertions
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Category deleted.", ((MessageResponse) responseEntity.getBody()).getDescription());
        assertNull(((MessageResponse) responseEntity.getBody()).getData());

        // Verify service method invocation
        verify(categoryService, times(1)).deleteCategory(categoryId);
    }

    @Test
    void testGetAllByStoreId() {

        // Mock service method
        when(categoryService.getAllByStoreId()).thenReturn( new ArrayList<>());

        // Call controller method
        ResponseEntity<?> responseEntity = categoryController.getAllByStoreId();

        // Assertions
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Category fetched.", ((MessageResponse) responseEntity.getBody()).getDescription());
        assertEquals(new ArrayList<>(),((MessageResponse) responseEntity.getBody()).getData());
    }

    @Test
    void testCategoriesByStoreId() {

        // Mock service method
        when(categoryService.getCategoriesByStore(anyLong())).thenReturn( new ArrayList<>());

        // Call controller method
        ResponseEntity<?> responseEntity = categoryController.getCategoriesByStore(1L);

        // Assertions
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Category fetched.", ((MessageResponse) responseEntity.getBody()).getDescription());
        assertEquals(new ArrayList<>(),((MessageResponse) responseEntity.getBody()).getData());
    }

    @Test
    void testCreateCategory_Error() {
        // Mock data
        Category request = new Category();
        request.setCategoryName("Test Category");
        request.setStoreId("1");

        // Mock service method to throw an exception
        when(categoryService.createCategory(any(Category.class))).thenThrow(new RuntimeException("Create failed"));

        // Call controller method
        ResponseEntity<?> responseEntity = categoryController.createCategory(request);

        // Then
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        assertEquals(-1, ((OrderDetailsResponse) responseEntity.getBody()).getCode());
        assertEquals("Error creating category: Create failed", ((OrderDetailsResponse) responseEntity.getBody()).getDescription());
    }

    @Test
    void testEditCategory_Error() {
        // Mock data
        Long categoryId = 1L;
        Category request = new Category();
        request.setCategoryId(categoryId);
        request.setCategoryName("Updated Test Category");

        // Mock service method to throw an exception
        when(categoryService.updateCategory(categoryId, request)).thenThrow(new RuntimeException("Update failed"));

        // Call controller method
        ResponseEntity<?> responseEntity = categoryController.updateCategory(categoryId, request);

        // Then
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        assertEquals(-1, ((OrderDetailsResponse) responseEntity.getBody()).getCode());
        assertEquals("Error updating category: Update failed", ((OrderDetailsResponse) responseEntity.getBody()).getDescription());
    }



    @Test
    void testDeleteCategory_Error() {
        // Mock data
        Long categoryId = 1L;

        // Mock service method to throw an exception
        doThrow(new RuntimeException("Test exception")).when(categoryService).deleteCategory(categoryId);

        // Call controller method
        ResponseEntity<OrderDetailsResponse> responseEntity = categoryController.deleteCategory(categoryId);

        // Assertions
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        assertEquals(-1, responseEntity.getBody().getCode());
        assertEquals("Error deleting category: Test exception", responseEntity.getBody().getDescription());
        assertNull(responseEntity.getBody().getData());
    }

    @Test
    void testGetAllByStoreId_Error() {
        // Mock service method to throw an exception
        when(categoryService.getAllByStoreId()).thenThrow(new RuntimeException("Test exception"));

        // Call controller method
        ResponseEntity<?> responseEntity = categoryController.getAllByStoreId();

        // Assertions
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        assertEquals(-1, ((OrderDetailsResponse) responseEntity.getBody()).getCode());
        assertEquals("Error fetching categories: Test exception", ((OrderDetailsResponse) responseEntity.getBody()).getDescription());
        assertNull(((OrderDetailsResponse) responseEntity.getBody()).getData());
    }


}
