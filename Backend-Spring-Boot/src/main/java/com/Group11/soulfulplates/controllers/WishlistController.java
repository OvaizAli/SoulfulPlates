package com.Group11.soulfulplates.controllers;

import com.Group11.soulfulplates.models.Wishlist;
import com.Group11.soulfulplates.payload.request.WishlistRequest;
import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.Group11.soulfulplates.services.impl.WishlistServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

/**
 * Controller class to manage operations related to wishlists.
 */
@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/wishlist")
public class WishlistController {

    @Autowired
    private WishlistServiceImpl wishlistService;

    /**
     * Retrieves all wishlists.
     *
     * @return A list of all wishlists.
     */
    @PreAuthorize("hasRole('ROLE_BUYER')")
    @GetMapping("/getAll")
    public List<Wishlist> getAllWishlists() {
        return wishlistService.getAllWishlists();
    }

    /**
     * Retrieves a wishlist by its ID.
     *
     * @param id The ID of the wishlist to retrieve.
     * @return ResponseEntity containing a MessageResponse with information about the wishlist.
     */
    @PreAuthorize("hasRole('ROLE_BUYER')")
    @GetMapping( "/{id}")
    public ResponseEntity<MessageResponse> getWishlistById(@PathVariable Long id) {
        Optional<Wishlist> wishlist = wishlistService.getWishlistById(id);
        MessageResponse notFoundResponse = new MessageResponse(-1, "Wishlist not found", null);
        return wishlist.map(this::createWishlistFoundResponse).orElseGet(() -> ResponseEntity.ok(notFoundResponse));
    }

    /**
     * Helper method to create a response entity for a found wishlist.
     *
     * @param value The wishlist found.
     * @return ResponseEntity containing a MessageResponse with information about the found wishlist.
     */
    private ResponseEntity<MessageResponse> createWishlistFoundResponse(Wishlist value) {
        return ResponseEntity.ok(new MessageResponse(1, "Wishlist found", value));
    }

    /**
     * Creates a new wishlist.
     *
     * @param wishlistRequest The request object containing wishlist details.
     * @return ResponseEntity containing a MessageResponse with information about the created wishlist.
     */
    @PreAuthorize("hasRole('ROLE_BUYER')")
    @PostMapping("/create")
    public ResponseEntity<MessageResponse> createWishlist(@RequestBody WishlistRequest wishlistRequest) {
        System.out.println(wishlistRequest);
        Wishlist createdWishlist = wishlistService.saveOrUpdateWishlist(wishlistRequest);
        if (createdWishlist != null) {
            return ResponseEntity.status(HttpStatus.CREATED).body(new MessageResponse(1, "Wishlist created", createdWishlist));
        } else {
            return ResponseEntity.ok(new MessageResponse(-1, "Failed to create wishlist", null));
        }
    }

    /**
     * Retrieves wishlists by user ID.
     *
     * @param userId The ID of the user.
     * @return ResponseEntity containing a MessageResponse with information about the wishlists belonging to the user.
     */
    @PreAuthorize("hasRole('ROLE_BUYER')")
    @GetMapping("/user/{userId}")
    public ResponseEntity<MessageResponse> getWishlistByUserId(@PathVariable Long userId) {
        List<Wishlist> wishlists = wishlistService.getWishlistByUserId(userId);
        if (!wishlists.isEmpty()) {
            return ResponseEntity.ok(new MessageResponse(1, "Wishlist by this User Id found", wishlists));
        } else {
            return ResponseEntity.ok(new MessageResponse(-1, "Wishlist by this User Id not found", null));
        }
    }




//    @PutMapping("/{id}")
//    public ResponseEntity<MessageResponse> updateWishlist(@PathVariable Long id, @RequestBody WishlistRequest wishlistRequest) {
//        // Ensure the wishlistRequest has an ID set
//        wishlistRequest.setId(id);
//        Wishlist updatedWishlist = wishlistService.saveOrUpdateWishlist(wishlistRequest);
//        if (updatedWishlist != null) {
//            return ResponseEntity.ok(new MessageResponse(1, "Wishlist updated", updatedWishlist));
//        } else {
//            return ResponseEntity.ok(new MessageResponse(-1, "Failed to update wishlist", null));
//        }
//    }

    /**
     * Deletes a wishlist by its ID.
     *
     * @param id The ID of the wishlist to delete.
     * @return ResponseEntity containing a MessageResponse with information about the deletion status.
     */
    @PreAuthorize("hasRole('ROLE_BUYER')")
    @DeleteMapping("delete/{id}")
    public ResponseEntity<MessageResponse> deleteWishlist(@PathVariable Long id) {
        boolean deleted = wishlistService.deleteWishlist(id);
        if (deleted) {
            return ResponseEntity.ok(new MessageResponse(1, "Wishlist deleted", null));
        } else {
            return ResponseEntity.ok(new MessageResponse(-1, "Failed to delete wishlist", null));
        }
    }
}
