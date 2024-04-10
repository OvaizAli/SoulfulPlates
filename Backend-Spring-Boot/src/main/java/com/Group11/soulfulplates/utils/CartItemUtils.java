package com.Group11.soulfulplates.utils;

import com.Group11.soulfulplates.models.CartItem;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Utility class for performing operations on CartItem objects.
 */
public class CartItemUtils {

    /**
     * Extracts item IDs from a list of CartItems.
     *
     * @param cartItems The list of CartItems from which to extract item IDs.
     * @return A list of item IDs extracted from the CartItems.
     */
    public static List<Long> extractItemIds(List<CartItem> cartItems) {
        return cartItems.stream() // Convert the list to a stream
                .map(CartItem::getItemId) // Transform each CartItem to its itemId
                .collect(Collectors.toList()); // Collect the results into a new list
    }

    /**
     * Calculates the total price for all CartItems in the list.
     *
     * @param cartItems The list of CartItems for which to calculate the total price.
     * @return The total price of all CartItems in the list.
     */
    public static Double getTotalForOrderId(List<CartItem> cartItems) {
        return cartItems.stream() // Convert the list to a stream
                .map(cartItem -> cartItem.getPrice() * cartItem.getQuantity()) // Calculate the total price for each CartItem
                .reduce(0.0, Double::sum); // Sum up all the calculated prices
    }
}
