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
@RequestMapping(path="api/cartoons.{cid}")
@CrossOrigin({"*", "http://localhost:4300"})
public class MediaController {
	
	@Autowired
	private CommentService commentService;
	
	@GetMapping("comments")
	public List<Comment> index(@PathVariable int cid) {
		return commentService.index(cid);
	}
	
	@GetMapping("comments/{id}")
	public Comment show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @PathVariable int cid) { 
		Comment comment = commentService.show(id, cid);
		if(comment == null) {
			res.setStatus(404);
		}
		return comment;
	}
	
	@PostMapping("comments")
	public Comment create(@PathVariable int cid, HttpServletRequest req, HttpServletResponse res, @RequestBody Comment comment, Principal principal) {
		Comment created = null;
		
		try {
			created = commentService.create(comment, cid, principal.getName());
			res.setStatus(201);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return created;
	}
	
	@PutMapping("comments/{id}")
	public Comment update(@PathVariable int cid, HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Comment comment, Principal principal) { 
		Comment updated = null;
		try {
			updated = commentService.update(id, comment, principal.getName());
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return updated;
	}
	
	@DeleteMapping("comments/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = commentService.destroy(id, principal.getName());
		if(deleted) {
			res.setStatus(204);
		}else {
			res.setStatus(404);
		}
	}
	
}
