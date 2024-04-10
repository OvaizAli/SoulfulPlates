package com.Group11.soulfulplates.security.jwt;

import com.Group11.soulfulplates.security.services.UserDetailsServiceImpl;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collection;

import static org.mockito.Mockito.*;

public class AuthTokenFilterTest {

    @Mock
    private JwtUtils jwtUtils;

    @Mock
    private UserDetailsServiceImpl userDetailsService;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private FilterChain filterChain;

    @InjectMocks
    private AuthTokenFilter authTokenFilter;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testDoFilterInternal_ValidJwtToken() throws ServletException, IOException {
        // Arrange
        String validJwtToken = "valid_jwt_token";
        Collection<GrantedAuthority> authorities = Arrays.asList(new SimpleGrantedAuthority("ROLE_USER")); // Initialize authorities
        UserDetails userDetails = new User("username", "password", authorities); // Pass authorities
        UsernamePasswordAuthenticationToken authenticationToken =
                new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
        authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

        when(request.getHeader("Authorization")).thenReturn("Bearer " + validJwtToken);
        when(jwtUtils.validateJwtToken(validJwtToken)).thenReturn(true);
        when(jwtUtils.getUserNameFromJwtToken(validJwtToken)).thenReturn("username");
        when(userDetailsService.loadUserByUsername("username")).thenReturn(userDetails);

        // Act
        authTokenFilter.doFilterInternal(request, response, filterChain);

        // Assert
        verify(userDetailsService, times(1)).loadUserByUsername("username");
        verify(request, times(1)).getHeader("Authorization");
        verify(jwtUtils, times(1)).validateJwtToken(validJwtToken);
        verify(jwtUtils, times(1)).getUserNameFromJwtToken(validJwtToken);
        verify(filterChain, times(1)).doFilter(request, response);
    }


    @Test
    public void testDoFilterInternal_InvalidJwtToken() throws ServletException, IOException {
        // Arrange
        String invalidJwtToken = "invalid_jwt_token";

        when(request.getHeader("Authorization")).thenReturn("Bearer " + invalidJwtToken);
        when(jwtUtils.validateJwtToken(invalidJwtToken)).thenReturn(false);

        // Act
        authTokenFilter.doFilterInternal(request, response, filterChain);

        // Assert
        verify(request, times(1)).getHeader("Authorization");
        verify(jwtUtils, times(1)).validateJwtToken(invalidJwtToken);
        verify(filterChain, times(1)).doFilter(request, response);
    }

    @Test
    public void testDoFilterInternal_NoAuthorizationHeader() throws ServletException, IOException {
        // Arrange
        when(request.getHeader("Authorization")).thenReturn(null);

        // Act
        authTokenFilter.doFilterInternal(request, response, filterChain);

        // Assert
        verify(request, times(1)).getHeader("Authorization");
        verify(jwtUtils, never()).validateJwtToken(anyString());
        verify(filterChain, times(1)).doFilter(request, response);
    }

    @Test
    public void testDoFilterInternal_ValidToken() throws Exception {
        // Mock objects
        HttpServletRequest mockRequest = Mockito.mock(HttpServletRequest.class);
        HttpServletResponse mockResponse = Mockito.mock(HttpServletResponse.class);
        FilterChain mockFilterChain = Mockito.mock(FilterChain.class);

        // Mock data
        String username = "test_user";
        String token = "valid.jwt.token";

        // Mock behavior
        Mockito.when(mockRequest.getHeader("Authorization")).thenReturn("Bearer " + token);
        Mockito.when(jwtUtils.validateJwtToken(token)).thenReturn(true);
        Mockito.when(jwtUtils.getUserNameFromJwtToken(token)).thenReturn(username);
        Mockito.doAnswer(invocation -> {
            UserDetails userDetails = Mockito.mock(UserDetails.class);
            Mockito.when(userDetails.getUsername()).thenReturn(username);
            return userDetails;
        }).when(userDetailsService).loadUserByUsername(username);

        // Call the filter
        authTokenFilter.doFilterInternal(mockRequest, mockResponse, mockFilterChain);

        // Verify interactions
        Mockito.verify(mockRequest).getHeader("Authorization");
        Mockito.verify(jwtUtils).validateJwtToken(token);
        Mockito.verify(jwtUtils).getUserNameFromJwtToken(token);
        Mockito.verify(userDetailsService).loadUserByUsername(username);
        Mockito.verify(mockFilterChain).doFilter(mockRequest, mockResponse);
    }

    @Test
    public void testDoFilterInternal_MissingAuthorizationHeader() throws Exception {
        // Mock objects
        HttpServletRequest mockRequest = Mockito.mock(HttpServletRequest.class);
        HttpServletResponse mockResponse = Mockito.mock(HttpServletResponse.class);
        FilterChain mockFilterChain = Mockito.mock(FilterChain.class);

        // Mock behavior
        Mockito.when(mockRequest.getHeader("Authorization")).thenReturn(null);

        // Call the filter
        authTokenFilter.doFilterInternal(mockRequest, mockResponse, mockFilterChain);

        // Verify interactions
        Mockito.verify(mockRequest).getHeader("Authorization");
        Mockito.verifyNoInteractions(jwtUtils); // No JWT processing happens
        Mockito.verify(mockFilterChain).doFilter(mockRequest, mockResponse);
    }

    @Test
    public void testDoFilterInternal_InvalidTokenFormat() throws Exception {
        // Mock objects
        HttpServletRequest mockRequest = Mockito.mock(HttpServletRequest.class);
        HttpServletResponse mockResponse = Mockito.mock(HttpServletResponse.class);
        FilterChain mockFilterChain = Mockito.mock(FilterChain.class);

        // Mock data
        String token = "invalid_token";

        // Mock behavior
        Mockito.when(mockRequest.getHeader("Authorization")).thenReturn(token);

        // Call the filter
        authTokenFilter.doFilterInternal(mockRequest, mockResponse, mockFilterChain);

        // Verify interactions
        Mockito.verify(mockRequest).getHeader("Authorization");
        Mockito.verifyNoInteractions(jwtUtils); // No JWT processing happens
        Mockito.verify(mockFilterChain).doFilter(mockRequest, mockResponse);
    }
}
