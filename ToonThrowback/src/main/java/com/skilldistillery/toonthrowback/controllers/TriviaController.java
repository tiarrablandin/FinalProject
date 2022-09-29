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

import com.skilldistillery.toonthrowback.entities.Trivia;
import com.skilldistillery.toonthrowback.services.TriviaService;

@RestController
@RequestMapping(path="api")
@CrossOrigin({"*", "http://localhost"})
public class TriviaController {
	
	@Autowired
	private TriviaService triviaService;
	
	@GetMapping("trivia")
	public List<Trivia> index() {
		return triviaService.index();
	}
	
	@GetMapping("trivia/{id}")
	public Trivia show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @PathVariable int cid) { 
		Trivia trivia = triviaService.show(id, cid);
		if(trivia == null) {
			res.setStatus(404);
		}
		return trivia;
	}
	
	@PostMapping("trivia")
	public Trivia create( @PathVariable int cid, HttpServletRequest req, HttpServletResponse res, @RequestBody Trivia trivia, Principal principal) {
		Trivia created = null;
		try {
			created = triviaService.create(trivia, cid, principal.getName());
			res.setStatus(201);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return created;
	}
	
	@PutMapping("trivia/{id}")
	public Trivia update(@PathVariable int cid, HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Trivia trivia, Principal principal) { 
		Trivia updated = null;
		try {
			updated = triviaService.update(id, cid, trivia, principal.getName());
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return updated;
	}
	
	@DeleteMapping("trivia/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = triviaService.destroy(id, principal.getName());
		if(deleted) {
			res.setStatus(204);
		}else {
			res.setStatus(404);
		}
	}

}
