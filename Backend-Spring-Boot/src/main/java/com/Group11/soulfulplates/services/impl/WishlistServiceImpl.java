package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Wishlist;
import com.Group11.soulfulplates.payload.request.WishlistRequest;
import com.Group11.soulfulplates.repository.UserRepository;
import com.Group11.soulfulplates.repository.WishlistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 This class implements the WishlistService interface.
 It provides methods to manage wishlists, including retrieving all wishlists,
 getting a wishlist by ID, saving or updating a wishlist, and deleting a wishlist.
 */

@Service
public class WishlistServiceImpl {

    @Autowired
    private WishlistRepository wishlistRepository;

    @Autowired
    private UserRepository userRepository;

    public List<Wishlist> getAllWishlists() {
        return wishlistRepository.findAll();
    }

    public Optional<Wishlist> getWishlistById(Long id) {
        return wishlistRepository.findById(id);
    }

    public Wishlist saveOrUpdateWishlist(WishlistRequest wishlistRequest) {
        // Fetch all wishlists for the given user ID
        List<Wishlist> existingWishlistsForUser = getWishlistByUserId(wishlistRequest.getUserId());

        boolean hasSameMenuItem = existingWishlistsForUser.stream()
                .anyMatch(wishlist -> wishlist.getMenuItemId().equals(wishlistRequest.getMenuItemId()));

        if (hasSameMenuItem) {
            return null;
        }

        Wishlist wishlist = new Wishlist();
        wishlist.setUserId(wishlistRequest.getUserId());
        wishlist.setStoreId(wishlistRequest.getStoreId());
        wishlist.setMenuItemId(wishlistRequest.getMenuItemId());
        wishlist.setItemName(wishlistRequest.getItemName());
        wishlist.setItemPrice(wishlistRequest.getItemPrice());
        wishlist.setStoreEmail(wishlistRequest.getStoreEmail());
        wishlist.setStoreName(wishlistRequest.getStoreName());

        return wishlistRepository.save(wishlist);
    }

    public boolean deleteWishlist(Long id) {
        try {
            wishlistRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<Wishlist> getWishlistByUserId(Long userId) {
        // Fetch all wishlists from the repository
        List<Wishlist> allWishlists = wishlistRepository.findAll();

        List<Wishlist> wishlistsByUserId = allWishlists.stream()
                .filter(wishlist -> wishlist.getUserId().equals(userId))
                .collect(Collectors.toList());

        return wishlistsByUserId;
    }
}
