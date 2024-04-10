package com.Group11.soulfulplates.payload.request;

import java.math.BigDecimal;

/**
 * Request payload for creating a payment.
 */
public class CreatePaymentRequest {

    private Long userId;
    private Long storeId;
    private BigDecimal amount;
    private Long orderId;
    private String cardNumber;
    private String cardExpiry;
    private String cvv;

    /**
     * Retrieves the ID of the user making the payment.
     *
     * @return The user ID.
     */
    public Long getUserId() {
        return userId;
    }

    /**
     * Sets the ID of the user making the payment.
     *
     * @param userId The user ID.
     */
    public void setUserId(Long userId) {
        this.userId = userId;
    }

    /**
     * Retrieves the ID of the store for which the payment is being made.
     *
     * @return The store ID.
     */
    public Long getStoreId() {
        return storeId;
    }

    /**
     * Sets the ID of the store for which the payment is being made.
     *
     * @param storeId The store ID.
     */
    public void setStoreId(Long storeId) {
        this.storeId = storeId;
    }

    /**
     * Retrieves the amount of the payment.
     *
     * @return The payment amount.
     */
    public BigDecimal getAmount() {
        return amount;
    }

    /**
     * Sets the amount of the payment.
     *
     * @param amount The payment amount.
     */
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    /**
     * Retrieves the ID of the order associated with the payment.
     *
     * @return The order ID.
     */
    public Long getOrderId() {
        return orderId;
    }

    /**
     * Sets the ID of the order associated with the payment.
     *
     * @param orderId The order ID.
     */
    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    /**
     * Retrieves the card number used for the payment.
     *
     * @return The card number.
     */
    public String getCardNumber() {
        return cardNumber;
    }

    /**
     * Sets the card number used for the payment.
     *
     * @param cardNumber The card number.
     */
    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    /**
     * Retrieves the card expiry date used for the payment.
     *
     * @return The card expiry date.
     */
    public String getCardExpiry() {
        return cardExpiry;
    }

    /**
     * Sets the card expiry date used for the payment.
     *
     * @param cardExpiry The card expiry date.
     */
    public void setCardExpiry(String cardExpiry) {
        this.cardExpiry = cardExpiry;
    }

    /**
     * Retrieves the CVV code used for the payment.
     *
     * @return The CVV code.
     */
    public String getCvv() {
        return cvv;
    }

    /**
     * Sets the CVV code used for the payment.
     *
     * @param cvv The CVV code.
     */
    public void setCvv(String cvv) {
        this.cvv = cvv;
    }
}
