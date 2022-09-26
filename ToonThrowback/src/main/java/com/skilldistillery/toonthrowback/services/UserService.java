package com.skilldistillery.toonthrowback.services;

import java.util.List;

import com.skilldistillery.toonthrowback.entities.User;

public interface UserService {
	 public List<User> index();

	    public User show(String username);

	    public User create(User user);

	    public User update(int id, User user);

	    public boolean destroy(int id);
	

}
