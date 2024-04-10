package com.Group11.soulfulplates.payload.request;

/**
 * Request payload for filtering payments by buyer.
 */
public class PaymentFilterRequestBuyer {
    private Long userId;
    private int limit;
    private int offset;
    private String status;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public int getOffset() {
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
