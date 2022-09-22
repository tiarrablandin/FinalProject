package com.skilldistillery.toonthrowback.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.toonthrowback.entities.Comment;
import com.skilldistillery.toonthrowback.services.CommentService;

@RestController
@RequestMapping(path="api")
@CrossOrigin({"*", "http://localhost:4300"})
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	
	@GetMapping("comments")
	public List<Comment> index() {
		return commentService.index();
	}
	
	@GetMapping("comments/{id}")
	public Comment show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id) { 
		Comment comment = commentService.show(id);
		if(comment == null) {
			res.setStatus(404);
		}
		return comment;
	}
	
	@PostMapping("comments")
	public Comment create(HttpServletRequest req, HttpServletResponse res, @RequestBody Comment comment, Principal principal) {
		Comment created = null;
		
		try {
			created = commentService.create(comment);
			res.setStatus(201);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return created;
	}
	
	@PostMapping("comments/{cid}")
	public Comment createReply(HttpServletRequest req, HttpServletResponse res, @PathVariable int cid, @RequestBody Comment comment, Principal principal) {
		Comment created = null;
		try {
			created = commentService.create(comment, cid);
			res.setStatus(201);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return created;
	}
	
	@PutMapping("comments/{id}")
	public Comment update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Comment comment, Principal principal) { 
		Comment updated = null;
		
		try {
			updated = commentService.update(id, comment);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return updated;
		
	}
	
	@DeleteMapping("comments/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = commentService.destroy(id);
		if(deleted) {
			res.setStatus(204);
		}else {
			res.setStatus(404);
		}
	}
	
	
	

}
