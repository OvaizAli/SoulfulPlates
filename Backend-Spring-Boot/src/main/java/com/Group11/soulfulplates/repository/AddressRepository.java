package com.Group11.soulfulplates.repository;

import com.Group11.soulfulplates.models.Address;
import com.Group11.soulfulplates.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Repository interface for Address entity.
 */
@Repository
public interface AddressRepository extends JpaRepository<Address, Long> {

    /**
     * Retrieves a list of addresses associated with a user.
     * @param user The user whose addresses are to be retrieved.
     * @return A list of addresses associated with the user.
     */
    List<Address> findByUser(User user);

    /**
     * Retrieves latitude and longitude information for all stores.
     * @return A list of maps containing store information with latitude and longitude.
     */
    @Query(nativeQuery = true, value = "SELECT s.*, a.latitude AS lat, a.longitude AS lon FROM stores s JOIN addresses a ON a.user_id = s.user_id")
    List<Map<String, Object>> findAllStoresLatLon();
}
