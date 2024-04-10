package com.Group11.soulfulplates.repository;

import com.Group11.soulfulplates.models.CartItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository interface for CartItem entity.
 */
@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Long> {

    /**
     * Retrieves a list of cart items by order ID.
     * @param orderId The ID of the order.
     * @return A list of cart items associated with the specified order ID.
     */
    List<CartItem> findByOrderOrderId(Long orderId);
}
