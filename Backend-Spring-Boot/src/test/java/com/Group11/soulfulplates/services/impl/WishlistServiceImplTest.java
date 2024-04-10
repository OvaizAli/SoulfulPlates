package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Wishlist;
import com.Group11.soulfulplates.payload.request.WishlistRequest;
import com.Group11.soulfulplates.repository.UserRepository;
import com.Group11.soulfulplates.repository.WishlistRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class WishlistServiceImplTest {

    @Mock
    private WishlistRepository wishlistRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private WishlistServiceImpl wishlistService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void testGetAllWishlists() {
        List<Wishlist> wishlistList = new ArrayList<>();
        when(wishlistRepository.findAll()).thenReturn(wishlistList);

        List<Wishlist> result = wishlistService.getAllWishlists();

        assertEquals(wishlistList, result);
        verify(wishlistRepository, times(1)).findAll();
    }

    @Test
    void testDeleteWishlist() {
        doNothing().when(wishlistRepository).deleteById(1L);

        boolean result = wishlistService.deleteWishlist(1L);

        assertTrue(result);
        verify(wishlistRepository, times(1)).deleteById(1L);
    }

    @Test
    void testDeleteWishlistFailure() {
        doThrow(RuntimeException.class).when(wishlistRepository).deleteById(1L);

        boolean result = wishlistService.deleteWishlist(1L);

        assertFalse(result);
        verify(wishlistRepository, times(1)).deleteById(1L);
    }

    @Test
    void testGetWishlistById_ExistingId_ShouldReturnWishlist() {
        Wishlist expectedWishlist = new Wishlist();
        expectedWishlist.setWishId(1L);

        when(wishlistRepository.findById(1L)).thenReturn(Optional.of(expectedWishlist));

        Optional<Wishlist> result = wishlistService.getWishlistById(1L);

        assertTrue(result.isPresent());
        assertEquals(expectedWishlist.getWishId(), result.get().getWishId());
        verify(wishlistRepository, times(1)).findById(1L);
    }

    @Test
    void testGetWishlistById_NonExistingId_ShouldReturnEmptyOptional() {
        when(wishlistRepository.findById(1L)).thenReturn(Optional.empty());

        Optional<Wishlist> result = wishlistService.getWishlistById(1L);

        assertFalse(result.isPresent());
        verify(wishlistRepository, times(1)).findById(1L);
    }

    @Test
    void testSaveOrUpdateWishlist_NewWishlist_ShouldSaveAndReturnWishlist() {
        WishlistRequest wishlistRequest = new WishlistRequest();
        wishlistRequest.setUserId(1L);
        wishlistRequest.setMenuItemId(1L);

        Wishlist wishlistToSave = new Wishlist();
        wishlistToSave.setUserId(1L);
        wishlistToSave.setMenuItemId(1L);

        // Mocking existing wishlists for the user
        List<Wishlist> existingWishlists = new ArrayList<>();

        when(wishlistService.getWishlistByUserId(1L)).thenReturn(existingWishlists);
        when(wishlistRepository.save(any(Wishlist.class))).thenReturn(wishlistToSave);

        Wishlist result = wishlistService.saveOrUpdateWishlist(wishlistRequest);

        assertNotNull(result);
        assertEquals(wishlistToSave.getUserId(), result.getUserId());
        assertEquals(wishlistToSave.getMenuItemId(), result.getMenuItemId());
        verify(wishlistRepository, times(1)).save(any(Wishlist.class)); // Verify repository method call
    }


    @Test
    void testSaveOrUpdateWishlist_ExistingWishlist_ShouldReturnNull() {
        WishlistRequest wishlistRequest = new WishlistRequest();
        wishlistRequest.setUserId(1L);
        wishlistRequest.setMenuItemId(1L);

        Wishlist existingWishlist = new Wishlist();
        existingWishlist.setUserId(1L);
        existingWishlist.setMenuItemId(1L);

        List<Wishlist> existingWishlists = new ArrayList<>();
        existingWishlists.add(existingWishlist);

        when(wishlistRepository.findAll()).thenReturn(existingWishlists);

        Wishlist result = wishlistService.saveOrUpdateWishlist(wishlistRequest);

        assertNull(result);
        verify(wishlistRepository, times(1)).findAll();
        verify(wishlistRepository, never()).save(any(Wishlist.class));
    }


}
