package com.skilldistillery.toonthrowback.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Cartoon;
import com.skilldistillery.toonthrowback.entities.Creator;
import com.skilldistillery.toonthrowback.entities.Network;
import com.skilldistillery.toonthrowback.entities.User;

public interface NetworkRepository extends JpaRepository<Network, Integer>{
	
	
}
