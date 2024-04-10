package com.Group11.soulfulplates.security.jwt;

import com.Group11.soulfulplates.payload.response.MessageResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.mock.web.DelegatingServletOutputStream;
import org.springframework.security.core.AuthenticationException;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class AuthEntryPointJwtTest {

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private AuthenticationException authException;

    @InjectMocks
    private AuthEntryPointJwt authEntryPointJwt;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testCommence() throws IOException, ServletException {
        // Mock data
        String servletPath = "/test";
        Map<String, Object> data = new HashMap<>();
        data.put("path", servletPath);
        data.put("error", "Unauthorized");
        data.put("status", HttpServletResponse.SC_UNAUTHORIZED);
        String message = "Full authentication is required to access this resource";
        MessageResponse messageResponse = new MessageResponse(-3, message, data);

        // Set up HttpServletRequest
        when(request.getServletPath()).thenReturn(servletPath);

        // Set up HttpServletResponse
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        when(response.getOutputStream()).thenReturn(new DelegatingServletOutputStream(outputStream));

        // Call the method to be tested
        authEntryPointJwt.commence(request, response, authException);

        // Verify response status and content type
        verify(response).setContentType(MediaType.APPLICATION_JSON_VALUE);
        verify(response).setStatus(HttpStatus.UNAUTHORIZED.value());

        // Verify that the ObjectMapper writes the correct message response to the output stream
        String jsonResponse = outputStream.toString();
        assertEquals("{\"code\":-3,\"description\":\"Full authentication is required to access this resource\",\"data\":{\"path\":\"/test\",\"error\":\"Unauthorized\",\"status\":401}}", jsonResponse);
    }
}
