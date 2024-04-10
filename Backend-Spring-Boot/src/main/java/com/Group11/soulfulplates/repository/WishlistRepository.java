package com.Group11.soulfulplates.repository;

import com.Group11.soulfulplates.models.Wishlist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Repository interface for Wishlist entity.
 */
@Repository
public interface WishlistRepository extends JpaRepository<Wishlist, Long> {
}
