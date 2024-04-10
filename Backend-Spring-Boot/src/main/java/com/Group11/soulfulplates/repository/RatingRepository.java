package com.Group11.soulfulplates.repository;

import com.Group11.soulfulplates.models.Rating;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Repository interface for Rating entity.
 */
public interface RatingRepository extends JpaRepository<Rating, Long> {

    /**
     * Retrieves a list of ratings by store ID.
     * @param storeId The ID of the store.
     * @return A list of ratings associated with the specified store ID.
     */
    List<Rating> findByStoreStoreId(Long storeId);

    /**
     * Retrieves a rating by rating ID.
     * @param ratingId The ID of the rating.
     * @return The rating associated with the specified rating ID.
     */
    Rating findByRatingId(Long ratingId);
}
