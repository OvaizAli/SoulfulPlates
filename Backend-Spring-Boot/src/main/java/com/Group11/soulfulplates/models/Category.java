package com.Group11.soulfulplates.models;

import jakarta.persistence.*;
import lombok.Data;

/**
 * The Category class represents a category for items in a store.
 */
@Entity
@Table(name = "categories")
@Data
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "category_id")
    private Long categoryId;

    @Column(name = "category_name")
    private String categoryName;

    @Column(name = "store_id")
    private String storeId;
}
