package com.Group11.soulfulplates.repository;

import com.Group11.soulfulplates.models.Store;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Repository interface for Store entity.
 */
@Repository
public interface StoreRepository extends JpaRepository<Store, Long> {

    /**
     * Finds a store by user id.
     * @param id The id of the user.
     * @return An optional containing the store if found, empty otherwise.
     */
    Optional<Store> findByUser_Id(Long id);
}
