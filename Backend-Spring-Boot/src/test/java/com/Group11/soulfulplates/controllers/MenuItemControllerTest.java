package com.Group11.soulfulplates.controllers;

import com.Group11.soulfulplates.models.MenuItem;
import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.Group11.soulfulplates.payload.response.OrderDetailsResponse;
import com.Group11.soulfulplates.services.impl.MenuItemServiceImpl;
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
import static org.mockito.Mockito.*;

class MenuItemControllerTest {

    @Mock
    private MenuItemServiceImpl menuItemService;

    @InjectMocks
    private MenuItemController menuItemController;
    private Long validMenuItemId;
    private MenuItem validMenuItem;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this); // Initialize mocks
        validMenuItemId = 1L;
        validMenuItem = new MenuItem();
        validMenuItem.setItemName("Test Item");
        validMenuItem.setStoreId(1L);
        validMenuItem.setItemImage("");
        validMenuItem.setItemPrice("10.1");
        validMenuItem.setCategoryId(1L);
        validMenuItem.setSubcategoryId(1L);
        validMenuItem.setInStock(true);
        validMenuItem.setRecommended(true);
        validMenuItem.setPortion("2");
        validMenuItem.setServingType(2);
        validMenuItem.setDescription("Description");
        validMenuItem.setType("Veg");
        validMenuItem.setItemId(validMenuItemId);
    }

    @Test
    void testCreateMenuItem_ValidMenuItem_Success() {
        // Given
        MenuItem menuItem = new MenuItem();
        menuItem.setItemName("Test Item");
        menuItem.setStoreId(1L);
        menuItem.setItemImage("");
        menuItem.setItemPrice("10.1");
        menuItem.setCategoryId(1L);
        menuItem.setSubcategoryId(1L);
        menuItem.setInStock(true);
        menuItem.setRecommended(true);
        menuItem.setPortion("2");
        menuItem.setServingType(2);
        menuItem.setDescription("Description");
        menuItem.setType("Veg");

        when(menuItemService.createMenuItem(any(MenuItem.class))).thenReturn(menuItem);
        // When
        ResponseEntity responseEntity = menuItemController.createMenuItem(menuItem);

        // Then

        // Then
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Menu item created.",  ((MessageResponse) responseEntity.getBody()).getDescription());
        assertEquals(menuItem, ((MessageResponse) responseEntity.getBody()).getData());


        verify(menuItemService).createMenuItem(any());
    }


    @Test
    void testEditMenuItem_MenuItemExists_Success() {
        // Given
        Long menuItemId = 1L;
        MenuItem menuItem = new MenuItem();
        menuItem.setItemId(menuItemId);
        menuItem.setItemName("Test Item");
        menuItem.setStoreId(1L);
        menuItem.setItemImage("");
        menuItem.setItemPrice("10.1");
        menuItem.setCategoryId(1L);
        menuItem.setSubcategoryId(1L);
        menuItem.setInStock(true);
        menuItem.setRecommended(true);
        menuItem.setPortion("2");
        menuItem.setServingType(2);
        menuItem.setDescription("Description");
        menuItem.setType("Veg");

        MenuItem existingMenuItem = new MenuItem();

        //When
        when(menuItemService.findMenuById(menuItemId)).thenReturn(existingMenuItem);

        // Call controller method
        ResponseEntity<?> responseEntity = menuItemController.updateMenuItem( menuItemId,menuItem);

        // Then
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Menu item updated.", ((MessageResponse) responseEntity.getBody()).getDescription());
    }


    @Test
    void testDeleteCategory() {
        // Mock data
        Long menuItemId = 1L;
        MenuItem menuItem = new MenuItem();
        menuItem.setItemId(menuItemId);
        menuItem.setItemName("Test Item");
        menuItem.setStoreId(1L);
        menuItem.setItemImage("");
        menuItem.setItemPrice("10.1");
        menuItem.setCategoryId(1L);
        menuItem.setSubcategoryId(1L);
        menuItem.setInStock(true);
        menuItem.setRecommended(true);
        menuItem.setPortion("2");
        menuItem.setServingType(2);
        menuItem.setDescription("Description");
        menuItem.setType("Veg");

        // Mock service method
        doNothing().when(menuItemService).deleteMenuItem(menuItemId);
        when(menuItemService.findMenuById(menuItemId)).thenReturn(new MenuItem());

        // Call controller method
        ResponseEntity<?> responseEntity = menuItemController.deleteMenuItem(menuItemId);

        // Assertions
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Menu item deleted." ,((MessageResponse) responseEntity.getBody()).getDescription());
        assertNull(((MessageResponse) responseEntity.getBody()).getData());

        // Verify service method invocation
        verify(menuItemService, times(1)).deleteMenuItem(menuItemId);
    }



    @Test
    void testGetAllMenuItemsWithDetails() {

        // Mock service method
        when(menuItemService.getAllMenuItemsWithDetails()).thenReturn( new ArrayList<>());

        // Call controller method
        ResponseEntity<?> responseEntity = menuItemController.getAllMenuItemsWithDetails();

        // Assertions
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Menu item fetched.", ((MessageResponse) responseEntity.getBody()).getDescription());
        assertEquals(new ArrayList<>(),((MessageResponse) responseEntity.getBody()).getData());
    }

    @Test
    void testGetAllMenuItemsWithDetailsByStoreId() {

        // Mock service method
        when(menuItemService.getAllMenuItemsWithDetails()).thenReturn( new ArrayList<>());

        // Call controller method
        ResponseEntity<?> responseEntity = menuItemController.getAllMenuItemsWithDetails(1L);

        // Assertions
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Menu item fetched.", ((MessageResponse) responseEntity.getBody()).getDescription());
        assertEquals(new ArrayList<>(),((MessageResponse) responseEntity.getBody()).getData());
    }

    @Test
    public void testDeleteMenuItemFailure() {
        Long menuItemId = 1L;
        String errorMessage = "Some error occurred.";
        doThrow(new RuntimeException(errorMessage)).when(menuItemService).deleteMenuItem(menuItemId);

        ResponseEntity<?> responseEntity = menuItemController.deleteMenuItem(menuItemId);

        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        assertEquals("Error deleting menu item: " + errorMessage, ((MessageResponse)responseEntity.getBody()).getDescription());
        verify(menuItemService, times(1)).deleteMenuItem(menuItemId);
    }

    @Test
    void testCreateMenuItem_ServiceException() {
        // Given
        MenuItem menuItem = new MenuItem();

        // Stub the service method to throw an exception
        when(menuItemService.createMenuItem(any(MenuItem.class))).thenThrow(new RuntimeException("Service exception"));

        // When
        ResponseEntity responseEntity = menuItemController.createMenuItem(menuItem);

        // Then
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        assertEquals(-1, ((OrderDetailsResponse) responseEntity.getBody()).getCode());
        assertEquals("Error creating menu item: Service exception", ((OrderDetailsResponse) responseEntity.getBody()).getDescription());

        verify(menuItemService).createMenuItem(any());
    }

    @Test
    void testDeleteMenuItem_ServiceException() {
        // Given
        Long menuItemId = 1L;

        // Stub the service method to throw an exception
        doThrow(new RuntimeException("Service exception")).when(menuItemService).deleteMenuItem(menuItemId);

        // When
        ResponseEntity responseEntity = menuItemController.deleteMenuItem(menuItemId);

        // Then
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        assertEquals(-1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Error deleting menu item: Service exception", ((MessageResponse) responseEntity.getBody()).getDescription());

        verify(menuItemService).deleteMenuItem(menuItemId);
    }

    @Test
    void testGetAllMenuItems_ServiceException() {
        // Stub the service method to throw an exception
        when(menuItemService.getAllMenuItemsWithDetails()).thenThrow(new RuntimeException("Service exception"));

        // When
        ResponseEntity responseEntity = menuItemController.getAllMenuItemsWithDetails();

        // Then
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        assertEquals(-1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Error fetching menu item: Service exception", ((MessageResponse) responseEntity.getBody()).getDescription());

        verify(menuItemService).getAllMenuItemsWithDetails();
    }

    @Test
    void testGetMenuItemsByStoreId_ServiceException() {
        // Given
        Long storeId = 1L;

        // Stub the service method to throw an exception
        when(menuItemService.getMenuItemByStore(storeId)).thenThrow(new RuntimeException("Service exception"));

        // When
        ResponseEntity responseEntity = menuItemController.getAllMenuItemsWithDetails(storeId);

        // Then
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        assertEquals(-1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Error fetching menu item: Service exception", ((MessageResponse) responseEntity.getBody()).getDescription());

        verify(menuItemService).getMenuItemByStore(storeId);
    }

}
