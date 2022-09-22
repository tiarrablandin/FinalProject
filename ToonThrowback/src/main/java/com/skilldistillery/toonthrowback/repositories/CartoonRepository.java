package com.skilldistillery.toonthrowback.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Cartoon;

public interface CartoonRepository extends JpaRepository<Cartoon, Integer>{
	
	List<Cartoon> findByName(String name);
	
	

}
