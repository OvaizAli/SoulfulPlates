package com.Group11.soulfulplates.payload.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * Request payload for user login.
 */
@Data
public class LoginRequest {

	@NotBlank
	private String username;

	@NotBlank
	private String password;
}
