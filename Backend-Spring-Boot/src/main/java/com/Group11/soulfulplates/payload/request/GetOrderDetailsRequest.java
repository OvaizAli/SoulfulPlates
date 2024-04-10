package com.Group11.soulfulplates.payload.request;

/**
 * Request payload for retrieving order details.
 */
public class GetOrderDetailsRequest {

    private Long userId;
    private Long orderId;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }
}
