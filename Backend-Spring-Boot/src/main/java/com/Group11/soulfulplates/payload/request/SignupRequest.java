package com.Group11.soulfulplates.payload.request;

import jakarta.validation.constraints.*;
import lombok.Data;

import java.util.Set;

/**
 * Request payload for user signup.
 */
@Data
public class SignupRequest {

  @NotBlank
  @Size(min = 3, max = 20)
  private String username;

  @NotBlank
  @Size(min = 3, max = 20)
  private String firstname;

  @NotBlank
  @Size(max = 50)
  @Email
  private String email;

  private Set<String> role;

  @NotBlank
  @Size(min = 6, max = 40)
  private String password;

  @NotBlank
  @Size(max = 15)
  private String contactNumber;
}
