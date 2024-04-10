package com.Group11.soulfulplates.controllers;

import com.Group11.soulfulplates.models.Address;
import com.Group11.soulfulplates.models.User;
import com.Group11.soulfulplates.payload.request.UserUpdateRequest;
import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.Group11.soulfulplates.repository.AddressRepository;
import com.Group11.soulfulplates.repository.UserRepository;
import com.Group11.soulfulplates.services.AddressService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class UserControllerTest {

    @InjectMocks
    private UserController userController;

    @Mock
    private UserRepository userRepository;

    @Mock
    private AddressRepository addressRepository;

    @Mock
    private AddressService addressService;

    @Mock
    private UserDetailsService userDetailsService;

    static int expected200= 200;


    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testToggleNotificationFlag_UserExists_NotificationFlagToggled() {
        // Given
        Long userId = (Long) 1L;
        User user = new User();
        user.setId(userId);
        user.setNotificationFlag(false);

        when(userRepository.findById(userId)).thenReturn(Optional.of(user));
        when(userRepository.save(user)).thenReturn(user);

        // When
        ResponseEntity<MessageResponse> responseEntity = userController.toggleNotificationFlag(userId);

        // Then
        assertNotNull(responseEntity);
        assertEquals(expected200, responseEntity.getStatusCodeValue());
        MessageResponse response = responseEntity.getBody();
        assertNotNull(response);
        assertEquals(1, response.getCode());
        assertEquals("Notification flag toggled successfully!", response.getDescription());
        assertTrue(user.isNotificationFlag());
        verify(userRepository, times(1)).findById(userId);
        verify(userRepository, times(1)).save(user);
    }
    @Test
    void testCreateAddressForUser_UserExists_AddressCreatedSuccessfully() {
        // Given
        Long userId = 1L;
        Address address = new Address();
        address.setAddressId(1L);

        User user = new User();
        user.setId(userId);

        when(userRepository.findById(userId)).thenReturn(Optional.of(user));
        when(addressRepository.save(address)).thenReturn(address);

        // When
        ResponseEntity<MessageResponse> responseEntity = userController.createAddressForUser(userId, address);

        // Then
        assertEquals(expected200, responseEntity.getStatusCodeValue());
        MessageResponse response = responseEntity.getBody();
        assertEquals(1, response.getCode());
        assertEquals("Address saved successfully!", response.getDescription());
        verify(userRepository, times(1)).findById(userId);
        verify(addressRepository, times(1)).save(address);
        assertEquals(user, address.getUser());
    }

    @Test
    void testGetAllAddressesForUser_UserExists_AddressesFetchedSuccessfully() {
        // Given
        Long userId = 1L;
        User user = new User();
        user.setId(userId);

        List<Address> addresses = new ArrayList<>();
        Address address1 = new Address();
        address1.setAddressId(1L);
        address1.setStreet("123 Main St");
        address1.setCity("City");
        address1.setState("State");
        address1.setPostalCode("12345");
        address1.setCountry("Country");
        address1.setUser(user);
        addresses.add(address1);

        when(userRepository.findById(userId)).thenReturn(Optional.of(user));
        when(addressRepository.findByUser(user)).thenReturn(addresses);

        // When
        ResponseEntity<MessageResponse> responseEntity = userController.getAllAddressesForUser(userId);

        // Then
        assertNotNull(responseEntity);
        assertEquals(expected200, responseEntity.getStatusCodeValue());
        MessageResponse response = responseEntity.getBody();
        assertNotNull(response);
        assertEquals(1, response.getCode());
        assertEquals("Addresses fetched successfully!", response.getDescription());

        ObjectMapper objectMapper = new ObjectMapper();
        ArrayNode responseData = (ArrayNode) response.getData();
        assertEquals(1, responseData.size());

        ObjectNode addressNode = (ObjectNode) responseData.get(0);
        assertNull(addressNode.get("user"));
        assertEquals("123 Main St", addressNode.get("street").asText());
        assertEquals("City", addressNode.get("city").asText());
        assertEquals("State", addressNode.get("state").asText());
        assertEquals("12345", addressNode.get("postalCode").asText());
        assertEquals("Country", addressNode.get("country").asText());

        verify(userRepository, times(1)).findById(userId);
        verify(addressRepository, times(1)).findByUser(user);
    }

    @Test
    void testDeleteAddressForUser_UserAndAddressExist_AddressDeletedSuccessfully() {
        // Given
        Long userId = 1L;
        Long addressId = 1L;
        Address address = new Address();
        address.setAddressId(addressId);

        User user = new User();
        user.setId(userId);

        when(userRepository.findById(userId)).thenReturn(Optional.of(user));
        when(addressRepository.findById(addressId)).thenReturn(Optional.of(address));

        // When
        ResponseEntity<MessageResponse> responseEntity = userController.deleteAddressForUser(userId, addressId);

        // Then
        assertNotNull(responseEntity);
        assertEquals(expected200, responseEntity.getStatusCodeValue());
        MessageResponse response = responseEntity.getBody();
        assertNotNull(response);
        assertEquals(1, response.getCode());
        assertEquals("Address deleted successfully!", response.getDescription());

        verify(userRepository, times(1)).findById(userId);
        verify(addressRepository, times(1)).findById(addressId);
        verify(addressRepository, times(1)).delete(address);
    }


    @Test
    void testUpdateAddressForUser_UserAndAddressExist_AddressUpdatedSuccessfully() {
        // Given
        Long userId = 1L;
        Long addressId = 1L;
        Address existingAddress = new Address();
        existingAddress.setAddressId(addressId);
        existingAddress.setStreet("Old Street");
        existingAddress.setCity("Old City");

        Address updatedAddressDetails = new Address();
        updatedAddressDetails.setStreet("New Street");
        updatedAddressDetails.setCity("New City");

        User user = new User();
        user.setId(userId);

        when(userRepository.findById(userId)).thenReturn(Optional.of(user));
        when(addressRepository.findById(addressId)).thenReturn(Optional.of(existingAddress));
        when(addressRepository.save(existingAddress)).thenReturn(existingAddress);

        // When
        ResponseEntity<MessageResponse> responseEntity = userController.updateAddressForUser(userId, addressId, updatedAddressDetails);

        // Then
        assertNotNull(responseEntity);
        assertEquals(expected200, responseEntity.getStatusCodeValue());
        MessageResponse response = responseEntity.getBody();
        assertNotNull(response);
        assertEquals(1, response.getCode());
        assertEquals("Address updated successfully!", response.getDescription());

        assertEquals("New Street", existingAddress.getStreet());
        assertEquals("New City", existingAddress.getCity());

        verify(userRepository, times(1)).findById(userId);
        verify(addressRepository, times(1)).findById(addressId);
        verify(addressRepository, times(1)).save(existingAddress);
    }

    @Test
    void testGetUserAndNearestStore_AddressExists_NearestStoreFound() {
        // Given
        Long addressId = 1L;
        Double maxDistance = 10.0;
        Double latitude = 40.7128;
        Double longitude = -74.0060;
        Address userAddress = new Address();
        userAddress.setAddressId(addressId);
        userAddress.setLatitude(latitude);
        userAddress.setLongitude(longitude);

        Double lat1 = 40.7129;
        Double lat2 = 40.7127;
        Double lon1 = -74.0061;
        Double lon2 = -74.0059;
        List<Map<String, Object>> storesLatLon = new ArrayList<>();
        Map<String, Object> store1 = Map.of("lat", lat1, "lon", lon1);
        Map<String, Object> store2 = Map.of("lat", lat2, "lon",lon2);
        storesLatLon.add(store1);
        storesLatLon.add(store2);

        when(addressRepository.findById(addressId)).thenReturn(Optional.of(userAddress));
        when(addressService.getAllStoresLatLon()).thenReturn(storesLatLon);

        // When
        ResponseEntity<MessageResponse> responseEntity = userController.getUserAndNearestStore(addressId, maxDistance);

        // Then
        assertNotNull(responseEntity);
        assertEquals(expected200, responseEntity.getStatusCodeValue());
        MessageResponse response = responseEntity.getBody();
        assertNotNull(response);
        assertEquals(1, response.getCode());
        assertEquals("Nearest store within 10.0 km found", response.getDescription());
        assertNotNull(response.getData());

        verify(addressRepository, times(1)).findById(addressId);
        verify(addressService, times(1)).getAllStoresLatLon();
    }

    @Test
    void testUpdateAddressForUser_UserAndAddressDoNotExist_ExceptionThrown() {
        // Given
        Long userId = 1L;
        Long addressId = 1L;
        Address updatedAddressDetails = new Address();

        when(userRepository.findById(userId)).thenReturn(Optional.empty());

        // When/Then
        assertThrows(RuntimeException.class, () -> userController.updateAddressForUser(userId, addressId, updatedAddressDetails));
        verify(userRepository, times(1)).findById(userId);
        verify(addressRepository, never()).findById(addressId);
        verify(addressRepository, never()).save(any());
    }

    @Test
    void testUpdateUser_UserExists_UserInformationUpdatedSuccessfully() {
        // Given
        Long userId = 1L;
        UserUpdateRequest request = new UserUpdateRequest();
        request.setUsername("newUsername");
        request.setEmail("newemail@example.com");
        request.setContactNumber("1234567890");

        User existingUser = new User();
        existingUser.setId(userId);
        existingUser.setUsername("oldUsername");
        existingUser.setEmail("oldemail@example.com");
        existingUser.setContactNumber("9876543210");

        when(userRepository.findById(userId)).thenReturn(Optional.of(existingUser));
        when(userRepository.save(existingUser)).thenReturn(existingUser);

        // When
        ResponseEntity<MessageResponse> responseEntity = userController.updateUser(userId, request);

        // Then
        assertNotNull(responseEntity);
        assertEquals(expected200, responseEntity.getStatusCodeValue());
        MessageResponse response = responseEntity.getBody();
        assertNotNull(response);
        assertEquals(1, response.getCode());
        assertEquals("User information updated successfully!", response.getDescription());

        // Check if user information is updated correctly
        assertEquals("newUsername", existingUser.getUsername());
        assertEquals("newemail@example.com", existingUser.getEmail());
        assertEquals("1234567890", existingUser.getContactNumber());

        verify(userRepository, times(1)).findById(userId);
        verify(userRepository, times(1)).save(existingUser);
    }

}
