package com.Group11.soulfulplates.repository;

import com.Group11.soulfulplates.models.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repository interface for Transaction entity.
 */
public interface TransactionRepository extends JpaRepository<Transaction, Long> {
}
