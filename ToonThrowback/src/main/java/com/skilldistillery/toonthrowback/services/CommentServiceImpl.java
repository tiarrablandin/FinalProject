package com.skilldistillery.toonthrowback.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.toonthrowback.entities.Cartoon;
import com.skilldistillery.toonthrowback.entities.Comment;
import com.skilldistillery.toonthrowback.entities.User;
import com.skilldistillery.toonthrowback.repositories.CartoonRepository;
import com.skilldistillery.toonthrowback.repositories.CommentRepository;
import com.skilldistillery.toonthrowback.repositories.UserRepository;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	CartoonRepository toonRepo;

	@Autowired
	private CommentRepository commentRepo;
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public List<Comment> index(int cid) {
		return commentRepo.findByCartoonId(cid);
	}

	@Override
	public Comment show(int id, int cid) {
		Optional<Comment> commentOp = commentRepo.findById(id);
		if (commentOp.isPresent()) {
			Comment comment = commentOp.get();
			return comment;
		}
		return null;
	}

	@Override
	public Comment create(Comment comment, int cid, String username) {
		Optional<Cartoon> toonOpt = toonRepo.findById(cid);
		User user = userRepo.findByUsername(username);
		if (toonOpt.isPresent() && user != null) {
			comment.setUser(user);
			comment.setCartoon(toonOpt.get());
			return commentRepo.saveAndFlush(comment);
		}
		return null;
	}

	@Override
	public Comment create(Comment comment, int parentId, int cid, String username) {
		Comment parent = show(parentId, cid);
		User user = userRepo.findByUsername(username);
		if (parent != null && user != null) {
			comment.setUser(user);
			comment.setParentComment(parent);
			comment.setCartoon(parent.getCartoon());
			return commentRepo.saveAndFlush(comment);
		}
		return null;
	}

	@Override
	public Comment update(int id, Comment comment, String username) {
		Optional<Comment> commentOp = commentRepo.findById(id);
		if (commentOp.isPresent()) {
			User user = userRepo.findByUsername(username);
			Comment commentOld = commentOp.get();
			if (commentOld.getId() == id && user != null && commentOld.getUser().equals(user)) {
				commentOld.setComment(comment.getComment());
				commentOld.setActive(comment.isActive());
				commentRepo.save(commentOld);
				return commentOld;
			}
		}
		return null;
	}

	@Override
	public boolean destroy(int id, String username) {
		Optional<Comment> commentOp = commentRepo.findById(id);
		if (commentOp.isPresent() ) {
			User user = userRepo.findByUsername(username);
			Comment comment = commentOp.get();
			if (comment.getId() == id && user != null && comment.getUser().equals(user)) {
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
