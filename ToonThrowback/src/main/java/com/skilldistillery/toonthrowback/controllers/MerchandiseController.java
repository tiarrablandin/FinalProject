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

import com.skilldistillery.toonthrowback.entities.Cartoon;
import com.skilldistillery.toonthrowback.entities.Media;
import com.skilldistillery.toonthrowback.entities.Merchandise;
import com.skilldistillery.toonthrowback.services.MerchandiseService;

@RestController
@RequestMapping(path="api")
@CrossOrigin({"*", "http://localhost:4300"})
public class MerchandiseController {
	
	@Autowired
	private MerchandiseService merchandiseService;
	
	@GetMapping("merch")
	public List<Merchandise> index() {
		return merchandiseService.index();
	}
	
	@GetMapping("cartoons/{cid}/merch")
	public List<Merchandise> toonMerch(@PathVariable int cid) {
		return merchandiseService.toonMerch(cid);
	}
	
	@GetMapping("{cid}/merch")
	public List<Merchandise> index(@PathVariable int cid) {
		return merchandiseService.index(cid);
	}
	@GetMapping("users/{id}/merch")
	public List<Merchandise> userMerch(@PathVariable int id, HttpServletResponse res) {
		List<Merchandise> userMerch = merchandiseService.findByUser_id(id); 
		if (userMerch == null) {
			res.setStatus(404);
		}
		return userMerch;
	}
	
	@GetMapping("{cid}/merch/{id}")
	public Merchandise show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @PathVariable int cid) { 
		Merchandise merchandise = merchandiseService.show(id, cid);
		if(merchandise == null) {
			res.setStatus(404);
		}
		return merchandise;
	}
	
	@PostMapping("{cid}/merch")
	public Merchandise create( @PathVariable int cid, HttpServletRequest req, HttpServletResponse res, @RequestBody Merchandise merchandise, Principal principal) {
		Merchandise created = null;
		try {
			created = merchandiseService.create(merchandise, cid, principal.getName());
			res.setStatus(201);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return created;
	}
	
	@PutMapping("{cid}/merch/{id}")
	public Merchandise update(@PathVariable int cid, HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Merchandise merchandise, Principal principal) { 
		Merchandise updated = null;
		try {
			updated = merchandiseService.update(id, merchandise, principal.getName());
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return updated;
	}
	
	@DeleteMapping("{cid}/merch/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = merchandiseService.destroy(id, principal.getName());
		if(deleted) {
			res.setStatus(204);
		}else {
			res.setStatus(404);
		}
	}

}
