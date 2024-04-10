package com.Group11.soulfulplates.payload.request;

/**
 * Request payload for updating transaction status.
 */
public class UpdateTransactionStatusRequest {

    private Long transactionId;
    private String status;

    // Getters and Setters
    public Long getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(Long transactionId) {
        this.transactionId = transactionId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
