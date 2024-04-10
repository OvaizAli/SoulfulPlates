package com.Group11.soulfulplates.repository;

import com.Group11.soulfulplates.models.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository interface for Category entity.
 */
@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {

    /**
     * Retrieves a list of categories by store ID.
     * @param storeId The ID of the store.
     * @return A list of categories associated with the specified store ID.
     */
    @Query(nativeQuery = true, value = "SELECT * FROM categories where store_id = :storeId")
    List<Category> getCategoriesByStore(Long storeId);
}
