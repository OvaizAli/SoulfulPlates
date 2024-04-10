package com.Group11.soulfulplates.security.jwt;

import com.Group11.soulfulplates.payload.response.MessageResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Custom implementation of AuthenticationEntryPoint for handling authentication failures.
 */

@Component
public class AuthEntryPointJwt implements AuthenticationEntryPoint {

  private static final Logger logger = LoggerFactory.getLogger(AuthEntryPointJwt.class);

  @Override
  public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException)
          throws IOException, ServletException {
    response.setContentType(MediaType.APPLICATION_JSON_VALUE);
    response.setStatus(HttpStatus.UNAUTHORIZED.value());

    final Map<String, Object> data = new HashMap<>();
    data.put("path", request.getServletPath());
    data.put("error", "Unauthorized");
    data.put("status", HttpServletResponse.SC_UNAUTHORIZED);
    String res = "Full authentication is required to access this resource";
    final MessageResponse messageResponse = new MessageResponse(-3, res, data);

    final ObjectMapper mapper = new ObjectMapper();
    mapper.writeValue(response.getOutputStream(), messageResponse);
  }
}
