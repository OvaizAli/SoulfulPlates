package com.Group11.soulfulplates.controllers;

import com.Group11.soulfulplates.models.Subcategory;
import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.Group11.soulfulplates.services.impl.SubcategoryServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controller class for managing subcategories.
 */
@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api")
public class SubCategoryController {

    @Autowired
    private SubcategoryServiceImpl subcategoryService;

    /**
     * Retrieve all subcategories.
     *
     * @return ResponseEntity containing the list of subcategories or an error message.
     */
    @GetMapping("/getSubCategories")
    public ResponseEntity getAllSubCategories() {
        try {
            List<Subcategory> subcategories = subcategoryService.getAllSubCategories();
            return ResponseEntity.ok(new MessageResponse(1, "Subcategory fetched.", subcategories));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new MessageResponse(-1,
                    "Error fetching subcategories: " + e.getMessage(), null));
        }
    }

    /**
     * Retrieve all subcategories by category ID.
     *
     * @param categoryId The ID of the category.
     * @return ResponseEntity containing the list of subcategories for the specified category or an error message.
     */
    @GetMapping("/getAllSubCategoriesByCategory/{categoryId}")
    public ResponseEntity getAllSubCategoriesByCategory(@PathVariable Long categoryId) {
        try {
            List<Subcategory> subcategories = subcategoryService.getAllSubCategoriesByCategory(categoryId);
            return ResponseEntity.ok(new MessageResponse(1, "Subcategory fetched.", subcategories));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new MessageResponse(-1,
                    "Error fetching subcategories by category: " + e.getMessage(), null));
        }
    }

    /**
     * Create a new subcategory.
     *
     * @param subcategory The subcategory object to be created.
     * @return ResponseEntity containing a success or error message.
     */
    @PostMapping("/subcategories")
    public ResponseEntity createSubcategory(@RequestBody Subcategory subcategory) {
        try {
            Subcategory createdSubcategory = subcategoryService.createSubcategory(subcategory);
            return ResponseEntity.ok(new MessageResponse(1, "Subcategory created.", createdSubcategory));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new MessageResponse(-1,
                    "Error creating subcategory: " + e.getMessage(), null));
        }
    }

    /**
     * Update an existing subcategory.
     *
     * @param subcategoryId     The ID of the subcategory to be updated.
     * @param updatedSubcategory The updated subcategory object.
     * @return ResponseEntity containing a success or error message.
     */
    @PutMapping("/subcategories/{subcategoryId}")
    public ResponseEntity updateSubcategory(@PathVariable Long subcategoryId, @RequestBody Subcategory updatedSubcategory) {
        try {
            Subcategory subcategory = subcategoryService.updateSubcategory(subcategoryId, updatedSubcategory);
            return ResponseEntity.ok(new MessageResponse(1, "Subcategory updated.", subcategory));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new MessageResponse(-1,
                    "Error updating subcategory: " + e.getMessage(), null));
        }
    }

    /**
     * Delete an existing subcategory.
     *
     * @param subcategoryId The ID of the subcategory to be deleted.
     * @return ResponseEntity containing a success or error message.
     */
    @DeleteMapping("/subcategories/{subcategoryId}")
    public ResponseEntity deleteSubcategory(@PathVariable Long subcategoryId) {
        try {
            subcategoryService.deleteSubcategory(subcategoryId);
            return ResponseEntity.ok(new MessageResponse(1, "Subcategory deleted.", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(new MessageResponse(-1,
                    "Error deleting subcategory: " + e.getMessage(), null));
        }
    }
}

