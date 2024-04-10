package com.Group11.soulfulplates.payload.request;

import java.util.List;

/**
 * Request payload for creating an order.
 */
public class CreateOrderRequest {
    private Long userId;
    private Long storeId;
    private String instructions;
    private List<SelectedItem> selectedItems;

    /**
     * Retrieves the ID of the user placing the order.
     *
     * @return The user ID.
     */
    public Long getUserId() {
        return userId;
    }

    /**
     * Sets the ID of the user placing the order.
     *
     * @param userId The user ID.
     */
    public void setUserId(Long userId) {
        this.userId = userId;
    }

    /**
     * Retrieves the ID of the store where the order is being placed.
     *
     * @return The store ID.
     */
    public Long getStoreId() {
        return storeId;
    }

    /**
     * Sets the ID of the store where the order is being placed.
     *
     * @param storeId The store ID.
     */
    public void setStoreId(Long storeId) {
        this.storeId = storeId;
    }

    /**
     * Retrieves any additional instructions for the order.
     *
     * @return The order instructions.
     */
    public String getInstructions() {
        return instructions;
    }

    /**
     * Sets additional instructions for the order.
     *
     * @param instructions The order instructions.
     */
    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }

    /**
     * Retrieves the list of selected items for the order.
     *
     * @return The list of selected items.
     */
    public List<SelectedItem> getSelectedItems() {
        return selectedItems;
    }

    /**
     * Sets the list of selected items for the order.
     *
     * @param selectedItems The list of selected items.
     */
    public void setSelectedItems(List<SelectedItem> selectedItems) {
        this.selectedItems = selectedItems;
    }

    /**
     * Represents a selected item in the order.
     */
    public static class SelectedItem {
        private Long menuItemId;
        private String itemName;
        private Integer quantity;
        private Double price;

        /**
         * Retrieves the ID of the selected menu item.
         *
         * @return The menu item ID.
         */
        public Long getMenuItemId() {
            return menuItemId;
        }

        /**
         * Sets the ID of the selected menu item.
         *
         * @param menuItemId The menu item ID.
         */
        public void setMenuItemId(Long menuItemId) {
            this.menuItemId = menuItemId;
        }

        /**
         * Retrieves the name of the selected menu item.
         *
         * @return The menu item name.
         */
        public String getItemName() {
            return itemName;
        }

        /**
         * Sets the name of the selected menu item.
         *
         * @param itemName The menu item name.
         */
        public void setItemName(String itemName) {
            this.itemName = itemName;
        }

        /**
         * Retrieves the quantity of the selected menu item.
         *
         * @return The quantity.
         */
        public Integer getQuantity() {
            return quantity;
        }

        /**
         * Sets the quantity of the selected menu item.
         *
         * @param quantity The quantity.
         */
        public void setQuantity(Integer quantity) {
            this.quantity = quantity;
        }

        /**
         * Retrieves the price of the selected menu item.
         *
         * @return The price.
         */
        public Double getPrice() {
            return price;
        }

        /**
         * Sets the price of the selected menu item.
         *
         * @param price The price.
         */
        public void setPrice(Double price) {
            this.price = price;
        }
    }
}
