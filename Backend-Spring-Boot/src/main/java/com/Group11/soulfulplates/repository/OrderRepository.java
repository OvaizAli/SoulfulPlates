package com.Group11.soulfulplates.repository;

import com.Group11.soulfulplates.models.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    Optional<Order> findByOrderIdAndUserId(Long id, Long userId);
    Page<Order> findByUserIdAndStatusOrderByCreatedAtDesc(Long userId, String status, Pageable pageable);
    Page<Order> findByUserIdOrderByCreatedAtDesc(Long userId, String status, Pageable pageable);
    Page<Order> findByStoreStoreIdOrderByCreatedAtDesc(Long userId, String status, Pageable pageable);
    Page<Order> findByStoreStoreIdAndStatusOrderByCreatedAtDesc(Long userId, String status, Pageable pageable);
    // Method to count the number of orders for a store in a specific month
    @Query("SELECT COUNT(o) FROM Order o WHERE MONTH(o.createdAt) = :month AND o.store.storeId = :storeId")
    Long countByStoreIdAndMonth(@Param("storeId") int storeId, @Param("month") int month);
}
