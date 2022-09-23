package com.skilldistillery.toonthrowback.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Trivia;

public interface TriviaRepository extends JpaRepository<Trivia, Integer> {

	Trivia getById(int userId);
	
	List<Trivia> findByUserId(int id);
	
	List<Trivia> findByCartoonId(int id);
	
	List<Trivia> findByIdAndCartoonId(int id, int cid);
	
}
