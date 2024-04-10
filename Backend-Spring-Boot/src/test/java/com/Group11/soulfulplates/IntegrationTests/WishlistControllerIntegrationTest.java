//package com.Group11.soulfulplates.IntegrationTests;
//
//import com.Group11.soulfulplates.services.impl.WishlistServiceImpl;
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
//@SpringBootTest
//@AutoConfigureMockMvc
//public class WishlistControllerIntegrationTest {
//
//    @Autowired
//    private MockMvc mockMvc;
//
//    @MockBean
//    private WishlistServiceImpl wishlistService;
//
//    @Test
//    public void getWishlistById_Unauthorized() throws Exception {
//        // Given
//        Long wishlistId = 1L;
//
//        // Mock the behavior of WishlistService
//        when(wishlistService.getWishlistById(wishlistId)).thenThrow(new RuntimeException("Error retrieving wishlist"));
//
//        // When/Then
//        mockMvc.perform(MockMvcRequestBuilders.get("/api/wishlist/{id}", wishlistId)
//                        .header(HttpHeaders.AUTHORIZATION, "Bearer invalidTokenHere"))
//                .andExpect(MockMvcResultMatchers.status().isUnauthorized())
//                .andExpect(MockMvcResultMatchers.jsonPath("$.code").doesNotExist())
//                .andExpect(MockMvcResultMatchers.jsonPath("$.description").doesNotExist())
//                .andExpect(MockMvcResultMatchers.jsonPath("$.data").doesNotExist());
//    }
//}
