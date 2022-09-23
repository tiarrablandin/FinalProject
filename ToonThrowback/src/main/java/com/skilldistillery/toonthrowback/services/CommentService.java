package com.skilldistillery.toonthrowback.services;

import java.util.List;

import com.skilldistillery.toonthrowback.entities.Comment;

public interface CommentService {
	
	 public List<Comment> index(int cid);

	 public Comment show( int id, int cid);

	 public Comment create(Comment comment, int cid, String username);
	    
	 public Comment create(Comment comment, int parentId, int cid, String username);
	    
	 public Comment update(int id, Comment comment, String username);

	 public boolean destroy(int id, String username);
}
