package com.Group11.soulfulplates.services;

import com.Group11.soulfulplates.models.Transaction;

import java.util.Map;

/**
 * This service interface defines methods related to transactions.
 * It provides functionality to create and update transaction status.
 */
public interface TransactionService {
    /**
     * Creates a new transaction based on the provided request data.
     *
     * @param request A map containing transaction request data.
     * @return The created Transaction object.
     * @throws Exception If an error occurs during transaction creation.
     */
    Transaction createTransaction(Map<String, Object> request) throws Exception;

    /**
     * Updates the status of a transaction with the specified transaction ID.
     *
     * @param transactionId The ID of the transaction to update.
     * @param status The new status to set for the transaction.
     * @throws Exception If an error occurs during transaction status update.
     */
    void updateTransactionStatus(Long transactionId, String status) throws Exception;
}
