package com.skilldistillery.toonthrowback.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.toonthrowback.entities.Cartoon;
import com.skilldistillery.toonthrowback.entities.Media;
import com.skilldistillery.toonthrowback.entities.User;
import com.skilldistillery.toonthrowback.repositories.CartoonRepository;
import com.skilldistillery.toonthrowback.repositories.MediaRepository;
import com.skilldistillery.toonthrowback.repositories.UserRepository;

@Service
public class MediaServiceImpl implements MediaService {

	@Autowired
	private MediaRepository mediaRepo;
	
	@Autowired
	private CartoonRepository toonRepo;
	
	@Autowired
	private UserRepository userRepo;
	
	@Override
	public List<Media> index() {
		return mediaRepo.findAll();
	}

	@Override
	public Media show(int id) {
		Optional<Media> mediaOp = mediaRepo.findById(id);
		if(mediaOp.isPresent()) {
			Media media = mediaOp.get();
				return media;
			}
		return null;
	}

	@Override
	public Media create(Media media, int cid, String username) {
		Optional<Cartoon> toonOp = toonRepo.findById(cid);
		User user = userRepo.findByUsername(username);
		if(toonOp.isPresent() && user != null) {
			media.setUser(user);
			media.setCartoon(toonOp.get());
			return mediaRepo.saveAndFlush(media);
		}
		return null;
	}
	
	@Override
	public Media update(int id, Media media, String username) {
		Optional<Media> mediaOp = mediaRepo.findById(id);
		if(mediaOp.isPresent()) {
			User user = userRepo.findByUsername(username);
			Media mediaOld = mediaOp.get();
			if (mediaOld.getId() == id && user != null && mediaOld.getUser().equals(user)) {
				mediaOld.setImage(media.getImage());
				mediaOld.setTitle(media.getTitle());
				mediaOld.setDescription(media.getDescription());
				mediaOld.setUrl(media.getUrl());
				mediaOld.setSeason(media.getSeason());
				mediaOld.setEpisodeNum(media.getEpisodeNum());
				mediaOld.setActive(media.isActive());
				mediaRepo.save(mediaOld);
				return mediaOld;
			}
		}
		return null;
	}

	@Override
	public boolean destroy(int id, String username) {
		Optional<Media> mediaOp = mediaRepo.findById(id);
		if(mediaOp.isPresent()) {
			User user = userRepo.findByUsername(username);
			Media media = mediaOp.get();
			if(media.getId() == id && user != null && media.getUser().equals(user)) {
				try {
					if (media.isActive()) {
						media.setActive(media.isActive());
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

