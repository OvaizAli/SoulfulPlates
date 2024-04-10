package com.Group11.soulfulplates.models;

import jakarta.persistence.*;
import lombok.Data;

/**
 * The CartItem class represents an item within a shopping cart.
 */
@Data
@Entity
public class CartItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long cartItemId;

    private Long itemId;
    private String name;
    private Double price;
    private Integer quantity;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;

    /**
     * Retrieves the ID of the cart item.
     *
     * @return The cart item ID.
     */
    public Long getCartItemId() {
        return cartItemId;
    }

    /**
     * Sets the ID of the cart item.
     *
     * @param cartItemId The cart item ID to set.
     */
    public void setCartItemId(Long cartItemId) {
        this.cartItemId = cartItemId;
    }

    /**
     * Retrieves the ID of the item.
     *
     * @return The item ID.
     */
    public Long getItemId() {
        return itemId;
    }

    /**
     * Sets the ID of the item.
     *
     * @param itemId The item ID to set.
     */
    public void setItemId(Long itemId) {
        this.itemId = itemId;
    }

    /**
     * Retrieves the name of the item.
     *
     * @return The item name.
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the name of the item.
     *
     * @param name The item name to set.
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Retrieves the price of the item.
     *
     * @return The item price.
     */
    public Double getPrice() {
        return price;
    }

    /**
     * Sets the price of the item.
     *
     * @param price The item price to set.
     */
    public void setPrice(Double price) {
        this.price = price;
    }

    /**
     * Retrieves the quantity of the item.
     *
     * @return The item quantity.
     */
    public Integer getQuantity() {
        return quantity;
    }

    /**
     * Sets the quantity of the item.
     *
     * @param quantity The item quantity to set.
     */
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    /**
     * Retrieves the order associated with the cart item.
     *
     * @return The associated order.
     */
    public Order getOrder() {
        return order;
    }

    /**
     * Sets the order associated with the cart item.
     *
     * @param order The order to associate.
     */
    public void setOrder(Order order) {
        this.order = order;
    }

    /**
     * Generates a string representation of the cart item.
     *
     * @return The string representation of the cart item.
     */
    @Override
    public String toString() {
        return "CartItem{" +
                "cartItemId=" + cartItemId +
                ", menuItemId=" + itemId +
                ", itemName='" + name + '\'' +
                ", quantity=" + quantity +
                ", price=" + price +
                '}';
    }
}
