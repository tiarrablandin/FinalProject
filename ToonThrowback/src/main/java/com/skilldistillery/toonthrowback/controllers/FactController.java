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

import com.skilldistillery.toonthrowback.entities.Fact;
import com.skilldistillery.toonthrowback.services.FactService;

@RestController
@RequestMapping(path="api/{cid}")
@CrossOrigin({"*", "http://localhost:4300"})
public class FactController {
	
	@Autowired
	private FactService factService;
	
	@GetMapping("fact")
	public List<Fact> index(@PathVariable int cid) {
		return factService.index(cid);
	}
	
	@GetMapping("fact/{id}")
	public Fact show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @PathVariable int cid) { 
		Fact fact = factService.show(id, cid);
		if(fact == null) {
			res.setStatus(404);
		}
		return fact;
	}
	
	@PostMapping("fact")
	public Fact create( @PathVariable int cid, HttpServletRequest req, HttpServletResponse res, @RequestBody Fact fact, Principal principal) {
		Fact created = null;
		try {
			created = factService.create(fact, cid, principal.getName());
			res.setStatus(201);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return created;
	}
	
	@PutMapping("fact/{id}")
	public Fact update(@PathVariable int cid, HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Fact fact, Principal principal) { 
		Fact updated = null;
		try {
			updated = factService.update(cid, id, fact, principal.getName());
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return updated;
	}
	
	@DeleteMapping("fact/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = factService.destroy(id, principal.getName());
		if(deleted) {
			res.setStatus(204);
		}else {
			res.setStatus(404);
		}
	}

}
