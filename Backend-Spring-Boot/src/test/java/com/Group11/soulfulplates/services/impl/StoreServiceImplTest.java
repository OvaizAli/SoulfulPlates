package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Store;
import com.Group11.soulfulplates.repository.StoreRepository;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class StoreServiceImplTest {

    @Mock
    private StoreRepository storeRepository;

    @InjectMocks
    private StoreServiceImpl storeService;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testUpdateStoreByUserId_Success() throws Exception {
        Long userId = 1L;
        Store existingStore = new Store();
        existingStore.setStoreId(1L);
        existingStore.setStoreName("Old Store Name");
        existingStore.setStoreEmail("old@example.com");
        existingStore.setContactNumber("1234567890");
        existingStore.setStoreDescription("Old Store Description");

        Store updatedStoreDetails = new Store();
        updatedStoreDetails.setStoreName("New Store Name");
        updatedStoreDetails.setStoreEmail("new@example.com");
        updatedStoreDetails.setContactNumber("9876543210");
        updatedStoreDetails.setStoreDescription("New Store Description");

        when(storeRepository.findByUser_Id(userId)).thenReturn(Optional.of(existingStore));
        when(storeRepository.save(Mockito.any(Store.class))).thenReturn(updatedStoreDetails);

        Store updatedStore = storeService.updateStoreByUserId(userId, updatedStoreDetails);

        assertEquals(updatedStoreDetails.getStoreName(), updatedStore.getStoreName());
        assertEquals(updatedStoreDetails.getStoreEmail(), updatedStore.getStoreEmail());
        assertEquals(updatedStoreDetails.getContactNumber(), updatedStore.getContactNumber());
        assertEquals(updatedStoreDetails.getStoreDescription(), updatedStore.getStoreDescription());
    }

    @Test
    public void testCreateStore_Success() {
        Store store = new Store();
        store.setStoreId(1L);
        store.setStoreName("Test Store");
        store.setStoreEmail("test@example.com");
        store.setContactNumber("1234567890");
        store.setStoreDescription("Test Store Description");

        when(storeRepository.save(Mockito.any(Store.class))).thenReturn(store);

        Store createdStore = storeService.createStore(store);

        assertEquals(store, createdStore);
    }

    @Test
    void getStoreById_ExistingId_ReturnsStore() {
        // Mocking behavior of storeRepository.findById
        Long storeId = 1L;
        Store store = new Store();
        store.setStoreId(storeId);
        when(storeRepository.findById(storeId)).thenReturn(Optional.of(store));

        // Call the method
        Optional<Store> result = storeService.getStoreById(storeId);

        // Assertions
        assertTrue(result.isPresent());
        assertEquals(storeId, result.get().getStoreId());
    }

    @Test
    void getStoreById_NonExistingId_ReturnsEmptyOptional() {
        // Mocking behavior of storeRepository.findById
        Long storeId = 1L;
        when(storeRepository.findById(storeId)).thenReturn(Optional.empty());

        // Call the method
        Optional<Store> result = storeService.getStoreById(storeId);

        // Assertions
        assertFalse(result.isPresent());
    }

    @Test
    void getAllStores_ReturnsListOfStores() {
        // Mocking behavior of storeRepository.findAll
        List<Store> stores = new ArrayList<>();
        stores.add(new Store());
        stores.add(new Store());
        when(storeRepository.findAll()).thenReturn(stores);

        // Call the method
        List<Store> result = storeService.getAllStores();

        // Assertions
        assertEquals(stores.size(), result.size());
    }

    @Test
    void deleteStore_ExistingId_DeletesStore() {
        // Call the method
        Long storeId = 1L;
        storeService.deleteStore(storeId);

        // Verify that storeRepository.deleteById is called with the correct argument
        verify(storeRepository, times(1)).deleteById(storeId);
    }

    @Test
    void existsById_ExistingId_ReturnsTrue() {
        // Mocking behavior of storeRepository.existsById
        Long storeId = 1L;
        when(storeRepository.existsById(storeId)).thenReturn(true);

        // Call the method
        boolean result = storeService.existsById(storeId);

        // Assertions
        assertTrue(result);
    }

    @Test
    void existsById_NonExistingId_ReturnsFalse() {
        // Mocking behavior of storeRepository.existsById
        Long storeId = 1L;
        when(storeRepository.existsById(storeId)).thenReturn(false);

        // Call the method
        boolean result = storeService.existsById(storeId);

        // Assertions
        assertFalse(result);
    }

}
