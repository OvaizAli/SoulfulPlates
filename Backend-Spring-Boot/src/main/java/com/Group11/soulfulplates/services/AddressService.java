package com.Group11.soulfulplates.services;

import com.Group11.soulfulplates.models.Address;

import java.util.List;
import java.util.Map;

/**
 This service interface defines methods related to address management.
 It provides functionality to create, retrieve, update, and delete addresses.
 Additionally, it includes a method to retrieve latitude and longitude coordinates for all stores.
 */

public interface AddressService {
    public Address createAddress(Address address);

    public Address getAddressById(Long id);

    public List<Address> getAllAddresses();

    public Address updateAddress(Address address);

    public void deleteAddress(Long id);

    List<Map<String, Object>> getAllStoresLatLon();
}
