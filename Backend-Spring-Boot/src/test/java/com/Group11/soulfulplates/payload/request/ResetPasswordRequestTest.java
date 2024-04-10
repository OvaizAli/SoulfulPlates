package com.Group11.soulfulplates.payload.request;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

class ResetPasswordRequestTest {

    @Test
    void testConstructorAndGetters() {
        // Given
        String email = "test@example.com";
        String newPassword = "newPassword";
        String otpCode = "123456";

        // When
        ResetPasswordRequest resetPasswordRequest = new ResetPasswordRequest();
        resetPasswordRequest.setEmail(email);
        resetPasswordRequest.setNewPassword(newPassword);
        resetPasswordRequest.setOTP_Code(otpCode);

        // Then
        assertNotNull(resetPasswordRequest);
        assertEquals(email, resetPasswordRequest.getEmail());
        assertEquals(newPassword, resetPasswordRequest.getNewPassword());
        assertEquals(otpCode, resetPasswordRequest.getOTP_Code());
    }
}
