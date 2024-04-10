package com.Group11.soulfulplates.payload.response;

/**
 * Response payload for creating an order.
 */
public class CreateOrderResponse {
    private int code;
    private String description;
    private Data data;

    public CreateOrderResponse(int code, Data data, String description) {
        this.code = code;
        this.data = data;
        this.description = description;
    }

    public static class Data {
        private Long orderId;

        public Data(Long orderId) {
            this.orderId = orderId;
        }

        // Getters and Setters

        public Long getOrderId() {
            return orderId;
        }

        public void setOrderId(Long orderId) {
            this.orderId = orderId;
        }
    }

    // Getters and Setters

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Data getData() {
        return data;
    }

    public void setData(Data data) {
        this.data = data;
    }
}
