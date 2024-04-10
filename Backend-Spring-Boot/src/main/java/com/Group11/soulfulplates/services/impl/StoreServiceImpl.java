package com.Group11.soulfulplates.services.impl;

import com.Group11.soulfulplates.models.Store;
import com.Group11.soulfulplates.repository.StoreRepository;
import com.Group11.soulfulplates.services.StoreService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 This class implements the StoreService interface.
 It provides methods to manage stores, including creating, updating, deleting,
 and retrieving store information.
 */

@Service
public class StoreServiceImpl implements StoreService {

    private final StoreRepository storeRepository;

    @Autowired
    public StoreServiceImpl(StoreRepository storeRepository) {
        this.storeRepository = storeRepository;
    }


    @Override
    @Transactional
    public Store updateStoreByUserId(Long userId, Store storeDetails) throws Exception {
        Exception storeNotFound = new Exception("Store not found for this user: " + userId);
        Store store = storeRepository.findByUser_Id(userId).orElseThrow(() -> storeNotFound);

        store.setStoreName(storeDetails.getStoreName());
        store.setStoreEmail(storeDetails.getStoreEmail());
        store.setContactNumber(storeDetails.getContactNumber());
        store.setStoreDescription(storeDetails.getStoreDescription());

        return storeRepository.save(store);
    }


    @Override
    public Store createStore(Store seller) {
        return storeRepository.save(seller);
    }

    @Override
    public Optional<Store> getStoreById(Long id) {
        return storeRepository.findById(id);
    }

    @Override
    public List<Store> getAllStores() {
        return storeRepository.findAll();
    }


    @Override
    public void deleteStore(Long id) {
        storeRepository.deleteById(id);
    }

    @Override
    public boolean existsById(Long id) {
        return storeRepository.existsById(id);
    }

}


