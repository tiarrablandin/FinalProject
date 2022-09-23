package com.skilldistillery.toonthrowback.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Fact;

public interface FactRepository extends JpaRepository<Fact, Integer> {

	Fact getById(int userId);
	
	List<Fact> findByUserId(int id);
	
	List<Fact> findByCartoonId(int id);
	
	List<Fact> findByIdAndCartoonId(int id, int cid);
	
}
