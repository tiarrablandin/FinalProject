package com.skilldistillery.toonthrowback.services;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Cartoon;
import com.skilldistillery.toonthrowback.entities.User;
import com.skilldistillery.toonthrowback.repositories.CartoonRepository;
import com.skilldistillery.toonthrowback.repositories.UserRepository;

public class CartoonServiceImpl implements CartoonService {

	@Autowired
	private CartoonRepository cartoonRepo;
	
	@Autowired
	private UserRepository userRepository;
	
	@Override
	public Set<Cartoon> index(String name) {
		return null;
	}

	@Override
	public Cartoon show(String name, int cid) {
		return null;
	}

	@Override
	public Cartoon create(String name, Cartoon cartoon) {
		return null;
	}

	@Override
	public Cartoon update(String name, int cid, Cartoon cartoon) {
		return null;
	}

	@Override
	public boolean destroy(String name, int cid) {
		return false;
	}

}
