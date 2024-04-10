package com.Group11.soulfulplates.security.services;

import com.Group11.soulfulplates.models.User;
import com.Group11.soulfulplates.repository.UserRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * This service class implements the UserDetailsService interface to load user details by username.
 */


@Service
public class UserDetailsServiceImpl implements UserDetailsService {
  private final UserRepository userRepository;

  public UserDetailsServiceImpl(UserRepository userRepository) {
    this.userRepository = userRepository;
  }

  @Override
  @Transactional
  public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    UsernameNotFoundException usernameNotFound = new UsernameNotFoundException("User Not Found with username: " + username);
    User user = userRepository.findByUsername(username).orElseThrow(() -> usernameNotFound);

    if (user == null) {
      throw new UsernameNotFoundException("User not found with username: " + username);
    }

    return UserDetailsImpl.build(user);
  }
}
