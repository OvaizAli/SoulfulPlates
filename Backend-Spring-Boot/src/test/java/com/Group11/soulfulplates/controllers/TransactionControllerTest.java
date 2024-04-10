package com.Group11.soulfulplates.controllers;

import com.Group11.soulfulplates.payload.request.UpdateTransactionStatusRequest;
import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.Group11.soulfulplates.services.TransactionService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.doThrow;

@ExtendWith(MockitoExtension.class)
public class TransactionControllerTest {

    @Mock
    private TransactionService transactionService;

    @InjectMocks
    private TransactionController transactionController;

    @Test
    public void testUpdateTransactionStatus_Success() throws Exception {
        // Mocking the service method to return successfully
        doNothing().when(transactionService).updateTransactionStatus(anyLong(), anyString());

        // Create an instance of UpdateTransactionStatusRequest with valid parameters
        UpdateTransactionStatusRequest request = new UpdateTransactionStatusRequest();
        request.setTransactionId(1L);
        request.setStatus("SUCCESS");

        // Calling the controller method with the created request
        ResponseEntity<?> responseEntity = transactionController.updateTransactionStatus(request);

        // Assertions
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals("Transaction status updated.", ((MessageResponse) responseEntity.getBody()).getDescription());
    }

    @Test
    public void testUpdateTransactionStatus_Failure() throws Exception {
        // Mocking the service method to throw an exception
        doThrow(new RuntimeException("Transaction not found")).when(transactionService).updateTransactionStatus(anyLong(), anyString());

        // Create an instance of UpdateTransactionStatusRequest with valid parameters
        UpdateTransactionStatusRequest request = new UpdateTransactionStatusRequest();
        request.setTransactionId(1L);
        request.setStatus("FAILED");

        // Calling the controller method with the created request
        ResponseEntity<?> responseEntity = transactionController.updateTransactionStatus(request);

        // Assertions
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        assertEquals("Error updating transaction: Transaction not found", ((MessageResponse) responseEntity.getBody()).getDescription());
    }


    @Test
    public void testUpdateTransactionStatus_NullRequest() throws Exception {
        // Calling the controller method with a null request
        ResponseEntity<?> responseEntity = transactionController.updateTransactionStatus(null);

        // Assertions
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
    }


    @Test
    public void testUpdateTransactionStatus_Failure_TransactionNotFound() throws Exception {
        // Mocking the service method to throw an exception
        doThrow(new RuntimeException("Transaction not found")).when(transactionService).updateTransactionStatus(anyLong(), anyString());

        // Create an instance of UpdateTransactionStatusRequest with valid parameters
        UpdateTransactionStatusRequest request = new UpdateTransactionStatusRequest();
        request.setTransactionId(1L);
        request.setStatus("FAILED");

        // Calling the controller method with the created request
        ResponseEntity<?> responseEntity = transactionController.updateTransactionStatus(request);

        // Assertions
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        assertEquals("Error updating transaction: Transaction not found", ((MessageResponse) responseEntity.getBody()).getDescription());
    }



    @Test
    public void testUpdateTransactionStatus_InvalidStatus() throws Exception {
        // Create an instance of UpdateTransactionStatusRequest with an invalid status
        UpdateTransactionStatusRequest request = new UpdateTransactionStatusRequest();
        request.setTransactionId(1L);
        request.setStatus("INVALID");

        // Calling the controller method with the created request
        ResponseEntity<?> responseEntity = transactionController.updateTransactionStatus(request);

        // Assertions
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        assertEquals("Error updating transaction: Invalid status provided.", ((MessageResponse) responseEntity.getBody()).getDescription());
    }
}
