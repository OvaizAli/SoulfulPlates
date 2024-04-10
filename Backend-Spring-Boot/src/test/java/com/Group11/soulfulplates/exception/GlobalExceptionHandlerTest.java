package com.Group11.soulfulplates.exception;

import jakarta.servlet.http.HttpServletRequest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class GlobalExceptionHandlerTest {

    private GlobalExceptionHandler exceptionHandler;

    @BeforeEach
    void setUp() {
        exceptionHandler = new GlobalExceptionHandler();
    }

    @Test
    void handleTypeMismatchException() {
        MethodArgumentTypeMismatchException exception = mock(MethodArgumentTypeMismatchException.class);
        when(exception.getMessage()).thenReturn("Invalid input format.");

        ResponseEntity<?> responseEntity = exceptionHandler.handleTypeMismatchException(exception);
        int errorCode = 400;
        assertEquals(errorCode, responseEntity.getStatusCodeValue());
        Map<String, Object> responseBody = (Map<String, Object>) responseEntity.getBody();
        assertEquals(-1, responseBody.get("code"));
        assertEquals("Invalid input format. Expected a numeric value.", responseBody.get("description"));
        assertEquals(null, responseBody.get("data"));
    }

    @Test
    void handleIllegalArgumentException() {
        // Arrange
        GlobalExceptionHandler handler = new GlobalExceptionHandler();
        IllegalArgumentException ex = new IllegalArgumentException("Test message");
        HttpServletRequest request = mock(HttpServletRequest.class);
        when(request.getRequestURI()).thenReturn("/test");
        when(request.getMethod()).thenReturn("GET");

        // Act
        ResponseEntity<Object> responseEntity = (ResponseEntity<Object>) handler.handleIllegalArgumentException(ex);

        // Assert
        assertEquals(HttpStatus.BAD_REQUEST, responseEntity.getStatusCode());
    }


    @Test
    void handleHttpRequestMethodNotSupportedException() {
        HttpRequestMethodNotSupportedException exception = mock(HttpRequestMethodNotSupportedException.class);
        when(exception.getMethod()).thenReturn("GET");

        ResponseEntity<?> responseEntity = exceptionHandler.handleHttpRequestMethodNotSupportedException(exception);
        int errorCode = 405;
        assertEquals(errorCode, responseEntity.getStatusCodeValue());
        Map<String, Object> responseBody = (Map<String, Object>) responseEntity.getBody();
        assertEquals(-1, responseBody.get("code"));
        assertEquals("HTTP method not supported for this request: GET", responseBody.get("description"));
        assertEquals(null, responseBody.get("data"));
    }

    @Test
    void handleDataIntegrityViolationException() {
        DataIntegrityViolationException exception = new DataIntegrityViolationException("Data integrity violation");

        ResponseEntity<?> responseEntity = exceptionHandler.handleDataIntegrityViolationException(exception);
        int errorCode = 400;
        assertEquals(errorCode, responseEntity.getStatusCodeValue());
        Map<String, Object> responseBody = (Map<String, Object>) responseEntity.getBody();
        assertEquals(-1, responseBody.get("code"));
        String expectedDescription = "Data integrity violation - possibly duplicate entries or foreign key constraint failure.";
        assertEquals(expectedDescription, responseBody.get("description"));
        assertEquals(null, responseBody.get("data"));
    }
}
