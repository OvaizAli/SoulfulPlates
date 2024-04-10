package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Category;
import com.Group11.soulfulplates.models.MenuItem;
import com.Group11.soulfulplates.models.Subcategory;
import com.Group11.soulfulplates.payload.response.MenuItemResponse;
import com.Group11.soulfulplates.repository.CategoryRepository;
import com.Group11.soulfulplates.repository.MenuItemRepository;
import com.Group11.soulfulplates.repository.SubcategoryRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * This class implements methods for managing menu items, including creating, updating, and deleting menu items,
 * retrieving menu items by ID or for a specific store, and fetching all menu items with details.
 */


@Service
@Transactional
public class MenuItemServiceImpl {

    @Autowired
    private MenuItemRepository menuItemRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private SubcategoryRepository subcategoryRepository;

    public MenuItem createMenuItem(MenuItem menuItem) {
        return menuItemRepository.save(menuItem);
    }
    public MenuItem findMenuById(Long menuId) {
        MenuItem menuItem = menuItemRepository.findById(menuId)
                .orElseThrow(() -> new EntityNotFoundException("Subcategory not found with id: " + menuId));
        return menuItem;

    }

    public MenuItem updateMenuItem(Long menuItemId, MenuItem updatedMenuItem) {
        MenuItem menuItem = findMenuById(menuItemId);
        menuItem.setItemName(updatedMenuItem.getItemName());
        menuItem.setDescription(updatedMenuItem.getDescription());
        menuItem.setItemPrice(updatedMenuItem.getItemPrice());
        menuItem.setType(updatedMenuItem.getType());
        menuItem.setInStock(updatedMenuItem.isInStock());
        menuItem.setItemImage(updatedMenuItem.getItemImage());
        menuItem.setServingType(updatedMenuItem.getServingType());
        menuItem.setPortion(updatedMenuItem.getPortion());
        menuItem.setRecommended(updatedMenuItem.isRecommended());
        return menuItemRepository.save(menuItem);
    }
    public void deleteMenuItem(Long menuItemId) {
        MenuItem menuItem = findMenuById(menuItemId);
        menuItemRepository.delete(menuItem);
    }

    public List<MenuItemResponse> getAllMenuItemsWithDetails() {
        List<MenuItem> menuItems = menuItemRepository.findAll();
        List<MenuItemResponse> menuItemResponses = new ArrayList<>();

        for (MenuItem menuItem : menuItems) {
            MenuItemResponse response = new MenuItemResponse();
            response.setItemId(menuItem.getItemId());
            response.setItemName(menuItem.getItemName());
            response.setDescription(menuItem.getDescription());
            response.setItemPrice(menuItem.getItemPrice());
            response.setType(menuItem.getType());
            response.setInStock(menuItem.isInStock());
            response.setItemImage(menuItem.getItemImage());
            response.setServingType(menuItem.getServingType());
            response.setPortion(menuItem.getPortion());
            response.setRecommended(menuItem.isRecommended());
            response.setCategoryId(menuItem.getCategoryId());
            response.setSubcategoryId(menuItem.getSubcategoryId());

            // Find category and subcategory names based on IDs
            Category category = categoryRepository.findById(menuItem.getCategoryId()).orElse(null);
            if (category != null) {
                response.setCategoryName(category.getCategoryName());
            }

            Subcategory subcategory = subcategoryRepository.findById(menuItem.getSubcategoryId()).orElse(null);
            if (subcategory != null) {
                response.setSubcategoryName(subcategory.getSubCategoryName());
            }

            menuItemResponses.add(response);
        }

        return menuItemResponses;
    }

    public List<MenuItemResponse> getMenuItemByStore(Long storeId) {
        List<MenuItem> menuItems = menuItemRepository.findAllByStoreId(storeId);
        List<MenuItemResponse> menuItemResponses = new ArrayList<>();

        for (MenuItem menuItem : menuItems) {
            MenuItemResponse response = new MenuItemResponse();
            response.setItemId(menuItem.getItemId());
            response.setItemName(menuItem.getItemName());
            response.setDescription(menuItem.getDescription());
            response.setItemPrice(menuItem.getItemPrice());
            response.setType(menuItem.getType());
            response.setInStock(menuItem.isInStock());
            response.setItemImage(menuItem.getItemImage());
            response.setServingType(menuItem.getServingType());
            response.setPortion(menuItem.getPortion());
            response.setRecommended(menuItem.isRecommended());
            response.setCategoryId(menuItem.getCategoryId());
            response.setSubcategoryId(menuItem.getSubcategoryId());

            // Find category and subcategory names based on IDs
            Category category = categoryRepository.findById(menuItem.getCategoryId()).orElse(null);
            if (category != null) {
                response.setCategoryName(category.getCategoryName());
            }

            Subcategory subcategory = subcategoryRepository.findById(menuItem.getSubcategoryId()).orElse(null);
            if (subcategory != null) {
                response.setSubcategoryName(subcategory.getSubCategoryName());
            }

            menuItemResponses.add(response);
        }

        return menuItemResponses;
    }
}
