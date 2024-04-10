package com.Group11.soulfulplates.payload.response;

import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

class PaymentFilterResponseTest {

    @Test
    void testConstructorAndGetters() {
        // Given
        Long userId = 1L;
        String username = "testUser";
        Long storeId = 2L;
        String storeName = "Test Store";
        BigDecimal amount = BigDecimal.valueOf(50.00);
        Long orderId = 100L;
        String cardNumber = "1234567890123456";
        String cardExpiry = "12/24";
        String cvv = "123";
        String paymentStatus = "Success";
        Long paymentId = 200L;
        Long transactionId = 300L;
        String status = "Completed";
        Date createdDate = new Date();
        Date updatedDate = new Date();

        // When
        PaymentFilterResponse paymentFilterResponse = new PaymentFilterResponse(
                userId, username, storeId, storeName, amount, orderId, cardNumber, cardExpiry, cvv,
                paymentStatus, paymentId, transactionId, status, createdDate, updatedDate
        );

        // Then
        assertNotNull(paymentFilterResponse);
        assertEquals(userId, paymentFilterResponse.getUserId());
        assertEquals(username, paymentFilterResponse.getUsername());
        assertEquals(storeId, paymentFilterResponse.getStoreId());
        assertEquals(storeName, paymentFilterResponse.getStoreName());
        assertEquals(amount, paymentFilterResponse.getAmount());
        assertEquals(orderId, paymentFilterResponse.getOrderId());
        assertEquals(cardNumber, paymentFilterResponse.getCardNumber());
        assertEquals(cardExpiry, paymentFilterResponse.getCardExpiry());
        assertEquals(cvv, paymentFilterResponse.getCvv());
        assertEquals(paymentStatus, paymentFilterResponse.getPaymentStatus());
        assertEquals(paymentId, paymentFilterResponse.getPaymentId());
        assertEquals(transactionId, paymentFilterResponse.getTransactionId());
        assertEquals(status, paymentFilterResponse.getStatus());
        assertEquals(createdDate, paymentFilterResponse.getCreatedDate());
        assertEquals(updatedDate, paymentFilterResponse.getUpdatedDate());
    }
}
