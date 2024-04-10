package com.Group11.soulfulplates.controllers;

import com.Group11.soulfulplates.payload.request.CreateRatingRequest;
import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.Group11.soulfulplates.services.RatingService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.mockito.Mockito.*;

class RatingControllerTest {

    @InjectMocks
    private RatingController ratingController;

    @Mock
    private RatingService ratingService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void addRating_Success() throws Exception {
        // Given
        CreateRatingRequest request = new CreateRatingRequest();
        request.setStoreId(1L);
        request.setRating((int) 4.5);

        // When
        ResponseEntity<?> responseEntity = ratingController.addRating(request);

        // Then
        assertEquals(HttpStatus.CREATED, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Rating Added.", ((MessageResponse) responseEntity.getBody()).getDescription());
        assertNull(((MessageResponse) responseEntity.getBody()).getData());
        verify(ratingService, times(1)).addRatingAndLinkToOrder(request);
    }

    @Test
    void getAverageRating_Success() throws Exception {
        // Given
        Long storeId = 1L;
        double expectedAverageRating = 4.5;
        when(ratingService.getAverageRating(storeId)).thenReturn(expectedAverageRating);

        // When
        ResponseEntity<?> responseEntity = ratingController.getAverageRating(storeId);

        // Then
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals(1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Success", ((MessageResponse) responseEntity.getBody()).getDescription());
        assertEquals(expectedAverageRating, ((MessageResponse) responseEntity.getBody()).getData());
    }

    @Test
    void getAverageRating_Exception() throws Exception {
        // Given
        Long storeId = 1L;
        when(ratingService.getAverageRating(storeId)).thenThrow(new RuntimeException("Error retrieving average rating"));

        // When
        ResponseEntity<?> responseEntity = ratingController.getAverageRating(storeId);

        // Then
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
        assertEquals(-1, ((MessageResponse) responseEntity.getBody()).getCode());
        assertEquals("Error retrieving average rating", ((MessageResponse) responseEntity.getBody()).getDescription());
        assertNull(((MessageResponse) responseEntity.getBody()).getData());
    }
}
