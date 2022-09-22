package com.skilldistillery.toonthrowback.services;

import java.util.List;

import com.skilldistillery.toonthrowback.entities.Comment;

public interface CommentService {
	 public List<Comment> index();

	    public Comment show( int id);

	    public Comment create(Comment comment);
	    
	    public Comment create(Comment comment, int parentId);
	    
	    public Comment update(int id, Comment comment);

	    public boolean destroy(int id);
	

}
