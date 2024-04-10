package com.Group11.soulfulplates.repository;

import com.Group11.soulfulplates.models.ERole;
import com.Group11.soulfulplates.models.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Repository interface for Role entity.
 */
@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {

  /**
   * Finds a role by name.
   * @param name The name of the role.
   * @return An optional containing the role if found, empty otherwise.
   */
  Optional<Role> findByName(ERole name);
}
