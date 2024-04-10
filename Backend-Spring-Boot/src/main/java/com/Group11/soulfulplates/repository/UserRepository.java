package com.Group11.soulfulplates.repository;

import com.Group11.soulfulplates.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Repository interface for User entity.
 */
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
  Optional<User> findByUsername(String username);

  Optional<User> findByEmail(String email);

  Optional<User> findById(Long id);

  Boolean existsByUsername(String username);

  Boolean existsByEmail(String email);

  boolean existsById(Long id);
}
