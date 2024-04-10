package com.Group11.soulfulplates.repository;

import com.Group11.soulfulplates.models.Payment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.util.Optional;

/**
 * Repository interface for Payment entity.
 */
public interface PaymentRepository extends JpaRepository<Payment, Long> {

    /**
     * Retrieves an optional payment by order ID.
     * @param orderId The order ID.
     * @return An optional payment associated with the specified order ID.
     */
    Optional<Payment> findByOrderOrderId(Long orderId);

    /**
     * Retrieves the most recent payment by order ID.
     * @param orderId The order ID.
     * @return An optional payment associated with the specified order ID, ordered by payment ID in descending order.
     */
    Optional<Payment> findFirstByOrderOrderIdOrderByPaymentIdDesc(Long orderId);

    /**
     * Retrieves a page of payments by transaction user ID and status, ordered by creation date in descending order.
     * @param userId The user ID associated with the transaction.
     * @param status The status of the payments.
     * @param pageable The pagination information.
     * @return A page of payments associated with the specified user ID and status, ordered by creation date in descending order.
     */
    Page<Payment> findByTransactionUserIdAndStatusOrderByCreatedAtDesc(Long userId, String status, Pageable pageable);

    /**
     * Retrieves a page of payments by store ID and status, ordered by creation date in descending order.
     * @param userId The user ID.
     * @param status The status of the payments.
     * @param pageable The pagination information.
     * @return A page of payments associated with the specified store ID and status, ordered by creation date in descending order.
     */
    Page<Payment> findByStoreStoreIdAndStatusOrderByCreatedAtDesc(Long userId, String status, Pageable pageable);

    /**
     * Calculates the sum of payments for a store in a specific month.
     * @param storeId The ID of the store.
     * @param month The month for which to calculate the sum of payments.
     * @return The sum of payments for the specified store in the specified month.
     */
    @Query("SELECT SUM(p.amount) FROM Payment p WHERE MONTH(p.createdAt) = :month AND p.store.storeId = :storeId")
    BigDecimal sumByStoreIdAndMonth(@Param("storeId") int storeId, @Param("month") int month);
}
