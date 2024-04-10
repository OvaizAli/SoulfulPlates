//package com.Group11.soulfulplates.IntegrationTests;
//
//import com.Group11.soulfulplates.services.RatingService;
//import org.junit.jupiter.api.Test;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.boot.test.mock.mockito.MockBean;
//import org.springframework.http.HttpHeaders;
//import org.springframework.test.web.servlet.MockMvc;
//import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
//import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
//
//import static org.mockito.Mockito.when;
//
///**
// * Integration tests for the RatingController class.
// */
//
//@SpringBootTest
//@AutoConfigureMockMvc
//public class RatingControllerIntegrationTest {
//
//    @Autowired
//    private MockMvc mockMvc;
//
//    @MockBean
//    private RatingService ratingService;
//
//    /**
//     * Test case for unauthorized access when retrieving average rating.
//     * @throws Exception if any error occurs during the test
//     */
//    @Test
//    public void getAverageRating_Unauthorized() throws Exception {
//        // Given
//        Long storeId = 1L;
//
//        // Mock the behavior of RatingService
//        when(ratingService.getAverageRating(storeId)).thenThrow(new RuntimeException("Error retrieving average rating"));
//
//        // When/Then
//        mockMvc.perform(MockMvcRequestBuilders.get("/api/ratings/average/{storeId}", storeId)
//                        .header(HttpHeaders.AUTHORIZATION, "Bearer invalidTokenHere"))
//                .andExpect(MockMvcResultMatchers.status().isUnauthorized())
//                .andExpect(MockMvcResultMatchers.jsonPath("$.code").doesNotExist())
//                .andExpect(MockMvcResultMatchers.jsonPath("$.description").doesNotExist())
//                .andExpect(MockMvcResultMatchers.jsonPath("$.data").doesNotExist());
//    }
//}
