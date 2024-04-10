package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Address;
import com.Group11.soulfulplates.repository.AddressRepository;
import com.Group11.soulfulplates.services.AddressService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * This class implements methods for managing addresses, including creating, updating, deleting, and retrieving addresses
 * by ID, as well as fetching all addresses and retrieving latitude and longitude information for all stores.
 */


@Service
public class AddressServiceImpl implements AddressService {
    @Autowired
    private AddressRepository addressRepository;

    @Override
    public Address createAddress(Address address) {
        return addressRepository.save(address);
    }

    @Override
    public Address getAddressById(Long id) {
        return addressRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("Address not found."));
    }

    @Override
    public List<Address> getAllAddresses() {
        return addressRepository.findAll();
    }

    @Override
    public Address updateAddress(Address address) {
        return addressRepository.save(address);
    }

    @Override
    public void deleteAddress(Long id) {
        addressRepository.deleteById(id);
    }

    @Override
    public List<Map<String, Object>> getAllStoresLatLon() {
        return addressRepository.findAllStoresLatLon();
    }
}
