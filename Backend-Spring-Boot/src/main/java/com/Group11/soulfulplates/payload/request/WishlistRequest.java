package com.Group11.soulfulplates.payload.request;

import lombok.Data;

/**
 * Request payload for adding an item to the wishlist.
 */
@Data
public class WishlistRequest {

    private Long userId;
    private Long storeId;
    private String storeEmail;
    private String storeName;
    private Long menuItemId;
    private String itemName;
    private double itemPrice;

    public WishlistRequest() {
    }

    public WishlistRequest(Long userId, Long storeId, String storeEmail, String storeName, Long menuItemId, String itemName, double itemPrice) {
        this.userId = userId;
        this.storeId = storeId;
        this.storeEmail = storeEmail;
        this.storeName = storeName;
        this.menuItemId = menuItemId;
        this.itemName = itemName;
        this.itemPrice = itemPrice;
    }

}
