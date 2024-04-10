package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Category;
import com.Group11.soulfulplates.repository.CategoryRepository;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class CategoryServiceImplTest {

    @Mock
    private CategoryRepository categoryRepository;

    @InjectMocks
    private CategoryServiceImpl categoryService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void testCreateCategory() {
        Category category = new Category();
        category.setCategoryName("Test Category");

        when(categoryRepository.save(category)).thenReturn(category);

        Category savedCategory = categoryService.createCategory(category);

        assertNotNull(savedCategory);
        assertEquals("Test Category", savedCategory.getCategoryName());
        verify(categoryRepository, times(1)).save(category);
    }

    @Test
    void testFindById_CategoryFound() {
        Long categoryId = 1L;
        Category category = new Category();
        category.setCategoryId(categoryId);
        category.setCategoryName("Test Category");

        when(categoryRepository.findById(categoryId)).thenReturn(Optional.of(category));

        Category foundCategory = categoryService.findById(categoryId);

        assertNotNull(foundCategory);
        assertEquals(categoryId, foundCategory.getCategoryId());
        assertEquals("Test Category", foundCategory.getCategoryName());
    }

    @Test
    void testFindById_CategoryNotFound() {
        Long categoryId = 1L;

        when(categoryRepository.findById(categoryId)).thenReturn(Optional.empty());

        assertThrows(EntityNotFoundException.class, () -> categoryService.findById(categoryId));
    }

    @Test
    void testUpdateCategory() {
        Long categoryId = 1L;
        Category existingCategory = new Category();
        existingCategory.setCategoryId(categoryId);
        existingCategory.setCategoryName("Existing Category");

        Category updatedCategory = new Category();
        updatedCategory.setCategoryName("Updated Category");

        when(categoryRepository.findById(categoryId)).thenReturn(Optional.of(existingCategory));
        when(categoryRepository.save(existingCategory)).thenReturn(existingCategory);

        Category result = categoryService.updateCategory(categoryId, updatedCategory);

        assertNotNull(result);
        assertEquals("Updated Category", result.getCategoryName());
        verify(categoryRepository, times(1)).findById(categoryId);
        verify(categoryRepository, times(1)).save(existingCategory);
    }

    @Test
    void testDeleteCategory() {
        Long categoryId = 1L;
        Category category = new Category();
        category.setCategoryId(categoryId);
        category.setCategoryName("Test Category");

        when(categoryRepository.findById(categoryId)).thenReturn(Optional.of(category));

        categoryService.deleteCategory(categoryId);

        verify(categoryRepository, times(1)).delete(category);
    }

    @Test
    void testGetAllByStoreId() {
        List<Category> categories = new ArrayList<>();
        categories.add(new Category());
        categories.add(new Category());

        when(categoryRepository.findAll()).thenReturn(categories);

        List<Category> result = categoryService.getAllByStoreId();

        assertNotNull(result);
        assertEquals(2, result.size());
        verify(categoryRepository, times(1)).findAll();
    }
}
