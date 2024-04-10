package com.Group11.soulfulplates.controllers;

import com.Group11.soulfulplates.models.ERole;
import com.Group11.soulfulplates.models.Role;
import com.Group11.soulfulplates.models.Store;
import com.Group11.soulfulplates.models.User;
import com.Group11.soulfulplates.payload.request.ForgetPasswordRequest;
import com.Group11.soulfulplates.payload.request.LoginRequest;
import com.Group11.soulfulplates.payload.request.ResetPasswordRequest;
import com.Group11.soulfulplates.payload.request.SignupRequest;
import com.Group11.soulfulplates.payload.response.JwtResponse;
import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.Group11.soulfulplates.payload.response.OtpResponse;
import com.Group11.soulfulplates.repository.RoleRepository;
import com.Group11.soulfulplates.repository.StoreRepository;
import com.Group11.soulfulplates.repository.UserRepository;
import com.Group11.soulfulplates.security.jwt.JwtUtils;
import com.Group11.soulfulplates.security.services.UserDetailsImpl;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Controller class to handle authentication-related endpoints.
 */

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/auth")
public class AuthController {

  @Autowired
  AuthenticationManager authenticationManager;

  @Autowired
  UserRepository userRepository;

  @Autowired
  StoreRepository storeRepository;

  @Autowired
  RoleRepository roleRepository;

  @Autowired
  PasswordEncoder encoder;

  @Autowired
  JwtUtils jwtUtils;

  /**
   * Endpoint to register a new user.
   *
   * @param signUpRequest The signup request payload.
   * @return ResponseEntity containing a message response.
   */
  @PostMapping("/signup")
  public ResponseEntity<MessageResponse> registerUser(@Valid @RequestBody SignupRequest signUpRequest) {
    if (userRepository.existsByUsername(signUpRequest.getUsername())) {
      return ResponseEntity.badRequest()
              .body(new MessageResponse(-1, "Error: Username is already taken!", null));
    }

    if (userRepository.existsByEmail(signUpRequest.getEmail())) {
      return ResponseEntity.badRequest()
              .body(new MessageResponse(-1, "Error: Email is already in use!", null));
    }

    // Create a new user entity
    User user = new User(signUpRequest.getUsername(), signUpRequest.getEmail(),
            encoder.encode(signUpRequest.getPassword()), signUpRequest.getContactNumber(), signUpRequest.getFirstname());

    // Set user's roles
    Set<Role> roles = new HashSet<>();
    if (signUpRequest.getRole() == null) {
      Role buyerRole = roleRepository.findByName(ERole.ROLE_BUYER)
              .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
      roles.add(buyerRole);
    } else {
      signUpRequest.getRole().forEach(role -> {
        switch (role) {
          case "admin":
            Role adminRole = roleRepository.findByName(ERole.ROLE_ADMIN)
                    .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
            roles.add(adminRole);
            break;
          case "seller":
            Role sellerRole = roleRepository.findByName(ERole.ROLE_SELLER)
                    .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
            roles.add(sellerRole);

            // Create a new store entity and associate it with the user
            Store store = new Store();
            store.setUser(user);
            user.setStore(store); // Set the store in the user entity
            break;
          default:
            Role buyerRole = roleRepository.findByName(ERole.ROLE_BUYER)
                    .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
            roles.add(buyerRole);
        }
      });
    }
    user.setRoles(roles);

    // Save the user entity
    userRepository.save(user);

    return ResponseEntity.ok(new MessageResponse(1, "User registered successfully!", null));
  }

  /**
   * Authenticates a user based on the provided login credentials.
   *
   * @param loginRequest The login request payload containing username and password.
   * @return ResponseEntity containing a message response.
   */
  @PostMapping("/signin")
  public ResponseEntity<MessageResponse> authenticateUser(@Valid @RequestBody LoginRequest loginRequest) {
    if (loginRequest.getUsername() == null || loginRequest.getUsername().isEmpty()) {
      return ResponseEntity.badRequest()
              .body(new MessageResponse(-1, "Error: Username is required!", null));
    }

    try {
      String loginUsername = loginRequest.getUsername();
      String loginPassword = loginRequest.getPassword();
      UsernamePasswordAuthenticationToken userpass = new UsernamePasswordAuthenticationToken(loginUsername, loginPassword);
      Authentication authentication = authenticationManager.authenticate(userpass);

      if (authentication != null && authentication.isAuthenticated()) {
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = jwtUtils.generateJwtToken(authentication);

        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        List<String> roles = userDetails.getAuthorities().stream()
                .map(Object::toString)
                .collect(Collectors.toList());

        // Fetch store information if exists
        Optional<Store> storeOptional = storeRepository.findByUser_Id(userDetails.getId());

        Long id = userDetails.getId();
        String username = userDetails.getUsername();
        String email = userDetails.getEmail();
        String contactNumber = userDetails.getContactNumber();
        String firstname = userDetails.getFirstname();
        boolean isNotificationFlag = userDetails.isNotificationFlag();

        JwtResponse jwtResponse;

        // If store details exist, append them to JwtResponse
        if (storeOptional.isPresent()) {
          Store store = storeOptional.get();
          Long storeId = store.getStoreId();
          String storeName = store.getStoreName();
          String storeEmail = store.getStoreEmail();
          String storeContactNumber = store.getContactNumber();
          String storeDescription = store.getStoreDescription();

          jwtResponse = new JwtResponse(jwt, id, username, email, roles, contactNumber, firstname,
                  isNotificationFlag, storeId, storeName, storeEmail, storeContactNumber, storeDescription);
        } else {
          // Create JwtResponse without store details
          jwtResponse = new JwtResponse(jwt, id, username, email, roles, contactNumber, firstname,
                  isNotificationFlag);
        }

        return ResponseEntity.ok(new MessageResponse(1, "User authenticated successfully!", jwtResponse));
      } else {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(new MessageResponse(-1, "Invalid username or password", null));
      }
    } catch (BadCredentialsException e) {
      return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
              .body(new MessageResponse(-1, "Invalid username or password", null));
    }
  }

  /**
   * Generates a forget password code for the provided email address.
   *
   * @param forgetPasswordRequest The forget password request payload containing the user's email.
   * @return ResponseEntity containing a message response with the generated forget password code.
   */
  @PostMapping("/forget-password")
  public ResponseEntity<MessageResponse> generateForgetPasswordCode(
          @RequestBody ForgetPasswordRequest forgetPasswordRequest) {
    try {
      String responseDescription;
      int responseCode;
      Map<String, String> responseData;
      MessageResponse messageResponse;

      if (userRepository.existsByEmail(forgetPasswordRequest.getEmail())) {
        responseDescription = "Forget password code generated successfully!";
        responseCode = 1;
        responseData = Collections.singletonMap("OTP_Code", OtpResponse.generateOtpCode());
        messageResponse = new MessageResponse(responseCode, responseDescription, responseData);
        return ResponseEntity.ok(messageResponse);
      } else {
        responseDescription = "Error: Email does not exist!";
        responseCode = -1;
        responseData = null;
        messageResponse = new MessageResponse(responseCode, responseDescription, responseData);
        return ResponseEntity.ok(messageResponse);
      }
    } catch (RuntimeException e) {
      MessageResponse badRes = new MessageResponse(-1, "Error occurred while generating forget password code.", null);
      return ResponseEntity.badRequest()
              .body(badRes);
    }
  }


  /**
   * Resets the password for the provided email address.
   *
   * @param resetPasswordRequest The reset password request payload containing the user's email and new password.
   * @return ResponseEntity containing a message response indicating the result of the password reset operation.
   */
  @PostMapping("/reset-password")
// @PreAuthorize("hasRole('ROLE_BUYER') or hasRole('ROLE_SELLER') or hasRole('ROLE_ADMIN')")
  public ResponseEntity<MessageResponse> resetPassword(@Valid @RequestBody ResetPasswordRequest resetPasswordRequest) {
    if (userRepository.existsByEmail(resetPasswordRequest.getEmail())) {
      try {
        Optional<User> optionalUser = userRepository.findByEmail(resetPasswordRequest.getEmail());
        if (optionalUser.isPresent()) {
          User user = optionalUser.get();
          user.setPassword(encoder.encode(resetPasswordRequest.getNewPassword()));
          userRepository.save(user);

          return ResponseEntity.ok(new MessageResponse(1, "Password reset successfully!", null));
        } else {
          return ResponseEntity.badRequest()
                  .body(new MessageResponse(-1, "Error: User with provided email not found.", null));
        }
      } catch (Exception e) {
        return ResponseEntity.badRequest()
                .body(new MessageResponse(-1, "Error occurred while resetting password.", null));
      }

    } else {
      return ResponseEntity
              .badRequest()
              .body(new MessageResponse(-1, "Error: Email does not exist!", null));
    }
  }
}
