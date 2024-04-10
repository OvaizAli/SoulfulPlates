package com.Group11.soulfulplates.models;

import jakarta.persistence.*;
import lombok.Data;

/**
 * Represents a menu item in the system.
 */
@Entity
@Table(name = "menu_items")
@Data
public class MenuItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "menu_item_id")
    private Long itemId;

    @Column(name = "item_name")
    private String itemName;

    @Column(name = "description")
    private String description;

    @Column(name = "item_price")
    private String itemPrice;

    @Column(name = "type")
    private String type;

    @Column(name = "in_stock")
    private boolean inStock;

    @Column(name = "is_recommended")
    private boolean isRecommended;

    @Column(name = "item_image")
    private String itemImage;

    @Column(name = "serving_type")
    private int servingType;

    @Column(name = "portion")
    private String portion;

    @Column(name = "store_id")
    private Long storeId;

    @Column(name = "subcategory_id")
    private Long subcategoryId;

    @Column(name = "category_id")
    private Long categoryId;
}
