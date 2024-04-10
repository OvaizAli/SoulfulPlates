package com.Group11.soulfulplates.repository;

import com.Group11.soulfulplates.models.Subcategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository interface for Subcategory entity.
 */
@Repository
public interface SubcategoryRepository extends JpaRepository<Subcategory, Long> {

    /**
     * Retrieves all subcategories by category id.
     * @param categoryId The id of the category.
     * @return A list of subcategories belonging to the specified category.
     */
    @Query(nativeQuery = true, value = "SELECT * FROM subcategories where category_id = :categoryId")
    List<Subcategory> getAllSubCategoriesByCategory(Long categoryId);
}
