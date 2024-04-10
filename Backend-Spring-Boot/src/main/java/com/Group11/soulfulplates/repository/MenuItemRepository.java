package com.Group11.soulfulplates.repository;

import com.Group11.soulfulplates.models.MenuItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository interface for MenuItem entity.
 */
@Repository
public interface MenuItemRepository extends JpaRepository<MenuItem, Long> {

        /**
         * Retrieves a list of menu items by store ID where both category ID and subcategory ID are not null.
         * @param storeId The ID of the store.
         * @return A list of menu items associated with the specified store ID.
         */
        @Query(nativeQuery = true, value = "SELECT * FROM menu_items where store_id = :storeId and category_id is not null and subcategory_id is not null")
        List<MenuItem> findAllByStoreId(Long storeId);
}
