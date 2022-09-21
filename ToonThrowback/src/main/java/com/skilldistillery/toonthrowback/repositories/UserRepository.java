package com.skilldistillery.toonthrowback.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User getUserById(int userId);
	User findByUsername(String username);
	
}
