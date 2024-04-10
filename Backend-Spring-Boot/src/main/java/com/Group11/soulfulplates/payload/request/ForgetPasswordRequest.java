package com.Group11.soulfulplates.payload.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * Request payload for resetting password.
 */
@Data
public class ForgetPasswordRequest {

    @NotBlank
    private String email;
}
