package com.skilldistillery.toonthrowback.services;

import java.util.List;

import com.skilldistillery.toonthrowback.entities.Media;
import com.skilldistillery.toonthrowback.entities.Merchandise;

public interface MediaService {
	
	 public List<Media> index();

	 public Media show(int id);

	 public Media create(Media media, int cid, String username);
	    
	 public Media update(int id, Media media, String username);

	 public boolean destroy(int id, String username);

	public List<Media> toonMedia(int cid);
	
	public List<Media> findByUser_id(int id);
}
