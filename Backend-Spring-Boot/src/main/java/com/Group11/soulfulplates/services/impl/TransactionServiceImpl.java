package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Transaction;
import com.Group11.soulfulplates.repository.TransactionRepository;
import com.Group11.soulfulplates.repository.UserRepository;
import com.Group11.soulfulplates.services.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Map;

/**
 This class implements the TransactionService interface.
 It provides methods to manage transactions, including creating a new transaction
 and updating the status of an existing transaction.
 */

@Service
public class TransactionServiceImpl implements TransactionService {

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private UserRepository userRepository; // Assume this exists

    @Override
    @Transactional
    public Transaction createTransaction(Map<String, Object> request) throws Exception {
        Transaction transaction = new Transaction();
        Exception userNotFound = new Exception("User not found");
        Integer req = (Integer) request.get("user_id");
        transaction.setUser(userRepository.findById(Long.valueOf(req)).orElseThrow(() ->userNotFound ));
        transaction.setCardNumber((String) request.get("card_number"));
        transaction.setCardExpiry((String) request.get("card_expiry")); // Adjust based on your entity's date type
        transaction.setCvv((String) request.get("cvv"));
        transaction.setStatus("Initiated"); // Example status, adjust as necessary
        transaction.setCreatedAt(new Date());
        transaction.setUpdatedAt(new Date());

        return transactionRepository.save(transaction);
    }

    @Override
    public void updateTransactionStatus(Long transactionId, String status) throws Exception {
        Exception transactionNotFound = new Exception("Transaction not found");
        Transaction transaction = transactionRepository.findById(transactionId).orElseThrow(() -> transactionNotFound);
        transaction.setStatus(status);
        transaction.setUpdatedAt(new Date());
        transactionRepository.save(transaction);
    }
}
