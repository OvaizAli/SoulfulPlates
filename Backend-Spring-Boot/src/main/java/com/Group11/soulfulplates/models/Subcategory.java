package com.Group11.soulfulplates.models;

import jakarta.persistence.*;
import lombok.Data;

/**
 * Represents a subcategory in the system.
 */

@Entity
@Table(name = "subcategories")
@Data
public class Subcategory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "subcategory_id")
    private Long subCategoryId;

    @Column(name = "subcategory_name")
    private String subCategoryName;

    @Column(name = "category_id")
    private Long categoryId;

}
