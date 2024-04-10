package com.Group11.soulfulplates.controllers;

import com.Group11.soulfulplates.controllers.WishlistController;
import com.Group11.soulfulplates.models.Wishlist;
import com.Group11.soulfulplates.payload.request.WishlistRequest;
import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.Group11.soulfulplates.services.impl.WishlistServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class WishlistControllerTest {

    @Mock
    private WishlistServiceImpl wishlistService;

    @InjectMocks
    private WishlistController wishlistController;

    private Wishlist wishlist;

    @BeforeEach
    void setUp() {
        wishlist = new Wishlist();
        MockitoAnnotations.openMocks(this);// Create a sample wishlist
    }

    @Test
    void getAllWishlists_ReturnsListOfWishlists() {
        // Arrange
        when(wishlistService.getAllWishlists()).thenReturn(List.of(wishlist));

        // Act
        List<Wishlist> result = wishlistController.getAllWishlists();

        // Assert
        assertEquals(1, result.size());
        assertEquals(wishlist, result.get(0));
    }

    @Test
    void getWishlistById_ValidId_ReturnsWishlist() {
        // Arrange
        when(wishlistService.getWishlistById(anyLong())).thenReturn(Optional.of(wishlist));

        // Act
        ResponseEntity<MessageResponse> response = wishlistController.getWishlistById(1L);

        // Assert
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals(1, response.getBody().getCode());
    }

    @Test
    void createWishlist_ValidRequest_ReturnsCreatedWishlist() {
        // Arrange
        WishlistRequest request = new WishlistRequest(); // Create a sample request
        when(wishlistService.saveOrUpdateWishlist(request)).thenReturn(wishlist);

        // Act
        ResponseEntity<MessageResponse> response = wishlistController.createWishlist(request);

        // Assert
        assertEquals(HttpStatus.CREATED, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals(1, response.getBody().getCode());
        assertEquals("Wishlist created", response.getBody().getDescription());
        assertEquals(wishlist, response.getBody().getData());
    }

    @Test
    void createWishlist_InvalidRequest_ReturnsFailedResponse() {
        // Arrange
        WishlistRequest request = null; // Invalid request

        // Act
        ResponseEntity<MessageResponse> response = wishlistController.createWishlist(request);

        // Assert
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals(-1, response.getBody().getCode());
        assertEquals("Failed to create wishlist", response.getBody().getDescription());
        assertNull(response.getBody().getData());
    }

    @Test
    void deleteWishlist_ValidId_ReturnsSuccessMessage() {
        // Arrange
        when(wishlistService.deleteWishlist(anyLong())).thenReturn(true);

        // Act
        ResponseEntity<MessageResponse> response = wishlistController.deleteWishlist(1L);

        // Assert
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals(1, response.getBody().getCode());
        assertEquals("Wishlist deleted", response.getBody().getDescription());
        assertNull(response.getBody().getData());
    }

    @Test
    void deleteWishlist_InvalidId_ReturnsFailureMessage() {
        // Arrange
        when(wishlistService.deleteWishlist(anyLong())).thenReturn(false);

        // Act
        ResponseEntity<MessageResponse> response = wishlistController.deleteWishlist(1L);

        // Assert
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals(-1, response.getBody().getCode());
        assertEquals("Failed to delete wishlist", response.getBody().getDescription());
        assertNull(response.getBody().getData());
    }

}
