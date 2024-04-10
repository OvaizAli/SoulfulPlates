package com.Group11.soulfulplates.security.services;

import com.Group11.soulfulplates.models.User;
import com.Group11.soulfulplates.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class UserDetailsServiceImplTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserDetailsServiceImpl userDetailsService;

    @BeforeEach
    void setUp(){
        MockitoAnnotations.openMocks(this);
    }


    @Test
    void loadUserByUsername_UserFound() {
        // Mock user data
        User user = new User();
        user.setUsername("test_user");
        user.setPassword("test_password");

        // Mock behavior of userRepository.findByUsername()
        when(userRepository.findByUsername("test_user")).thenReturn(Optional.of(user));

        // Call the method
        UserDetails userDetails = userDetailsService.loadUserByUsername("test_user");

        // Assertions
        assertNotNull(userDetails);
        assertEquals("test_user", userDetails.getUsername());
        assertEquals("test_password", userDetails.getPassword());

        // Verify userRepository.findByUsername() is called
        verify(userRepository, times(1)).findByUsername("test_user");
    }

    @Test
    void loadUserByUsername_UserNotFound() {
        // Mock behavior of userRepository.findByUsername()
        when(userRepository.findByUsername(anyString())).thenReturn(Optional.empty());

        // Call the method and assert for UsernameNotFoundException
        UsernameNotFoundException exception = assertThrows(UsernameNotFoundException.class, () -> {
            userDetailsService.loadUserByUsername("non_existing_user");
        });

        // Verify userRepository.findByUsername() is called
        verify(userRepository, times(1)).findByUsername("non_existing_user");
        // Verify exception message
        assertEquals("User Not Found with username: non_existing_user", exception.getMessage());
    }

}
