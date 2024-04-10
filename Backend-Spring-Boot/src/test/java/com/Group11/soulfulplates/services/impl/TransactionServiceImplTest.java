package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Transaction;
import com.Group11.soulfulplates.models.User;
import com.Group11.soulfulplates.repository.TransactionRepository;
import com.Group11.soulfulplates.repository.UserRepository;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class TransactionServiceImplTest {

    @Mock
    private TransactionRepository transactionRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private TransactionServiceImpl transactionService;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testCreateTransaction_Success() throws Exception {
        // Mocking request parameters
        Map<String, Object> request = new HashMap<>();
        request.put("user_id", 1);
        request.put("card_number", "1234567890123456");
        request.put("card_expiry", "12/23");
        request.put("cvv", "123");

        // Mocking user repository response
        Mockito.when(userRepository.findById(1L)).thenReturn(Optional.of(new User()));

        // Mocking transaction repository save method
        Transaction savedTransaction = new Transaction();
        savedTransaction.setTransactionId(1L);
        savedTransaction.setUser(new User());
        savedTransaction.setCardNumber("1234567890123456");
        savedTransaction.setCardExpiry("12/23");
        savedTransaction.setCvv("123");
        savedTransaction.setStatus("Initiated");
        savedTransaction.setCreatedAt(new Date());
        savedTransaction.setUpdatedAt(new Date());
        Mockito.when(transactionRepository.save(Mockito.any(Transaction.class))).thenReturn(savedTransaction);

        // Perform the service method
        Transaction createdTransaction = transactionService.createTransaction(request);

        // Verify the transaction creation
        Assertions.assertNotNull(createdTransaction);
        Assertions.assertEquals("1234567890123456", createdTransaction.getCardNumber());
        Assertions.assertEquals("12/23", createdTransaction.getCardExpiry());
        Assertions.assertEquals("123", createdTransaction.getCvv());
        Assertions.assertEquals("Initiated", createdTransaction.getStatus());
        Assertions.assertNotNull(createdTransaction.getCreatedAt());
        Assertions.assertNotNull(createdTransaction.getUpdatedAt());
    }

    @Test
    public void testUpdateTransactionStatus_Success() throws Exception {
        // Mocking transaction repository response
        Transaction existingTransaction = new Transaction();
        existingTransaction.setTransactionId(1L);
        existingTransaction.setStatus("Initiated");
        existingTransaction.setCreatedAt(new Date());
        existingTransaction.setUpdatedAt(new Date());
        Mockito.when(transactionRepository.findById(1L)).thenReturn(Optional.of(existingTransaction));

        // Perform the service method
        transactionService.updateTransactionStatus(1L, "Completed");

        // Verify the updated status
        Assertions.assertEquals("Completed", existingTransaction.getStatus());
        Assertions.assertNotNull(existingTransaction.getUpdatedAt());
    }
}
