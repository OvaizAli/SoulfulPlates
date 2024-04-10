package com.Group11.soulfulplates.controllers;

import com.Group11.soulfulplates.models.Store;
import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.Group11.soulfulplates.repository.StoreRepository;
import com.Group11.soulfulplates.services.StoreService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockMultipartFile;

import java.util.Collections;
import java.util.Map;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class StoreControllerTest {

    @Mock
    private StoreRepository storeRepository;

    @Mock
    private StoreService storeService;

    @InjectMocks
    private StoreController storeController;

    @Test
    void testCreateStore() {
        Store store = new Store();
        store.setStoreId(1L);

        when(storeService.createStore(any())).thenReturn(store);

        ResponseEntity<?> response = storeController.createStore(store);

        assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    @Test
    void testGetStoreById() {
        Store store = new Store();
        store.setStoreId(1L);

        when(storeService.getStoreById(1L)).thenReturn(java.util.Optional.of(store));

        ResponseEntity<?> response = storeController.getStoreById(1L);

        assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    @Test
    void testGetAllStores() {
        when(storeService.getAllStores()).thenReturn(Collections.emptyList());

        ResponseEntity<?> response = storeController.getAllStores();

        assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    @Test
    void testDeleteStore() {
        when(storeService.existsById(1L)).thenReturn(true);

        ResponseEntity<?> response = storeController.deleteStore(1L);

        assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    @Test
    void testUpdateStore() throws Exception {
        Store store = new Store();
        store.setStoreId(1L);

        when(storeService.updateStoreByUserId(1L, store)).thenReturn(store);

        ResponseEntity<?> response = storeController.updateStore(1L, store);

        assertEquals(HttpStatus.OK, response.getStatusCode());
    }


    @Test
    public void testGetStoreById_NotFound() {
        // Mocking the service method
        when(storeService.getStoreById(anyLong())).thenReturn(Optional.empty());

        // Calling the controller method
        ResponseEntity<?> responseEntity = storeController.getStoreById(1L);

        // Assertions
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals("No Store Found", ((MessageResponse) responseEntity.getBody()).getDescription());
    }
    @Test
    void testUpdateStore_Success() throws Exception {
        // Setup
        Store store = new Store();
        store.setStoreId(1L);

        // Mock the service method to return the updated store
        when(storeService.updateStoreByUserId(1L, store)).thenReturn(store);

        // Call the controller method
        ResponseEntity<?> response = storeController.updateStore(1L, store);

        // Assertion
        assertEquals(HttpStatus.OK, response.getStatusCode());
    }

    @Test
    void testUpdateStore_NotFound() throws Exception {
        // Setup
        Store store = new Store();
        store.setStoreId(1L);

        // Mock the service method to return empty optional, indicating store not found
        when(storeService.updateStoreByUserId(1L, store)).thenThrow(new RuntimeException("Store not found"));

        // Call the controller method
        ResponseEntity<?> response = storeController.updateStore(1L, store);

        // Assertion
        assertEquals(HttpStatus.NOT_FOUND, response.getStatusCode());
    }

    @Test
    void testDeleteStore_NotFound() {
        // Setup
        when(storeService.existsById(1L)).thenReturn(false);

        // Call the controller method
        ResponseEntity<?> response = storeController.deleteStore(1L);

        // Assertion
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals("Store Not Found!", ((MessageResponse) response.getBody()).getDescription());
    }

    @Test
    public void testUpdateStore_ExceptionCaught() throws Exception {
        // Mock storeService to throw an exception
        when(storeService.updateStoreByUserId(anyLong(), any(Store.class))).thenThrow(new RuntimeException("Store not found"));

        // Invoke controller method
        ResponseEntity<?> responseEntity = storeController.updateStore(1L, new Store());

        // Verify behavior
        verify(storeService, times(1)).updateStoreByUserId(1L, new Store());

        // Assertions
        assertEquals(HttpStatus.NOT_FOUND, responseEntity.getStatusCode());

        @SuppressWarnings("unchecked")
        Map<String, Object> responseBody = (Map<String, Object>) responseEntity.getBody();
        assertEquals(-1, responseBody.get("code"));
        assertEquals("Seller's Store not found", responseBody.get("description"));
    }

    @Test
    public void testUpdateUserImage_EmptyFile() {
        // Mock storeRepository
        Store store = new Store(); // Create a mock store object
        when(storeRepository.findById(anyLong())).thenReturn(Optional.of(store));

        // Mock a valid MultipartFile object with empty content
        MockMultipartFile file = new MockMultipartFile("file", "filename.txt", "text/plain", new byte[0]);

        // Invoke controller method
        ResponseEntity<MessageResponse> responseEntity = storeController.updateUserImage(1L, file);

        // Verify behavior
        verify(storeRepository, times(1)).findById(1L);
        verifyNoMoreInteractions(storeRepository);

        // Assertions
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());

        MessageResponse messageResponse = responseEntity.getBody();
        assertEquals(-1, messageResponse.getCode());
        assertEquals("Failed to store empty file.", messageResponse.getDescription());
        assertNull(messageResponse.getData());
    }
    @Test
    void testUpdateUserImage_FileUploadFailure() {
        Store store = new Store();
        when(storeRepository.findById(anyLong())).thenReturn(Optional.of(store));

        // Pass an invalid MockMultipartFile (e.g., with invalid content type)
        MockMultipartFile file = new MockMultipartFile("file", "filename.png", "invalid/type", "some content".getBytes());
        ResponseEntity<MessageResponse> responseEntity = storeController.updateUserImage(1L, file);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals("Failed to store file 1.jpg. Please try again!", ((MessageResponse) responseEntity.getBody()).getDescription());
    }

}
