package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Subcategory;
import com.Group11.soulfulplates.repository.SubcategoryRepository;
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

class SubcategoryServiceImplTest {

    @Mock
    private SubcategoryRepository subcategoryRepository;

    @InjectMocks
    private SubcategoryServiceImpl subcategoryService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void testCreateSubcategory() {
        Subcategory subcategory = new Subcategory();
        subcategory.setSubCategoryId(1L);
        subcategory.setSubCategoryName("Test Subcategory");

        when(subcategoryRepository.save(subcategory)).thenReturn(subcategory);

        Subcategory createdSubcategory = subcategoryService.createSubcategory(subcategory);
        assertNotNull(createdSubcategory);
        assertEquals(subcategory.getSubCategoryId(), createdSubcategory.getSubCategoryId());
        assertEquals(subcategory.getSubCategoryName(), createdSubcategory.getSubCategoryName());
    }

    @Test
    void testFindById() {
        Subcategory subcategory = new Subcategory();
        subcategory.setSubCategoryId(1L);
        subcategory.setSubCategoryName("Test Subcategory");

        when(subcategoryRepository.findById(1L)).thenReturn(Optional.of(subcategory));

        Subcategory foundSubcategory = subcategoryService.findById(1L);
        assertNotNull(foundSubcategory);
        assertEquals(subcategory.getSubCategoryId(), foundSubcategory.getSubCategoryId());
        assertEquals(subcategory.getSubCategoryName(), foundSubcategory.getSubCategoryName());
    }

    @Test
    void testUpdateSubcategory() {
        Subcategory subcategory = new Subcategory();
        subcategory.setSubCategoryId(1L);
        subcategory.setSubCategoryName("Test Subcategory");

        when(subcategoryRepository.findById(1L)).thenReturn(Optional.of(subcategory));
        when(subcategoryRepository.save(subcategory)).thenReturn(subcategory);

        Subcategory updatedSubcategory = subcategoryService.updateSubcategory(1L, subcategory);
        assertNotNull(updatedSubcategory);
        assertEquals(subcategory.getSubCategoryId(), updatedSubcategory.getSubCategoryId());
        assertEquals(subcategory.getSubCategoryName(), updatedSubcategory.getSubCategoryName());
    }

    @Test
    void testDeleteSubcategory() {
        Subcategory subcategory = new Subcategory();
        subcategory.setSubCategoryId(1L);
        subcategory.setSubCategoryName("Test Subcategory");

        when(subcategoryRepository.findById(1L)).thenReturn(Optional.of(subcategory));

        subcategoryService.deleteSubcategory(1L);
        verify(subcategoryRepository, times(1)).delete(subcategory);
    }

    @Test
    void testGetAllSubCategories() {
        Subcategory subcategory = new Subcategory();
        subcategory.setSubCategoryId(1L);
        subcategory.setSubCategoryName("Test Subcategory");

        List<Subcategory> subcategoryList = Collections.singletonList(subcategory);

        when(subcategoryRepository.findAll()).thenReturn(subcategoryList);

        List<Subcategory> foundSubcategories = subcategoryService.getAllSubCategories();
        assertNotNull(foundSubcategories);
        assertFalse(foundSubcategories.isEmpty());
        assertEquals(1, foundSubcategories.size());
        assertEquals(subcategory.getSubCategoryId(), foundSubcategories.get(0).getSubCategoryId());
        assertEquals(subcategory.getSubCategoryName(), foundSubcategories.get(0).getSubCategoryName());
    }


    @Test
    void testGetAllSubCategoriesByCategoryId() {
        Subcategory subcategory = new Subcategory();
        subcategory.setSubCategoryId(1L);
        subcategory.setSubCategoryName("Test Subcategory");
        subcategory.setCategoryId(1L);

        List<Subcategory> subcategoryList = Collections.singletonList(subcategory);

        when(subcategoryRepository.getAllSubCategoriesByCategory(anyLong())).thenReturn(subcategoryList);

        List<Subcategory> foundSubcategories = subcategoryService.getAllSubCategoriesByCategory(1L);
        assertNotNull(foundSubcategories);
        assertFalse(foundSubcategories.isEmpty());
        assertEquals(1, foundSubcategories.size());
        assertEquals(subcategory.getSubCategoryId(), foundSubcategories.get(0).getSubCategoryId());
        assertEquals(subcategory.getSubCategoryName(), foundSubcategories.get(0).getSubCategoryName());
    }
}
