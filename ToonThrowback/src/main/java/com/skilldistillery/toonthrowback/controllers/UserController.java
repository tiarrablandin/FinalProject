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
import com.skilldistillery.toonthrowback.entities.User;
import com.skilldistillery.toonthrowback.services.CommentService;
import com.skilldistillery.toonthrowback.services.UserService;

@RestController
@RequestMapping(path="api")
@CrossOrigin({"*", "http://localhost"})
public class UserController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private CommentService commentService;
	
	@GetMapping("users")
	public List<User> index() {
		return userService.index();
	}
	@GetMapping("users/{id}/comments")
	public List<Comment> indexUser(@PathVariable int id) {
		return commentService.indexUser(id);
	}
	
	@GetMapping("users/profile")
	public User show(HttpServletRequest req, HttpServletResponse res, Principal principal) { 
		User user = userService.show(principal.getName());
		if(user == null) {
			res.setStatus(404);
		}
		return user;
	}
	
	@PostMapping("users")
	public User create(HttpServletRequest req, HttpServletResponse res, @RequestBody User user, Principal principal) {
		User created = null;
		
		try {
			created = userService.create(user);
			res.setStatus(201);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return created;
	}
	
	@PutMapping("users/{id}")
	public User update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody User user, Principal principal) { 
		User updated = null;
		
		try {
			updated = userService.update(id, user);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return updated;
		
	}
	
	@DeleteMapping("users/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = userService.destroy(id);
		if(deleted) {
			res.setStatus(204);
		}else {
			res.setStatus(404);
		}
	}
	
	
	

}
