package com.Group11.soulfulplates.IntegrationTests;

import com.Group11.soulfulplates.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpHeaders;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import static org.mockito.Mockito.when;

@SpringBootTest
@AutoConfigureMockMvc
public class UserControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserRepository userRepository;

    @Test
    public void getUserById_Unauthorized() throws Exception {
        // Given
        Long userId = 1L;

        // Mock the behavior of UserRepository
        when(userRepository.findById(userId)).thenThrow(new RuntimeException("User not found"));

        // When/Then
        mockMvc.perform(MockMvcRequestBuilders.get("/api/users/{userId}", userId)
                        .header(HttpHeaders.AUTHORIZATION, "Bearer invalidTokenHere"))
                .andExpect(MockMvcResultMatchers.status().isUnauthorized())
                .andExpect(MockMvcResultMatchers.jsonPath("$.code").doesNotExist())
                .andExpect(MockMvcResultMatchers.jsonPath("$.description").doesNotExist())
                .andExpect(MockMvcResultMatchers.jsonPath("$.data").doesNotExist());
    }
}
