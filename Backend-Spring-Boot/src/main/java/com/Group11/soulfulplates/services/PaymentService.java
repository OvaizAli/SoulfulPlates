package com.Group11.soulfulplates.services;

import com.Group11.soulfulplates.payload.request.CreatePaymentRequest;
import com.Group11.soulfulplates.payload.response.PaymentFilterResponse;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
/**

 This service interface defines methods related to payment management.
 It provides functionality to create payments and transactions, update payment status, filter payments, and calculate the sum of payments for a store in a specific month.
 */
public interface PaymentService {
    Map<String, Object> createPaymentAndTransaction(CreatePaymentRequest request) throws Exception;
    void updatePaymentStatus(Long paymentId, Long transactionId, String status) throws Exception;
    List<PaymentFilterResponse> filterPayments(Long userId, String status, Integer limit, Integer offset);
    List<PaymentFilterResponse> filterSellerPayments(Long storeId, String status, Integer limit, Integer offset);
    BigDecimal getPaymentsSumForStoreAndMonth(int storeId, int month);
}
