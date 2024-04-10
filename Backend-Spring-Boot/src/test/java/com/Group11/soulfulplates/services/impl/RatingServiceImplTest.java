package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Order;
import com.Group11.soulfulplates.models.Rating;
import com.Group11.soulfulplates.payload.request.CreateRatingRequest;
import com.Group11.soulfulplates.repository.OrderRepository;
import com.Group11.soulfulplates.repository.RatingRepository;
import com.Group11.soulfulplates.repository.StoreRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.*;

class RatingServiceImplTest {

    @Mock
    private RatingRepository ratingRepository;

    @Mock
    private OrderRepository orderRepository;

    @Mock
    private StoreRepository storeRepository;

    @InjectMocks
    private RatingServiceImpl ratingService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void testGetAverageRating() {
        // Mocking data
        Rating rating1 = new Rating();
        rating1.setRating((int) 4.0);
        Rating rating2 = new Rating();
        rating2.setRating((int) 3.0);

        when(ratingRepository.findByStoreStoreId(1L)).thenReturn(Arrays.asList(rating1, rating2));

        // Test
        double averageRating = ratingService.getAverageRating(1L);
        assertEquals(3.5, averageRating);
    }

    @Test
    void testGetAverageRating_EmptyRatings() {
        when(ratingRepository.findByStoreStoreId(1L)).thenReturn(Arrays.asList());

        // Test
        double averageRating = ratingService.getAverageRating(1L);
        assertEquals(0, averageRating);
    }

    @Test
    void testAddRatingAndLinkToOrder_InvalidOrder() {
        // Mocking data with null order ID
        CreateRatingRequest ratingRequest = new CreateRatingRequest();
        ratingRequest.setStoreId(1L); // Providing store ID
        ratingRequest.setRating((int) 4.5);
        ratingRequest.setFeedback("Good service");

        // Test
        Exception exception = assertThrows(Exception.class, () -> ratingService.addRatingAndLinkToOrder(ratingRequest));
        assertEquals("Order is Null in request", exception.getMessage());
    }

    @Test
    void addRatingAndLinkToOrder_OrderIdNull() {
        // Mock request with null order ID
        CreateRatingRequest ratingData = new CreateRatingRequest();
        ratingData.setOrderId(null);

        // Call the method and assert exception
        Exception exception = assertThrows(Exception.class, () -> ratingService.addRatingAndLinkToOrder(ratingData));
        assertEquals("Order is Null in request", exception.getMessage());

        // Verify mocks
        verifyNoInteractions(orderRepository);
        verifyNoInteractions(storeRepository);
        verifyNoInteractions(ratingRepository);
    }

    @Test
    void addRatingAndLinkToOrder_StoreIdNull() {
        // Mock request with null store ID
        CreateRatingRequest ratingData = new CreateRatingRequest();
        ratingData.setOrderId(1L); // Setting a valid order ID
        ratingData.setStoreId(null);

        // Call the method and assert exception
        Exception exception = assertThrows(Exception.class, () -> ratingService.addRatingAndLinkToOrder(ratingData));
        assertEquals("Store Id is Null in request", exception.getMessage());

        // Verify mocks
        verifyNoInteractions(orderRepository);
        verifyNoInteractions(storeRepository);
        verifyNoInteractions(ratingRepository);
    }

    @Test
    void addRatingAndLinkToOrder_OrderNotFound() {
        // Mock request with valid order ID
        CreateRatingRequest ratingData = new CreateRatingRequest();
        ratingData.setOrderId(1L); // Setting a valid order ID
        ratingData.setStoreId(1L); // Setting a valid store ID

        // Mock order repository to return an empty Optional (order not found)
        when(orderRepository.findById(ratingData.getOrderId())).thenReturn(Optional.empty());

        // Call the method and assert exception
        Exception exception = assertThrows(Exception.class, () -> ratingService.addRatingAndLinkToOrder(ratingData));
        assertEquals("Order not found", exception.getMessage());

        // Verify mocks
        verify(orderRepository, times(1)).findById(ratingData.getOrderId());
        verifyNoInteractions(storeRepository);
        verifyNoInteractions(ratingRepository);
    }

    @Test
    void addRatingAndLinkToOrder_NewRating() throws Exception {
        // Mocking data
        CreateRatingRequest ratingData = new CreateRatingRequest();
        ratingData.setOrderId(1L); // Providing order ID
        ratingData.setStoreId(1L); // Providing store ID
        ratingData.setRating((int) 4.5);
        ratingData.setFeedback("Good service");

        Order order = new Order();
        order.setOrderId(ratingData.getOrderId());

        // Mock order repository to return a valid order
        when(orderRepository.findById(ratingData.getOrderId())).thenReturn(Optional.of(order));

        // Mock store repository to return an empty Optional (store not found)
        when(storeRepository.findById(ratingData.getStoreId())).thenReturn(Optional.empty());

        // Test
        Exception exception = assertThrows(Exception.class, () -> ratingService.addRatingAndLinkToOrder(ratingData));
        assertEquals("Store not found", exception.getMessage());

        // Verify that repositories were called
        verify(orderRepository, times(1)).findById(ratingData.getOrderId());
        verify(storeRepository, times(1)).findById(ratingData.getStoreId());
        verifyNoInteractions(ratingRepository); // Ensure rating repository was not called
    }


    @Test
    void addRatingAndLinkToOrder_StoreNotFound() {
        // Mock request with valid order ID but invalid store ID
        CreateRatingRequest ratingData = new CreateRatingRequest();
        ratingData.setOrderId(1L); // Setting a valid order ID
        ratingData.setStoreId(1L); // Setting an invalid store ID

        // Mock order repository to return a valid order
        Order order = new Order();
        order.setOrderId(ratingData.getOrderId());
        when(orderRepository.findById(ratingData.getOrderId())).thenReturn(Optional.of(order));

        // Mock store repository to return an empty Optional (store not found)
        when(storeRepository.findById(ratingData.getStoreId())).thenReturn(Optional.empty());

        // Call the method and assert exception
        Exception exception = assertThrows(Exception.class, () -> ratingService.addRatingAndLinkToOrder(ratingData));
        assertEquals("Store not found", exception.getMessage());

        // Verify mocks
        verify(orderRepository, times(1)).findById(ratingData.getOrderId());
        verify(storeRepository, times(1)).findById(ratingData.getStoreId());
        verifyNoInteractions(ratingRepository);
    }

    @Test
    void addRatingAndLinkToOrder_NullOrder() {
        // Mock request with null order ID
        CreateRatingRequest ratingData = new CreateRatingRequest();
        ratingData.setOrderId(null);
        ratingData.setStoreId(1L); // Providing store ID
        ratingData.setRating((int) 4.5);
        ratingData.setFeedback("Good service");

        // Call the method and assert exception
        Exception exception = assertThrows(Exception.class, () -> ratingService.addRatingAndLinkToOrder(ratingData));
        assertEquals("Order is Null in request", exception.getMessage());

        // Verify mocks
        verifyNoInteractions(orderRepository);
        verifyNoInteractions(storeRepository);
        verifyNoInteractions(ratingRepository);
    }

    @Test
    public void testAddRatingAndLinkToOrder_RatingSaveException() throws Exception {
        // Mock request with valid data
        CreateRatingRequest ratingData = new CreateRatingRequest();
        ratingData.setOrderId(1L);
        ratingData.setStoreId(1L);
        ratingData.setRating((int) 4.0);
        ratingData.setFeedback("Good service");

        // Mock order and store to return valid data
        Order order = new Order();
        order.setOrderId(ratingData.getOrderId());
        when(orderRepository.findById(ratingData.getOrderId())).thenReturn(Optional.of(order));
        when(storeRepository.findById(ratingData.getStoreId())).thenReturn(Optional.of(new com.Group11.soulfulplates.models.Store()));

        // Mock exception during rating save
        doThrow(new RuntimeException("Mock exception")).when(ratingRepository).save(any(Rating.class));

        // Call the method and assert exception
        Exception exception = assertThrows(Exception.class, () -> ratingService.addRatingAndLinkToOrder(ratingData));
        // Assert the specific exception message (if applicable)

        // Verify interactions
        verify(orderRepository, times(1)).findById(ratingData.getOrderId());
        verify(storeRepository, times(1)).findById(ratingData.getStoreId());
        verify(ratingRepository, times(1)).save(any(Rating.class));
    }
    @Test
    public void testAddRatingAndLinkToOrder_MissingRatingData() throws Exception {
        // Mock request with missing rating
        CreateRatingRequest ratingData = new CreateRatingRequest();
        ratingData.setOrderId(1L);
        ratingData.setStoreId(1L);

        // Call the method and assert exception
        Exception exception = assertThrows(Exception.class, () -> ratingService.addRatingAndLinkToOrder(ratingData));
        assertEquals("Order not found", exception.getMessage()); // Adjust based on actual exception message
    }

}
