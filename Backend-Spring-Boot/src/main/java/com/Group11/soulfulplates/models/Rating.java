package com.Group11.soulfulplates.models;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

/**
 * Represents a rating given by a user to a store in the system.
 */

@Entity
@Data
@Table(name = "ratings")
public class Rating {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ratingId;

    @Column(nullable = false)
    private Integer rating;

    @Column(length = 500) // Define the maximum length of the feedback string if needed
    private String feedback;

    @ManyToOne
    @JoinColumn(name = "store_id", nullable = false)
    private Store store;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false, updatable = false)
    private Date createdAt;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false)
    private Date updatedAt;

    @OneToOne(mappedBy = "rating", cascade = CascadeType.ALL, orphanRemoval = true)
    private Order order;

    // Constructors, Getters, and Setters

    public Rating() {
        // Default constructor
    }

    // Other constructors, if necessary

    public Long getRatingId() {
        return ratingId;
    }

    public void setRatingId(Long ratingId) {
        this.ratingId = ratingId;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public Store getStore() {
        return store;
    }

    public void setStore(Store store) {
        this.store = store;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Rating{" +
                "ratingId=" + ratingId +
                ", rating=" + rating +
                ", feedback='" + feedback + '\'' +
                ", store=" + (store != null ? store.toString() : "null") + // Calls Store's toString method. Make sure Store's toString() is properly overridden to prevent recursion.
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }

}
