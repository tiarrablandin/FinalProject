package com.skilldistillery.toonthrowback.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

	Comment getUserById(int userId);
	
	Comment findByUserId(int id);
	
	Comment findByCartoonId(int id);
	
}
