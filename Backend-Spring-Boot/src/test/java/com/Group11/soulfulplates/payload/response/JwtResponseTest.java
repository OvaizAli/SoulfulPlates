package com.Group11.soulfulplates.payload.response;

import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class JwtResponseTest {

    @Test
    public void testJwtResponseConstructorWithoutSeller() {
        String accessToken = "access_token";
        Long id = 1L;
        String username = "username";
        String email = "test@example.com";
        List<String> roles = Arrays.asList("ROLE_USER");
        String contactNumber = "1234567890";
        String firstname = "John";
        boolean notificationFlag = true;

        JwtResponse jwtResponse = new JwtResponse(accessToken, id, username, email, roles, contactNumber, firstname, notificationFlag);

        assertEquals(accessToken, jwtResponse.getToken());
        assertEquals(id, jwtResponse.getId());
        assertEquals(username, jwtResponse.getUsername());
        assertEquals(email, jwtResponse.getEmail());
        assertEquals(roles, jwtResponse.getRoles());
        assertEquals(contactNumber, jwtResponse.getContactNumber());
        assertEquals(firstname, jwtResponse.getFirstname());
        assertTrue(jwtResponse.isNotificationFlag());
        // Ensure that seller related fields are null
        assertEquals(null, jwtResponse.getSellerId());
        assertEquals(null, jwtResponse.getSellerName());
        assertEquals(null, jwtResponse.getSellerEmail());
        assertEquals(null, jwtResponse.getSellerContactNumber());
    }

    @Test
    public void testJwtResponseConstructorWithSeller() {
        String accessToken = "access_token";
        Long id = 1L;
        String username = "username";
        String email = "test@example.com";
        List<String> roles = Arrays.asList("ROLE_USER");
        String contactNumber = "1234567890";
        String firstname = "John";
        boolean notificationFlag = true;
        Long sellerId = 2L;
        String sellerName = "SellerName";
        String sellerEmail = "seller@example.com";
        String sellerContactNumber = "9876543210";
        String sellerDescription = "SelerDetails";

        JwtResponse jwtResponse = new JwtResponse(accessToken, id, username, email, roles, contactNumber, firstname, notificationFlag, sellerId, sellerName, sellerEmail, sellerContactNumber,sellerDescription);

        assertEquals(accessToken, jwtResponse.getToken());
        assertEquals(id, jwtResponse.getId());
        assertEquals(username, jwtResponse.getUsername());
        assertEquals(email, jwtResponse.getEmail());
        assertEquals(roles, jwtResponse.getRoles());
        assertEquals(contactNumber, jwtResponse.getContactNumber());
        assertEquals(firstname, jwtResponse.getFirstname());
        assertTrue(jwtResponse.isNotificationFlag());
        // Ensure that seller related fields are set correctly
        assertEquals(sellerId, jwtResponse.getSellerId());
        assertEquals(sellerName, jwtResponse.getSellerName());
        assertEquals(sellerEmail, jwtResponse.getSellerEmail());
        assertEquals(sellerContactNumber, jwtResponse.getSellerContactNumber());
        assertEquals(sellerDescription, jwtResponse.getStoreDescription());
    }
}
