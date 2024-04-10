package com.Group11.soulfulplates.payload.response;

import lombok.Data;
import java.util.Random;

/**
 * Response payload for OTP (One Time Password) generation.
 */
@Data
public class OtpResponse {
    private String otpCode;

    /**
     * Static method to generate a random OTP code.
     * @return The generated OTP code.
     */
    public static String generateOtpCode() {
        Random random = new Random();
        int otpCode = 1000 + random.nextInt(9000);
        return String.valueOf(otpCode);
    }
}
