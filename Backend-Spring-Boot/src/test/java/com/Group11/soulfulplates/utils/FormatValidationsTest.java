package com.Group11.soulfulplates.utils;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class FormatValidationsTest {

    @Test
    void verifyCardNumber_InvalidFormat_ShouldReturnFalse() {
        String invalidCardNumber = "1234-5678-9101-";
        assertFalse(FormatValidations.verifyCardNumber(invalidCardNumber));
    }

    @Test
    void verifyCardExpiry_ValidFormat_ShouldReturnTrue() {
        String validCardExpiry = "12/23";
        assertTrue(FormatValidations.verifyCardExpiry(validCardExpiry));
    }

    @Test
    void verifyCardExpiry_InvalidFormat_ShouldReturnFalse() {
        String invalidCardExpiry = "15/23";
        assertFalse(FormatValidations.verifyCardExpiry(invalidCardExpiry));
    }

    @Test
    void verifyCvv_ValidFormat_ShouldReturnTrue() {
        String validCvv = "123";
        assertTrue(FormatValidations.verifyCvv(validCvv));
    }

    @Test
    void verifyCvv_InvalidFormat_ShouldReturnFalse() {
        String invalidCvv = "1234";
        assertFalse(FormatValidations.verifyCvv(invalidCvv));
    }
}
