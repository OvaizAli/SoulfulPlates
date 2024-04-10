package com.Group11.soulfulplates.payload.request;

/**
 * Request payload for creating a rating.
 */
public class CreateRatingRequest {

    private Long userId;
    private Long storeId;
    private Long orderId;
    private Integer rating;
    private String feedback;

    /**
     * Retrieves the ID of the user who is giving the rating.
     *
     * @return The user ID.
     */
    public Long getUserId() {
        return userId;
    }

    /**
     * Sets the ID of the user who is giving the rating.
     *
     * @param userId The user ID.
     */
    public void setUserId(Long userId) {
        this.userId = userId;
    }

    /**
     * Retrieves the ID of the store for which the rating is being given.
     *
     * @return The store ID.
     */
    public Long getStoreId() {
        return storeId;
    }

    /**
     * Sets the ID of the store for which the rating is being given.
     *
     * @param storeId The store ID.
     */
    public void setStoreId(Long storeId) {
        this.storeId = storeId;
    }

    /**
     * Retrieves the ID of the order for which the rating is being given.
     *
     * @return The order ID.
     */
    public Long getOrderId() {
        return orderId;
    }

    /**
     * Sets the ID of the order for which the rating is being given.
     *
     * @param orderId The order ID.
     */
    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    /**
     * Retrieves the rating value.
     *
     * @return The rating value.
     */
    public Integer getRating() {
        return rating;
    }

    /**
     * Sets the rating value.
     *
     * @param rating The rating value.
     */
    public void setRating(Integer rating) {
        this.rating = rating;
    }

    /**
     * Retrieves the feedback associated with the rating.
     *
     * @return The feedback.
     */
    public String getFeedback() {
        return feedback;
    }

    /**
     * Sets the feedback associated with the rating.
     *
     * @param feedback The feedback.
     */
    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }
}
