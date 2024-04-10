package com.Group11.soulfulplates.payload.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * Request payload for resetting password.
 */
@Data
public class ResetPasswordRequest {

    @NotBlank
    private String email;

    @NotBlank
    private String newPassword;

    private String OTP_Code;
}
