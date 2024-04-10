package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Category;
import com.Group11.soulfulplates.repository.CategoryRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * This class implements methods for managing categories, including creating, updating, and deleting categories,
 * retrieving categories by ID or for a specific store, and fetching all categories.
 */


@Service
@Transactional
public class CategoryServiceImpl {
    @Autowired
    private CategoryRepository categoryRepository;


    public Category createCategory(Category category) {
        return categoryRepository.save(category);
    }

    public Category findById(Long categoryId){
        Category category = categoryRepository.findById(categoryId)
                .orElseThrow(() -> new EntityNotFoundException("Category not found with id: " + categoryId));
        return category;
    }

    public Category updateCategory(Long categoryId, Category updatedCategory) {
        Category category = findById(categoryId);
        category.setCategoryName(updatedCategory.getCategoryName());
        category.setStoreId(updatedCategory.getStoreId());
        return categoryRepository.save(category);
    }

    public void deleteCategory(Long categoryId) {
        Category category = findById(categoryId);
        categoryRepository.delete(category);
    }

    public List<Category> getAllByStoreId() {
        return categoryRepository.findAll();
    }

    public List<Category> getCategoriesByStore(Long storeId) {
        List<Category> categories = categoryRepository.getCategoriesByStore(storeId);
        return categories;
    }

}


