package com.Group11.soulfulplates.payload.response;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Response payload for payment filtering.
 */
@Data
public class PaymentFilterResponse {
    private Long userId;
    private String username;
    private Long storeId;
    private String storeName;
    private BigDecimal amount;
    private Long orderId;
    private String cardNumber;
    private String cardExpiry;
    private String cvv;
    private String paymentStatus;
    private Long paymentId;
    private Long transactionId;
    private String status;
    private Date createdDate;
    private Date updatedDate;

    // Constructors
    public PaymentFilterResponse() {}

    public PaymentFilterResponse(Long userId, String username, Long storeId, String storeName, BigDecimal amount, Long orderId, String cardNumber,
                                 String cardExpiry, String cvv, String paymentStatus, Long paymentId,
                                 Long transactionId, String status, Date createdDate, Date updatedDate) {
        this.userId = userId;
        this.username = username;
        this.storeId = storeId;
        this.storeName = storeName;
        this.amount = amount;
        this.orderId = orderId;
        this.cardNumber = cardNumber;
        this.cardExpiry = cardExpiry;
        this.cvv = cvv;
        this.paymentStatus = paymentStatus;
        this.paymentId = paymentId;
        this.transactionId = transactionId;
        this.status = status;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }
}
