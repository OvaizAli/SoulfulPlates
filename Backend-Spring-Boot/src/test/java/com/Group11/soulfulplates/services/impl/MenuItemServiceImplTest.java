package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Category;
import com.Group11.soulfulplates.models.MenuItem;
import com.Group11.soulfulplates.models.Subcategory;
import com.Group11.soulfulplates.payload.response.MenuItemResponse;
import com.Group11.soulfulplates.repository.CategoryRepository;
import com.Group11.soulfulplates.repository.MenuItemRepository;
import com.Group11.soulfulplates.repository.SubcategoryRepository;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class MenuItemServiceImplTest {

    @Mock
    private MenuItemRepository menuItemRepository;

    @Mock
    private CategoryRepository categoryRepository;

    @Mock
    private SubcategoryRepository subcategoryRepository;

    @InjectMocks
    private MenuItemServiceImpl menuItemService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void createMenuItem() {
        MenuItem menuItem = new MenuItem();
        when(menuItemRepository.save(menuItem)).thenReturn(menuItem);

        MenuItem createdMenuItem = menuItemService.createMenuItem(menuItem);
        assertNotNull(createdMenuItem);
        assertEquals(menuItem, createdMenuItem);
    }

    @Test
    void findMenuById_existingId() {
        Long menuId = 1L;
        MenuItem menuItem = new MenuItem();
        menuItem.setItemId(menuId);
        when(menuItemRepository.findById(menuId)).thenReturn(Optional.of(menuItem));

        MenuItem foundMenuItem = menuItemService.findMenuById(menuId);
        assertNotNull(foundMenuItem);
        assertEquals(menuId, foundMenuItem.getItemId());
    }

    @Test
    void findMenuById_nonExistingId() {
        Long nonExistingId = 100L;
        when(menuItemRepository.findById(nonExistingId)).thenReturn(Optional.empty());

        assertThrows(EntityNotFoundException.class, () -> menuItemService.findMenuById(nonExistingId));
    }

    @Test
    void updateMenuItem() {
        Long menuItemId = 1L;
        MenuItem existingMenuItem = new MenuItem();
        existingMenuItem.setItemId(menuItemId);
        when(menuItemRepository.findById(menuItemId)).thenReturn(Optional.of(existingMenuItem));

        MenuItem updatedMenuItem = new MenuItem();
        updatedMenuItem.setItemName("Updated Name");
        updatedMenuItem.setDescription("Updated Description");

        when(menuItemRepository.save(existingMenuItem)).thenReturn(updatedMenuItem);

        MenuItem result = menuItemService.updateMenuItem(menuItemId, updatedMenuItem);
        assertNotNull(result);
        assertEquals("Updated Name", result.getItemName());
        assertEquals("Updated Description", result.getDescription());
    }

    @Test
    void deleteMenuItem() {
        Long menuItemId = 1L;
        MenuItem existingMenuItem = new MenuItem();
        existingMenuItem.setItemId(menuItemId);
        when(menuItemRepository.findById(menuItemId)).thenReturn(Optional.of(existingMenuItem));

        menuItemService.deleteMenuItem(menuItemId);

        verify(menuItemRepository, times(1)).delete(existingMenuItem);
    }

    @Test
    void getAllMenuItemsWithDetails() {
        MenuItem menuItem = new MenuItem();
        menuItem.setItemId(1L);
        menuItem.setItemName("Item 1");
        menuItem.setDescription("Description for Item 1");
        menuItem.setItemPrice("10.99");
        menuItem.setType("Type 1");
        menuItem.setInStock(true);
        menuItem.setItemImage("image1.jpg");
        menuItem.setServingType(1);
        menuItem.setPortion("Portion 1");
        menuItem.setRecommended(true);
        menuItem.setCategoryId(1L);
        menuItem.setSubcategoryId(1L);

        List<MenuItem> menuItems = Collections.singletonList(menuItem);
        when(menuItemRepository.findAll()).thenReturn(menuItems);

        // Mock category
        Category category = new Category();
        category.setCategoryId(1L);
        category.setCategoryName("CategoryName");
        when(categoryRepository.findById(1L)).thenReturn(Optional.of(category));

        // Mock subcategory
        Subcategory subcategory = new Subcategory();
        subcategory.setSubCategoryId(1L);
        subcategory.setSubCategoryName("SubCategoryName");
        when(subcategoryRepository.findById(1L)).thenReturn(Optional.of(subcategory));

        // Invoke the method
        List<MenuItemResponse> result = menuItemService.getAllMenuItemsWithDetails();

        // Assert the result
        assertNotNull(result);
        assertFalse(result.isEmpty());
        assertEquals(1, result.size());

        MenuItemResponse menuItemResponse = result.get(0);
        assertEquals(menuItem.getItemId(), menuItemResponse.getItemId());
        assertEquals(menuItem.getItemName(), menuItemResponse.getItemName());
        assertEquals(menuItem.getDescription(), menuItemResponse.getDescription());
        assertEquals(menuItem.getItemPrice(), menuItemResponse.getItemPrice());
        assertEquals(menuItem.getType(), menuItemResponse.getType());
        assertEquals(menuItem.isInStock(), menuItemResponse.isInStock());
        assertEquals(menuItem.getItemImage(), menuItemResponse.getItemImage());
        assertEquals(menuItem.getServingType(), menuItemResponse.getServingType());
        assertEquals(menuItem.getPortion(), menuItemResponse.getPortion());
        assertEquals(menuItem.isRecommended(), menuItemResponse.isRecommended());
        assertEquals(category.getCategoryName(), menuItemResponse.getCategoryName());
        assertEquals(subcategory.getSubCategoryName(), menuItemResponse.getSubcategoryName());
    }
    
    @Test
    void getMenuItemByStore() {
        MenuItem menuItem = new MenuItem();
        menuItem.setItemId(1L);
        menuItem.setItemName("Item 1");
        menuItem.setDescription("Description for Item 1");
        menuItem.setItemPrice("10.99");
        menuItem.setType("Type 1");
        menuItem.setInStock(true);
        menuItem.setItemImage("image1.jpg");
        menuItem.setServingType(1);
        menuItem.setPortion("Portion 1");
        menuItem.setRecommended(true);
        menuItem.setCategoryId(1L);
        menuItem.setSubcategoryId(1L);

        List<MenuItem> menuItems = Collections.singletonList(menuItem);
        when(menuItemRepository.findAllByStoreId(anyLong())).thenReturn(menuItems);

        // Mock category
        Category category = new Category();
        category.setCategoryId(1L);
        category.setCategoryName("CategoryName");
        when(categoryRepository.findById(1L)).thenReturn(Optional.of(category));

        // Mock subcategory
        Subcategory subcategory = new Subcategory();
        subcategory.setSubCategoryId(1L);
        subcategory.setSubCategoryName("SubCategoryName");
        when(subcategoryRepository.findById(1L)).thenReturn(Optional.of(subcategory));

        // Invoke the method
        List<MenuItemResponse> result = menuItemService.getMenuItemByStore(1L);

        // Assert the result
        assertNotNull(result);
        assertFalse(result.isEmpty());
        assertEquals(1, result.size());

        MenuItemResponse menuItemResponse = result.get(0);
        assertEquals(menuItem.getItemId(), menuItemResponse.getItemId());
        assertEquals(menuItem.getItemName(), menuItemResponse.getItemName());
        assertEquals(menuItem.getDescription(), menuItemResponse.getDescription());
        assertEquals(menuItem.getItemPrice(), menuItemResponse.getItemPrice());
        assertEquals(menuItem.getType(), menuItemResponse.getType());
        assertEquals(menuItem.isInStock(), menuItemResponse.isInStock());
        assertEquals(menuItem.getItemImage(), menuItemResponse.getItemImage());
        assertEquals(menuItem.getServingType(), menuItemResponse.getServingType());
        assertEquals(menuItem.getPortion(), menuItemResponse.getPortion());
        assertEquals(menuItem.isRecommended(), menuItemResponse.isRecommended());
        assertEquals(category.getCategoryName(), menuItemResponse.getCategoryName());
        assertEquals(subcategory.getSubCategoryName(), menuItemResponse.getSubcategoryName());
    }

}
