package com.Group11.soulfulplates.models;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;
import java.util.Set;

/**
 * Represents a store in the system.
 */
@Data
@Entity
@Table(name = "stores")
public class Store {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "store_id")
    private long storeId;

    @Column(name = "storeName", unique = true)
    private String storeName;

    @Column(name = "storeEmail", unique = true)
    private String storeEmail;

    @Column(name = "storeDescription", unique = true)
    private String storeDescription;

    @Column(name = "storeContactNumber")
    private String storeContactNumber;

    @Column(name = "store_image_url")
    private String storeImageUrl;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "store", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<Order> orders;

    @OneToMany(mappedBy = "store", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Payment> payments;

    /**
     * Gets the ID of the store.
     * @return The ID of the store.
     */
    public Long getStoreId() {
        return storeId;
    }

    /**
     * Sets the ID of the store.
     * @param storeId The ID of the store.
     */
    public void setStoreId(Long storeId) {
        this.storeId = storeId;
    }

    /**
     * Gets the name of the store.
     * @return The name of the store.
     */
    public String getStoreName() {
        return storeName;
    }

    /**
     * Sets the name of the store.
     * @param storeName The name of the store.
     */
    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    /**
     * Gets the email of the store.
     * @return The email of the store.
     */
    public String getStoreEmail() {
        return storeEmail;
    }

    /**
     * Sets the email of the store.
     * @param storeEmail The email of the store.
     */
    public void setStoreEmail(String storeEmail) {
        this.storeEmail = storeEmail;
    }

    /**
     * Gets the contact number of the store.
     * @return The contact number of the store.
     */
    public String getContactNumber() {
        return storeContactNumber;
    }

    /**
     * Sets the contact number of the store.
     * @param storeContactNumber The contact number of the store.
     */
    public void setContactNumber(String storeContactNumber) {
        this.storeContactNumber = storeContactNumber;
    }

    /**
     * Gets the user associated with the store.
     * @return The user associated with the store.
     */
    public User getUser() {
        return user;
    }

    /**
     * Sets the user associated with the store.
     * @param user The user associated with the store.
     */
    public void setUser(User user) {
        this.user = user;
    }

    /**
     * Gets the description of the store.
     * @return The description of the store.
     */
    public String getStoreDescription() {
        return storeDescription;
    }

    /**
     * Sets the description of the store.
     * @param storeDescription The description of the store.
     */
    public void setStoreDescription(String storeDescription) {
        this.storeDescription = storeDescription;
    }

    /**
     * Gets the URL of the store image.
     * @return The URL of the store image.
     */
    public String getStoreImageUrl() {
        return storeImageUrl;
    }

    /**
     * Sets the URL of the store image.
     * @param storeImageUrl The URL of the store image.
     */
    public void setStoreImageUrl(String storeImageUrl) {
        this.storeImageUrl = storeImageUrl;
    }

    /**
     * Returns a string representation of the store.
     * @return A string representation of the store.
     */
    @Override
    public String toString() {
        return "Store{" +
                "id=" + storeId +
                ", name='" + storeName + '\'' +
                ", description='" + storeDescription + '\'' +
                ", email='" + storeEmail + '\'' +
                ", storeContactNumber='" + storeContactNumber + '\'' +
                '}';
    }
}
