package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Order;
import com.Group11.soulfulplates.models.Rating;
import com.Group11.soulfulplates.payload.request.CreateRatingRequest;
import com.Group11.soulfulplates.repository.OrderRepository;
import com.Group11.soulfulplates.repository.RatingRepository;
import com.Group11.soulfulplates.repository.StoreRepository;
import com.Group11.soulfulplates.services.RatingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 This class implements the RatingService interface.
 It provides methods to manage ratings, including adding a new rating and linking it to an order,
 as well as calculating the average rating for a store.
 */

@Service
public class RatingServiceImpl implements RatingService {

    @Autowired
    private RatingRepository ratingRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private StoreRepository storeRepository;

    @Override
    @Transactional
    public void addRatingAndLinkToOrder(CreateRatingRequest ratingData) throws Exception {
        Rating rating = new Rating();
        if(ratingData.getOrderId() == null){
            throw new Exception("Order is Null in request");
        }
        if(ratingData.getStoreId() == null){
            throw new Exception("Store Id is Null in request");
        }
        Order order = orderRepository.findById(ratingData.getOrderId()).orElseThrow(() -> new Exception("Order not found"));
        if(order.getRating() != null && order.getRating().getRatingId() != null){
            rating = ratingRepository.findByRatingId(order.getRating().getRatingId());
            rating.setUpdatedAt(new Date());
            rating.setRating(ratingData.getRating());
            rating.setFeedback(ratingData.getFeedback());
        } else {
            rating.setStore(storeRepository.findById(ratingData.getStoreId()).orElseThrow(() -> new Exception("Store not found")));
            rating.setRating(ratingData.getRating());
            rating.setFeedback(ratingData.getFeedback());
            rating.setCreatedAt(new Date());
            rating.setUpdatedAt(new Date());
        }

        Rating savedRating = ratingRepository.save(rating);

        if(savedRating == null || savedRating.getRatingId() == null){
            throw new Exception("Rating Id Not Created");
        }

        if(order != null){
            order.setRating(savedRating);
        } else {
            throw new Exception("Order not found");
        }
        orderRepository.save(order);
        System.out.println(savedRating);
    }

    @Override
    public double getAverageRating(Long storeId) {
        List<Rating> ratings = ratingRepository.findByStoreStoreId(storeId);
        if (ratings.isEmpty()) {
            return 0; // or any default value
        }
        double sum = 0;
        for (Rating rating : ratings) {
            sum += rating.getRating();
        }
        return sum / ratings.size();
    }

}
