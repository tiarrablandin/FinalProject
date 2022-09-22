package com.skilldistillery.toonthrowback.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.toonthrowback.entities.Comment;
import com.skilldistillery.toonthrowback.repositories.CommentRepository;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentRepository commentRepo;
	
	@Override
	public List<Comment> index() {
		return commentRepo.findAll();
	}

	@Override
	public Comment show(int id) {
		Optional<Comment> commentOp = commentRepo.findById(id);
		if(commentOp.isPresent()) {
			Comment comment = commentOp.get();
				return comment;
			}
		return null;
	}

	@Override
	public Comment create(Comment comment) {
			return commentRepo.saveAndFlush(comment);
	}
	
	@Override
	public Comment create(Comment comment, int parentId) {
		Comment parent = show(parentId);
		if(parent != null) {
			comment.setParentComment(parent);
			return commentRepo.saveAndFlush(comment);
		}
		return null;
	}

	@Override
	public Comment update(int id, Comment comment) {
		Optional<Comment> commentOp = commentRepo.findById(id);
		if(commentOp.isPresent()) {
			Comment commentOld = commentOp.get();
			if (commentOld.getId() == id) {
				commentOld.setComment(comment.getComment());
				commentOld.setActive(comment.isActive());
				commentRepo.save(commentOld);
				return commentOld;
			}
		}
		return null;
	}

	@Override
	public boolean destroy(int id) {
		Optional<Comment> commentOp = commentRepo.findById(id);
		if(commentOp.isPresent()) {
			Comment comment = commentOp.get();
			if(comment.getId() == id) {
				try {
					if (comment.isActive()) {
						comment.setActive(comment.isActive());
					}
					return true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		}
		return false;
	}
}

