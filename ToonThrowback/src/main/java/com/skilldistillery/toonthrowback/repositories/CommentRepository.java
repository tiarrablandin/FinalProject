package com.skilldistillery.toonthrowback.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

	Comment getUserById(int userId);
	
	List<Comment> findByUserId(int id);
	
	List<Comment> findByCartoonId(int id);
	
	List<Comment> findByIdAndCartoonId(int id, int cid);
	
}
