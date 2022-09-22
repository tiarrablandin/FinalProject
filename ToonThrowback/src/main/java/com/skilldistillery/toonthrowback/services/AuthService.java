package com.skilldistillery.toonthrowback.services;

import com.skilldistillery.toonthrowback.entities.User;

public interface AuthService {
	
	public User register(User user);
	
	public User getUserByUsername(String username);
	
	User getUserById(int userId);
}
