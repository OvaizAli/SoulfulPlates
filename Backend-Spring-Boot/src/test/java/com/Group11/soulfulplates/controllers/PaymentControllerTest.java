package com.Group11.soulfulplates.controllers;

import com.Group11.soulfulplates.payload.request.CreatePaymentRequest;
import com.Group11.soulfulplates.payload.request.PaymentFilterRequestBuyer;
import com.Group11.soulfulplates.payload.request.PaymentFilterRequestSeller;
import com.Group11.soulfulplates.payload.request.UpdatePaymentStatusRequest;
import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.Group11.soulfulplates.payload.response.PaymentFilterResponse;
import com.Group11.soulfulplates.services.PaymentService;
import com.Group11.soulfulplates.utils.FormatValidations;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;
import static org.mockito.Mockito.*;

class PaymentControllerTest {

    @InjectMocks
    private PaymentController paymentController;

    @Mock
    private PaymentService paymentService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }


    @Test
    public void createPaymentAndTransaction_Success() {
        // Given
        CreatePaymentRequest request = createValidPaymentRequest();
        try (MockedStatic<FormatValidations> utilities = Mockito.mockStatic(FormatValidations.class)) {
            utilities.when(() -> FormatValidations.verifyCardNumber(anyString())).thenReturn(true);
            utilities.when(() -> FormatValidations.verifyCardExpiry(anyString())).thenReturn(true);
            utilities.when(() -> FormatValidations.verifyCvv(anyString())).thenReturn(true);

            Map<String, Object> responseMap = new HashMap<>();
            try {
                when(paymentService.createPaymentAndTransaction(request)).thenReturn(responseMap);
                ResponseEntity<?> responseEntity = paymentController.createPaymentAndTransaction(request);
                // Then
                assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
            } catch (Exception e) {
                fail("An exception should not have been thrown");
            }
        }
    }

    @Test
    public void createPaymentAndTransaction_InvalidDetails() {
        // Given
        CreatePaymentRequest request = createValidPaymentRequest();
        try (MockedStatic<FormatValidations> utilities = Mockito.mockStatic(FormatValidations.class)) {
            utilities.when(() -> FormatValidations.verifyCardNumber(anyString())).thenReturn(false); // Simulate invalid card number

            // When
            ResponseEntity<?> responseEntity = paymentController.createPaymentAndTransaction(request);

            // Then
            assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        }
    }

    @Test
    public void createPaymentAndTransaction_ServiceFailure() throws Exception { // declare that it throws Exception
        // Given
        CreatePaymentRequest request = createValidPaymentRequest();
        try (MockedStatic<FormatValidations> utilities = Mockito.mockStatic(FormatValidations.class)) {
            utilities.when(() -> FormatValidations.verifyCardNumber(anyString())).thenReturn(true);
            utilities.when(() -> FormatValidations.verifyCardExpiry(anyString())).thenReturn(true);
            utilities.when(() -> FormatValidations.verifyCvv(anyString())).thenReturn(true);

            when(paymentService.createPaymentAndTransaction(request)).thenThrow(new RuntimeException("Service failure"));

            // When
            ResponseEntity<?> responseEntity = paymentController.createPaymentAndTransaction(request);

            // Then
            assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        }
    }

    // Utility to create a valid payment request
    private CreatePaymentRequest createValidPaymentRequest() {
        CreatePaymentRequest request = new CreatePaymentRequest();
        request.setCardExpiry("12/22");
        request.setCvv("123");
        request.setCardNumber("1234-5678-9123");
        return request;
    }

    @Test
    void updatePaymentStatus_Success() throws Exception {
        // Given
        UpdatePaymentStatusRequest request = new UpdatePaymentStatusRequest();

        // When
        ResponseEntity<?> responseEntity = paymentController.updatePaymentStatus(request);

        // Then
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        verify(paymentService, times(1)).updatePaymentStatus(request.getPaymentId(), request.getTransactionId(), request.getStatus());
    }

    @Test
    void updatePaymentStatus_Failure() throws Exception {
        // Given
        UpdatePaymentStatusRequest request = new UpdatePaymentStatusRequest();
        request.setPaymentId(1L);
        request.setTransactionId(1L);
        request.setStatus("Failed");

        doThrow(new RuntimeException("Error updating payment status")).when(paymentService)
                .updatePaymentStatus(anyLong(), anyLong(), anyString());

        // When
        ResponseEntity<?> responseEntity = paymentController.updatePaymentStatus(request);

        // Then
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        verify(paymentService, times(1)).updatePaymentStatus(request.getPaymentId(),
                request.getTransactionId(), request.getStatus());
    }

    @Test
    void testFilterSellerPayments_Success() throws Exception {
        // Given
        PaymentFilterRequestSeller request = new PaymentFilterRequestSeller();
        List<PaymentFilterResponse> payments = new ArrayList<>();
        when(paymentService.filterPayments(anyLong(), anyString(), anyInt(), anyInt()))
                .thenReturn(payments);

        // When
        ResponseEntity<?> responseEntity = paymentController.filterSellerPayments(request);

        // Then
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Success", ((MessageResponse) responseEntity.getBody()).getDescription());
        assertEquals(payments, ((MessageResponse) responseEntity.getBody()).getData());
    }

//    @Test
//    public void testFilterSellerPayments_Exception() {
//        PaymentFilterRequestSeller request = new PaymentFilterRequestSeller();
//        request.setStoreId(1L);
//        request.setStatus("success");
//        request.setLimit(10);
//        request.setOffset(0);
//
//        when(paymentService.filterPayments(anyLong(), anyString(), anyInt(), anyInt())).thenThrow(new RuntimeException("Test Exception"));
//
//        ResponseEntity<?> responseEntity = paymentController.filterSellerPayments(request);
//
//        assertEquals(HttpStatus.INTERNAL_SERVER_ERROR, responseEntity.getStatusCode());
//        assertEquals(-1, ((MessageResponse) responseEntity.getBody()).getCode());
//        assertEquals("Failure", ((MessageResponse) responseEntity.getBody()).getDescription());
//        assertEquals(null, ((MessageResponse) responseEntity.getBody()).getData());
//
//        verify(paymentService, times(1)).filterPayments(anyLong(), anyString(), anyInt(), anyInt());
//    }

    @Test
    public void testFilterPayments_Success() {
        PaymentFilterRequestBuyer request = new PaymentFilterRequestBuyer();
        request.setUserId(1L);
        request.setStatus("success");
        request.setLimit(10);
        request.setOffset(0);

        List<PaymentFilterResponse> mockResponse = new ArrayList<>();
        PaymentFilterResponse responseItem = new PaymentFilterResponse();

        responseItem.setUserId(1L);
        responseItem.setStatus("success");
        mockResponse.add(responseItem);

        when(paymentService.filterPayments(anyLong(), anyString(), anyInt(), anyInt())).thenReturn(mockResponse);

        ResponseEntity<?> responseEntity = paymentController.filterPayments(request);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Success", ((MessageResponse) responseEntity.getBody()).getDescription());
        assertEquals(mockResponse, ((MessageResponse) responseEntity.getBody()).getData());

        verify(paymentService, times(1)).filterPayments(anyLong(), anyString(), anyInt(), anyInt());
    }
//    @Test
//    public void testFilterPayments_Exception() {
//        PaymentFilterRequestBuyer request = new PaymentFilterRequestBuyer();
//        request.setUserId(1L);
//        request.setStatus("success");
//        request.setLimit(10);
//        request.setOffset(0);
//
//        when(paymentService.filterPayments(anyLong(), anyString(), anyInt(), anyInt())).thenThrow(new RuntimeException("Test Exception"));
//
//        ResponseEntity<?> responseEntity = paymentController.filterPayments(request);
//
//        assertEquals(HttpStatus.INTERNAL_SERVER_ERROR, responseEntity.getStatusCode());
//        assertEquals(-1, ((MessageResponse) responseEntity.getBody()).getCode());
//        assertEquals("Failure", ((MessageResponse) responseEntity.getBody()).getDescription());
//        assertEquals(null, ((MessageResponse) responseEntity.getBody()).getData());
//
//        verify(paymentService, times(1)).filterPayments(anyLong(), anyString(), anyInt(), anyInt());
//    }
}

