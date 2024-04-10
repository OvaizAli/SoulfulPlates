package com.Group11.soulfulplates.models;

import jakarta.persistence.*;
import lombok.Data;

/**
 * Represents a user role in the system.
 */
@Data
@Entity
@Table(name = "roles")
public class Role {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Integer id;

  @Enumerated(EnumType.STRING)
  @Column(length = 20)
  private ERole name;

  /**
   * Default constructor.
   */
  public Role() {
  }

  /**
   * Constructor with a role name parameter.
   * @param name The name of the role.
   */
  public Role(ERole name) {
    this.name = name;
  }
}
