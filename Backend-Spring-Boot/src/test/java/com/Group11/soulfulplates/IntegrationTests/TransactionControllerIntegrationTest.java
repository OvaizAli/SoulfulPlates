package com.Group11.soulfulplates.IntegrationTests;

import com.Group11.soulfulplates.controllers.TransactionController;
import com.Group11.soulfulplates.payload.request.UpdateTransactionStatusRequest;
import com.Group11.soulfulplates.services.TransactionService;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.doThrow;

/**
 * Integration tests for the TransactionController class.
 */

@SpringBootTest
@AutoConfigureMockMvc
class TransactionControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Mock
    private TransactionService transactionService;

    @InjectMocks
    private TransactionController transactionController;

    /**
     * Test case for unauthorized access when updating transaction status.
     * @throws Exception if any error occurs during the test
     */
    @Test
    void testUpdateTransactionStatus_Unauthorized() throws Exception {
        // Mock the service method to throw an exception
        doThrow(new RuntimeException("Unauthorized access")).when(transactionService).updateTransactionStatus(anyLong(), anyString());

        // Create an instance of UpdateTransactionStatusRequest with valid parameters
        UpdateTransactionStatusRequest request = new UpdateTransactionStatusRequest();
        request.setTransactionId(1L);
        request.setStatus("SUCCESS");

        // Call controller method with the created request
        mockMvc.perform(MockMvcRequestBuilders.post("/api/payments/updateTransactionStatus")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"transactionId\": 1, \"status\": \"SUCCESS\"}"))
                .andExpect(MockMvcResultMatchers.status().isForbidden()); // Expect 403 Forbidden
    }

}
