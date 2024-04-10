package com.Group11.soulfulplates.payload.request;

import lombok.Data;

/**
 * Request payload for updating user information.
 */
@Data
public class UserUpdateRequest {
    private String username;
    private String email;
    private String contactNumber;
}
