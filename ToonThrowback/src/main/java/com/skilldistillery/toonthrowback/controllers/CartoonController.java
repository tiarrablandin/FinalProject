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
import com.skilldistillery.toonthrowback.entities.Creator;
import com.skilldistillery.toonthrowback.entities.Network;
import com.skilldistillery.toonthrowback.entities.User;
import com.skilldistillery.toonthrowback.services.CartoonService;

@RestController
@RequestMapping(path="api")
@CrossOrigin({"*", "http://localhost:4300"})
public class CartoonController {
	
	@Autowired
	private CartoonService cartoonService;
	
	@GetMapping("cartoons")
	public List<Cartoon> index() {
		return cartoonService.index();
	}
	@GetMapping("users/{id}/cartoons")
	public List<Cartoon> userCartoons(@PathVariable int id, HttpServletResponse res) {
		List<Cartoon> userCartoon = cartoonService.findByUser_id(id); 
		if (userCartoon == null) {
			res.setStatus(404);
		}
		return userCartoon;
	}
	
	@GetMapping("cartoons/{cid}")
	public Cartoon show(HttpServletRequest req, HttpServletResponse res, @PathVariable int cid) { 
		Cartoon cartoon = cartoonService.show(cid);
		if(cartoon == null) {
			res.setStatus(404);
		}
		return cartoon;
	}
	
	@GetMapping("cartoons/search/{keyword}")
	public List<Cartoon> findByKeyword(@PathVariable String keyword) {
		return cartoonService.findByKeyword(keyword);
	}
	
//	@GetMapping("cartoons/{network}")
//	public List<Cartoon> findByNetwork(@PathVariable Network network) {
//		return cartoonService.findByNetwork(network);
//	}
//	
//	@GetMapping("cartoons/{creator}")
//	public List<Cartoon> findByCreator(@PathVariable Creator creator) {
//		return cartoonService.findByCreator(creator);
//	}
	
	@GetMapping("cartoons/{favs}")
	public List<Cartoon> findByUserFavs(@PathVariable User userFavs) {
		return cartoonService.findByUserFavs(userFavs);
	}
	
	@PostMapping("cartoons")
	public Cartoon create(HttpServletRequest req, HttpServletResponse res, @RequestBody Cartoon cartoon, Principal principal) {
		Cartoon created = null;
		
		try {
			created = cartoonService.create(principal.getName(), cartoon);
			res.setStatus(201);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return created;
	}
	
	@PutMapping("cartoons/{cid}")
	public Cartoon update(HttpServletRequest req, HttpServletResponse res, @PathVariable int cid, @RequestBody Cartoon cartoon, Principal principal) { 
		Cartoon updated = null;
		
		try {
			updated = cartoonService.update(principal.getName(), cid, cartoon);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return updated;
		
	}
	
	@DeleteMapping("cartoons/{cid}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int cid, Principal principal) {
		boolean deleted = cartoonService.destroy(principal.getName(), cid);
		if(deleted) {
			res.setStatus(204);
		}else {
			res.setStatus(404);
		}
	}
	
	@PutMapping("cartoons/fav/{cid}")
	public Cartoon updateFavorite(HttpServletRequest req, HttpServletResponse res, @PathVariable int cid, Principal principal) { 
		Cartoon updated = null;
		
		try {
			updated = cartoonService.updateFavorite(principal.getName(), cid);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return updated;
	}
	
	@DeleteMapping("cartoons/fav/{cid}")
	public void destroyFavorite(HttpServletRequest req, HttpServletResponse res, @PathVariable int cid, Principal principal) {
		 Cartoon deleteFav = cartoonService.deleteFavorite(principal.getName(), cid);
		if(deleteFav != null) {
			res.setStatus(204);
		}else {
			res.setStatus(404);
		}
	}

}
