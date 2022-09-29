package com.skilldistillery.toonthrowback.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

	Comment getUserByIdAndActiveTrue(int userId);
	
	List<Comment> findByUserIdAndActiveTrue(int id);
	
	List<Comment> findByCartoonIdAndActiveTrue(int id);
	
	List<Comment> findByIdAndCartoonIdAndActiveTrue(int id, int cid);
	
}
