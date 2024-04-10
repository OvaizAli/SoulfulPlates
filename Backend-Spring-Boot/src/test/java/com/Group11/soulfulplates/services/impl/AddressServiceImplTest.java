package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Address;
import com.Group11.soulfulplates.repository.AddressRepository;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class AddressServiceImplTest {

    @Mock
    private AddressRepository addressRepository;

    @InjectMocks
    private AddressServiceImpl addressService;

    @Test
    public void testCreateAddress() {
        Address address = new Address();
        when(addressRepository.save(address)).thenReturn(address);

        Address createdAddress = addressService.createAddress(address);

        assertEquals(address, createdAddress);
        verify(addressRepository, times(1)).save(address);
    }

    @Test
    public void testGetAddressById_ExistingId() {
        Long id = 1L;
        Address address = new Address();
        when(addressRepository.findById(id)).thenReturn(Optional.of(address));

        Address fetchedAddress = addressService.getAddressById(id);

        assertEquals(address, fetchedAddress);
        verify(addressRepository, times(1)).findById(id);
    }

    @Test
    public void testGetAddressById_NonExistingId() {
        Long id = 1L;
        when(addressRepository.findById(id)).thenReturn(Optional.empty());

        try {
            addressService.getAddressById(id);
        } catch (EntityNotFoundException e) {
            assertEquals("Address not found.", e.getMessage());
        }

        verify(addressRepository, times(1)).findById(id);
    }

    @Test
    public void testGetAllAddresses() {
        List<Address> addresses = new ArrayList<>();
        addresses.add(new Address());
        addresses.add(new Address());
        when(addressRepository.findAll()).thenReturn(addresses);

        List<Address> fetchedAddresses = addressService.getAllAddresses();

        assertEquals(addresses.size(), fetchedAddresses.size());
        verify(addressRepository, times(1)).findAll();
    }

    @Test
    public void testUpdateAddress() {
        Address address = new Address();
        when(addressRepository.save(address)).thenReturn(address);

        Address updatedAddress = addressService.updateAddress(address);

        assertEquals(address, updatedAddress);
        verify(addressRepository, times(1)).save(address);
    }

    @Test
    public void testDeleteAddress() {
        Long id = 1L;

        addressService.deleteAddress(id);

        verify(addressRepository, times(1)).deleteById(id);
    }

    @Test
    public void testGetAllStoresLatLon() {
        List<Map<String, Object>> storesLatLon = new ArrayList<>();
        // Mocking the behavior of addressRepository
        when(addressRepository.findAllStoresLatLon()).thenReturn(storesLatLon);

        List<Map<String, Object>> fetchedStoresLatLon = addressService.getAllStoresLatLon();

        assertEquals(storesLatLon, fetchedStoresLatLon);
        verify(addressRepository, times(1)).findAllStoresLatLon();
    }
}
