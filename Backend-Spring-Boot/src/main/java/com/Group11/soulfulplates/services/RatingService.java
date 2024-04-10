package com.Group11.soulfulplates.services;

import com.Group11.soulfulplates.payload.request.CreateRatingRequest;

/**

 This service interface defines methods related to rating management.
 It provides functionality to add a rating and link it to an order, as well as to retrieve the average rating for a store.
 */

public interface RatingService {
    void addRatingAndLinkToOrder(CreateRatingRequest ratingData) throws Exception;
    double getAverageRating(Long storeId);
}