package com.Group11.soulfulplates.utils;

/**
 * Utility class for validating various formats.
 */
public class FormatValidations {

    /**
     * Verifies the format of a card number (e.g., 1234-5678-9101).
     *
     * @param cardNumber The card number to verify.
     * @return True if the card number format is valid, false otherwise.
     */
    public static boolean verifyCardNumber(String cardNumber) {
        return cardNumber.matches("\\d{4}-\\d{4}-\\d{4}-\\d{4}");
    }

    /**
     * Verifies the format of a card expiry date (e.g., MM/YY).
     *
     * @param cardExpiry The card expiry date to verify.
     * @return True if the card expiry format is valid, false otherwise.
     */
    public static boolean verifyCardExpiry(String cardExpiry) {
        return cardExpiry.matches("(0[1-9]|1[0-2])\\/\\d{2}");
    }

    /**
     * Verifies the format of a CVV (Card Verification Value) code (e.g., 123).
     *
     * @param cvv The CVV code to verify.
     * @return True if the CVV format is valid, false otherwise.
     */
    public static boolean verifyCvv(String cvv) {
        return cvv.matches("\\d{3}");
    }
}
