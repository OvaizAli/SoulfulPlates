package com.Group11.soulfulplates.controllers;

import com.Group11.soulfulplates.models.Category;
import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.Group11.soulfulplates.payload.response.OrderDetailsResponse;
import com.Group11.soulfulplates.services.impl.CategoryServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controller class for managing categories.
 */
@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api")
public class CategoryController {

    @Autowired
    private CategoryServiceImpl categoryService;

    /**
     * Retrieves all categories.
     *
     * @return ResponseEntity containing a message response indicating the result of the operation.
     */
    @GetMapping("/getAllCategories")
    public ResponseEntity getAllByStoreId() {
        try {
            List<Category> categories = categoryService.getAllByStoreId();
            return ResponseEntity.ok(new MessageResponse(1, "Category fetched.", categories));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new OrderDetailsResponse(-1,
                    "Error fetching categories: " + e.getMessage(), null));
        }
    }

    /**
     * Creates a new category.
     *
     * @param category The category to be created.
     * @return ResponseEntity containing a message response indicating the result of the operation.
     */
    @PostMapping("/categories")
    public ResponseEntity createCategory(@RequestBody Category category) {
        try {
            Category createdCategory = categoryService.createCategory(category);
            return ResponseEntity.ok(new MessageResponse(1, "Category created.", createdCategory));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new OrderDetailsResponse(-1,
                    "Error creating category: " + e.getMessage(), null));
        }
    }

    /**
     * Updates an existing category.
     *
     * @param categoryId     The ID of the category to be updated.
     * @param updatedCategory The updated category data.
     * @return ResponseEntity containing a message response indicating the result of the operation.
     */
    @PutMapping("/categories/{categoryId}")
    public ResponseEntity updateCategory(@PathVariable Long categoryId, @RequestBody Category updatedCategory) {
        try {
            Category category = categoryService.updateCategory(categoryId, updatedCategory);
            return ResponseEntity.ok(new MessageResponse(1, "Category updated.", category));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new OrderDetailsResponse(-1,
                    "Error updating category: " + e.getMessage(), null));
        }
    }

    /**
     * Deletes a category.
     *
     * @param categoryId The ID of the category to be deleted.
     * @return ResponseEntity containing a message response indicating the result of the operation.
     */
    @DeleteMapping("/categories/{categoryId}")
    public ResponseEntity deleteCategory(@PathVariable Long categoryId) {
        try {
            categoryService.deleteCategory(categoryId);
            return ResponseEntity.ok(new MessageResponse(1, "Category deleted.", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new OrderDetailsResponse(-1,
                    "Error deleting category: " + e.getMessage(), null));
        }
    }

    /**
     * Retrieves categories by store.
     *
     * @param storeId The ID of the store.
     * @return ResponseEntity containing a message response indicating the result of the operation.
     */
    @GetMapping("/getCategoriesByStore/{storeId}")
    public ResponseEntity getCategoriesByStore(@PathVariable Long storeId) {
        try {
            List<Category> categories = categoryService.getCategoriesByStore(storeId);
            return ResponseEntity.ok(new MessageResponse(1, "Category fetched.", categories));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new OrderDetailsResponse(-1,
                    "Error fetching categories: " + e.getMessage(), null));
        }
    }
}
