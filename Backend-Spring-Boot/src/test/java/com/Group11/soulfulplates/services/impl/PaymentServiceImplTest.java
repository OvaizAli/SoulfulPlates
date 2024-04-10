package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.*;
import com.Group11.soulfulplates.payload.request.CreatePaymentRequest;
import com.Group11.soulfulplates.payload.response.PaymentFilterResponse;
import com.Group11.soulfulplates.repository.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentMatchers;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

import java.math.BigDecimal;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class PaymentServiceImplTest {

    @InjectMocks
    private PaymentServiceImpl paymentService;

    @Mock
    private StoreRepository storeRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private TransactionRepository transactionRepository;

    @Mock
    private CartItemRepository cartItemRepository;

    @Mock
    private OrderRepository orderRepository;

    @Mock
    private PaymentRepository paymentRepository;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testCreatePaymentAndTransaction_InvalidUser() {
        // Arrange
        CreatePaymentRequest request = new CreatePaymentRequest();
        request.setUserId(null); // Set an invalid user ID
        request.setOrderId(1L);
        request.setStoreId(1L);
        request.setCardNumber("1234567890123456");
        request.setCardExpiry(String.valueOf(new Date()));
        request.setCvv("123");
        request.setAmount(BigDecimal.valueOf(100.0));

        // Act & Assert
        Exception exception = assertThrows(Exception.class, () -> {
            paymentService.createPaymentAndTransaction(request);
        });

        assertEquals("Invalid User Id", exception.getMessage());
    }

    @Test
    void createPaymentAndTransaction_Success() throws Exception {
        // Mock request
        CreatePaymentRequest request = new CreatePaymentRequest();
        request.setUserId(1L);
        request.setOrderId(1L);
        request.setAmount(BigDecimal.valueOf(100.0));
        request.setCardNumber("1234567890123456");
        request.setCardExpiry("12/23");
        request.setCvv("123");
        request.setStoreId(1L);

        // Mock entities
        Transaction transaction = new Transaction();
        transaction.setTransactionId(1L);
        transaction.setUser(new User());
        when(userRepository.findById(request.getUserId())).thenReturn(Optional.of(new User()));
        when(orderRepository.findById(request.getOrderId())).thenReturn(Optional.of(new Order()));
        when(storeRepository.findById(request.getStoreId())).thenReturn(Optional.of(new Store()));
        when(transactionRepository.save(any(Transaction.class))).thenReturn(transaction);

        // Mock cart items
        List<CartItem> cartItems = new ArrayList<>();
        when(cartItemRepository.findByOrderOrderId(request.getOrderId())).thenReturn(cartItems);

        // Mock payment
        Payment payment = new Payment();
        payment.setPaymentId(1L);
        when(paymentRepository.save(any(Payment.class))).thenReturn(payment);

        // Call the method
        Map<String, Object> result = paymentService.createPaymentAndTransaction(request);

        // Assertions
        assertNotNull(result);
        assertTrue(result.containsKey("Transaction_id"));
        assertTrue(result.containsKey("payment_id"));

        // Verify mocks
        verify(transactionRepository, times(1)).save(any(Transaction.class));
        verify(paymentRepository, times(1)).save(any(Payment.class));
    }

    @Test
    void filterPayments_Success() {
        // Mock data
        Long userId = 1L;
        String status = "Pending";
        Integer limit = 10;
        Integer offset = 0;

        // Mock payment objects
        List<Payment> mockPayments = new ArrayList<>();
        Payment payment = new Payment();
        payment.setPaymentId(1L);
        payment.setStatus(status);
        payment.setAmount(BigDecimal.valueOf(100.0));
        payment.setCreatedAt(new Date());
        payment.setUpdatedAt(new Date());
        payment.setTransaction(new Transaction());
        payment.getTransaction().setUser(new User());
        payment.getTransaction().getUser().setId(userId);
        payment.setOrder(new Order());
        payment.getOrder().setOrderId(1L);
        payment.setStore(new Store());
        payment.getStore().setStoreId(1L);
        mockPayments.add(payment);

        // Mock Page object with one item
        Page<Payment> mockPage = new PageImpl<>(mockPayments);

        // Mock paymentRepository behavior
        when(paymentRepository.findByTransactionUserIdAndStatusOrderByCreatedAtDesc(
                ArgumentMatchers.eq(userId),
                ArgumentMatchers.eq(status),
                ArgumentMatchers.any(PageRequest.class)))
                .thenReturn(mockPage);

        // Call the method
        List<PaymentFilterResponse> result = paymentService.filterPayments(userId, status, limit, offset);

        // Assertions
        assertNotNull(result);
        assertEquals(1, result.size());

        // Verify mocks
        verify(paymentRepository, times(1)).findByTransactionUserIdAndStatusOrderByCreatedAtDesc(
                ArgumentMatchers.eq(userId),
                ArgumentMatchers.eq(status),
                ArgumentMatchers.any(PageRequest.class));
    }

    @Test
    void filterSellerPayments_Success() {
        // Mock data
        Long storeId = 1L;
        String status = "Pending";
        Integer limit = 10;
        Integer offset = 0;

        // Mock payment objects
        List<Payment> mockPayments = new ArrayList<>();
        Payment payment = new Payment();
        payment.setPaymentId(1L);
        payment.setStatus(status);
        payment.setAmount(BigDecimal.valueOf(100.0));
        payment.setCreatedAt(new Date());
        payment.setUpdatedAt(new Date());
        payment.setTransaction(new Transaction());
        payment.getTransaction().setUser(new User());
        payment.getTransaction().getUser().setId(1L);
        payment.setOrder(new Order());
        payment.getOrder().setOrderId(1L);
        payment.setStore(new Store());
        payment.getStore().setStoreId(storeId);
        mockPayments.add(payment);

        // Mock Page object with one item
        Page<Payment> mockPage = new PageImpl<>(mockPayments);

        // Mock paymentRepository behavior
        when(paymentRepository.findByStoreStoreIdAndStatusOrderByCreatedAtDesc(
                ArgumentMatchers.eq(storeId),
                ArgumentMatchers.eq(status),
                ArgumentMatchers.any(PageRequest.class)))
                .thenReturn(mockPage);

        // Call the method
        List<PaymentFilterResponse> result = paymentService.filterSellerPayments(storeId, status, limit, offset);

        // Assertions
        assertNotNull(result);
        assertEquals(1, result.size());

        // Verify mocks
        verify(paymentRepository, times(1)).findByStoreStoreIdAndStatusOrderByCreatedAtDesc(
                ArgumentMatchers.eq(storeId),
                ArgumentMatchers.eq(status),
                ArgumentMatchers.any(PageRequest.class));
    }

    @Test
    void updatePaymentStatus_Success() throws Exception {
        // Mock data
        Long paymentId = 1L;
        Long transactionId = 1L;
        String status = "Success";

        Payment payment = new Payment();
        payment.setTransaction(new Transaction());
        payment.getTransaction().setTransactionId(transactionId);

        when(paymentRepository.findById(paymentId)).thenReturn(Optional.of(payment));

        // Call the method
        assertDoesNotThrow(() -> paymentService.updatePaymentStatus(paymentId, transactionId, status));

        // Verify mocks
        verify(paymentRepository, times(1)).findById(paymentId);
        verify(paymentRepository, times(1)).save(payment);
    }

    @Test
    void updatePaymentStatus_TransactionIdMismatch() {
        // Mock data
        Long paymentId = 1L;
        Long transactionId = 2L;
        String status = "Success";

        Payment payment = new Payment();
        payment.setTransaction(new Transaction());
        payment.getTransaction().setTransactionId(1L);

        when(paymentRepository.findById(paymentId)).thenReturn(Optional.of(payment));

        // Call the method and assert exception
        Exception exception = assertThrows(Exception.class, () -> paymentService.updatePaymentStatus(paymentId, transactionId, status));
        assertEquals("Transaction ID does not match the payment record", exception.getMessage());

        // Verify mocks
        verify(paymentRepository, times(1)).findById(paymentId);
        verify(paymentRepository, never()).save(payment);
    }

    @Test
    void updatePaymentStatus_PaymentNotFound() {
        // Mock data
        Long paymentId = 1L;
        Long transactionId = 1L;
        String status = "Success";

        when(paymentRepository.findById(paymentId)).thenReturn(Optional.empty());

        // Call the method and assert exception
        assertThrows(Exception.class, () -> paymentService.updatePaymentStatus(paymentId, transactionId, status));

        // Verify mocks
        verify(paymentRepository, times(1)).findById(paymentId);
        verify(paymentRepository, never()).save(any(Payment.class));
    }


}
