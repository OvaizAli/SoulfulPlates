package com.Group11.soulfulplates.payload.request;

import lombok.Data;

/**
 * Request payload for filtering payments by seller.
 */
@Data
public class PaymentFilterRequestSeller {
    private Long storeId;
    private int limit;
    private int offset;
    private String status;
}
