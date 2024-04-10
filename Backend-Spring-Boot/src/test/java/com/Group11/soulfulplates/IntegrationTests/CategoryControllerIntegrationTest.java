package com.Group11.soulfulplates.IntegrationTests;

import com.Group11.soulfulplates.models.Category;
import com.Group11.soulfulplates.services.impl.CategoryServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import java.util.ArrayList;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

/**
 * Integration tests for the CategoryController class.
 */
@SpringBootTest
@AutoConfigureMockMvc
class CategoryControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private CategoryServiceImpl categoryService;

    /**
     * Set up method to mock data and service methods before each test.
     */
    @BeforeEach
    void setUp() {
        // Mock data
        Category request = new Category();
        request.setCategoryName("Test Category");
        request.setStoreId("1");

        // Mock service method
        when(categoryService.createCategory(any(Category.class))).thenReturn(request);
        when(categoryService.findById(1L)).thenReturn(request);
        when(categoryService.getAllByStoreId()).thenReturn(new ArrayList<>());
    }

    /**
     * Test case to verify unauthorized access while editing a category.
     *
     * @throws Exception if an error occurs during the test
     */
    @Test
    public void testEditCategory_Unauthorized() throws Exception {
        // Given
        Long categoryId = 1L;
        Category request = new Category();
        request.setCategoryId(categoryId);
        request.setCategoryName("Updated Test Category");

        // Mock service method
        when(categoryService.findById(categoryId)).thenReturn(request);

        // When/Then
        mockMvc.perform(MockMvcRequestBuilders.put("/api/categories/{id}", categoryId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"categoryName\": \"Updated Test Category\"}"))
                .andExpect(MockMvcResultMatchers.status().isForbidden())  // Change to isForbidden() to expect 403
                .andExpect(MockMvcResultMatchers.jsonPath("$.code").doesNotExist())
                .andExpect(MockMvcResultMatchers.jsonPath("$.description").doesNotExist())
                .andExpect(MockMvcResultMatchers.jsonPath("$.data").doesNotExist());
    }

    /**
     * Test case to verify unauthorized access while deleting a category.
     *
     * @throws Exception if an error occurs during the test
     */
    @Test
    void testDeleteCategory_Unauthorized() throws Exception {
        // Call controller method without authentication token
        mockMvc.perform(MockMvcRequestBuilders.delete("/api/categories/1"))
                .andExpect(MockMvcResultMatchers.status().isForbidden());
    }

    /**
     * Test case to verify unauthorized access while retrieving all categories by store ID.
     *
     * @throws Exception if an error occurs during the test
     */
    @Test
    void testGetAllByStoreId_Unauthorized() throws Exception {
        // Call controller method without authentication token
        mockMvc.perform(MockMvcRequestBuilders.get("/api/categories"))
                .andExpect(MockMvcResultMatchers.status().isUnauthorized());
    }
}
