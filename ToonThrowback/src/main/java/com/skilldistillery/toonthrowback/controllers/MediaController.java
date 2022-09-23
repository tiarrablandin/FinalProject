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

import com.skilldistillery.toonthrowback.entities.Media;
import com.skilldistillery.toonthrowback.services.MediaService;

@RestController
@RequestMapping(path="api")
@CrossOrigin({"*", "http://localhost:4300"})
public class MediaController {
	
	@Autowired
	private MediaService mediaService;
	
	@GetMapping("media")
	public List<Media> index(@PathVariable int cid) {
		return mediaService.index(cid);
	}
	
	@GetMapping("media/{id}")
	public Media show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @PathVariable int cid) { 
		Media media = mediaService.show(id, cid);
		if(media == null) {
			res.setStatus(404);
		}
		return media;
	}
	
	@PostMapping("media")
	public Media create(@PathVariable int cid, HttpServletRequest req, HttpServletResponse res, @RequestBody Media media, Principal principal) {
		Media created = null;
		
		try {
			created = mediaService.create(media, cid, principal.getName());
			res.setStatus(201);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return created;
	}
	
	@PutMapping("media/{id}")
	public Media update(@PathVariable int cid, HttpServletRequest req, HttpServletResponse res, @PathVariable int id, @RequestBody Media media, Principal principal) { 
		Media updated = null;
		try {
			updated = mediaService.update(id, media, principal.getName());
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return updated;
	}
	
	@DeleteMapping("medias/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean deleted = mediaService.destroy(id, principal.getName());
		if(deleted) {
			res.setStatus(204);
		}else {
			res.setStatus(404);
		}
	}
	
}
