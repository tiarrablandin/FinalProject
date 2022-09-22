package com.skilldistillery.toonthrowback.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.toonthrowback.entities.User;
import com.skilldistillery.toonthrowback.repositories.CartoonRepository;
import com.skilldistillery.toonthrowback.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;
	
	@Override
	public List<User> index() {
		return userRepo.findAll();
	}

	@Override
	public User show(int id) {
		Optional<User> userOp = userRepo.findById(id);
		if(userOp.isPresent()) {
			User user = userOp.get();
				return user;
			}
		return null;
	}

	@Override
	public User create(User user) {
			return userRepo.saveAndFlush(user);
	}

	@Override
	public User update(int id, User user) {
		Optional<User> userOp = userRepo.findById(id);
		if(userOp.isPresent()) {
			User userOld = userOp.get();
			if (userOld.getId() == id) {
				userOld.setImage(user.getImage());
				userOld.setUsername(user.getUsername());
				userOld.setPassword(user.getPassword());
				userOld.setEmail(user.getEmail());
				userOld.setFirstName(user.getFirstName());
				userOld.setLastName(user.getLastName());
				userOld.setBio(user.getBio());
				userOld.setActive(user.isActive());
				userOld.setRole(user.getRole());
				userRepo.save(userOld);
				return userOld;
			}
		}
		return null;
	}

	@Override
	public boolean destroy(int id) {
		Optional<User> userOp = userRepo.findById(id);
		if(userOp.isPresent()) {
			User user = userOp.get();
			if(user.getId() == id) {
				try {
					if (user.isActive()) {
						user.setActive(user.isActive());
					}
					return true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		}
		return false;
	}
}

