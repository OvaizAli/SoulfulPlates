package com.Group11.soulfulplates.payload.response;

import lombok.Data;

/**
 * Response payload for menu items.
 */
@Data
public class MenuItemResponse {
    private Long itemId;
    private String itemName;
    private String description;
    private String itemPrice;
    private String type;
    private boolean inStock;
    private String itemImage;
    private int servingType;
    private String portion;
    private String categoryName;
    private String subcategoryName;
    private boolean recommended;
    private Long subcategoryId;
    private Long categoryId;
}
