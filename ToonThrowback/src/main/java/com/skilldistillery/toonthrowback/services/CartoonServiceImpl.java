package com.skilldistillery.toonthrowback.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.toonthrowback.entities.Cartoon;
import com.skilldistillery.toonthrowback.entities.Creator;
import com.skilldistillery.toonthrowback.entities.Network;
import com.skilldistillery.toonthrowback.entities.User;
import com.skilldistillery.toonthrowback.repositories.CartoonRepository;
import com.skilldistillery.toonthrowback.repositories.UserRepository;

@Service
public class CartoonServiceImpl implements CartoonService {

	@Autowired
	private CartoonRepository cartoonRepo;
	
	@Autowired
	private UserRepository userRepo;
	
	@Override
	public List<Cartoon> index() {
		return cartoonRepo.findAll();
	}

	@Override
	public Cartoon show(int cid) {
		Optional<Cartoon> cartoonOp = cartoonRepo.findById(cid);
		if(cartoonOp.isPresent()) {
			Cartoon cartoon = cartoonOp.get();
				return cartoon;
			}
		return null;
	}
	
	@Override
	public List<Cartoon> findByKeyword(String keyword) {
		keyword = "%" + keyword + "%";
		return cartoonRepo.findByNameIgnoreCaseLikeOrDescriptionIgnoreCaseLike(keyword, keyword);
	}
	
//	public List<Cartoon> findByNetwork(Network network){
//		return cartoonRepo.findByNetworkIgnoreCaseLike(network);
//	}
//	
//	public List<Cartoon> findByCreator(Creator creator){
//		return cartoonRepo.findByCreatorIgnoreCaseLike(creator);
//	}
	
	@Override
	public List<Cartoon> findByUserFavs(User userFavs){
		return cartoonRepo.findByUserFavs(userFavs);
	}

	@Override
	public Cartoon create(String username, Cartoon cartoon) {
		User user = userRepo.findByUsername(username);
		if(user != null) {
			cartoon.setUser(user);
			System.out.println(user);
			System.out.println(cartoon);
			return cartoonRepo.saveAndFlush(cartoon);
		}
		return null;
	}

	@Override
	public Cartoon update(String username, int cid, Cartoon cartoon) {
		System.out.println(cartoon);
		Optional<Cartoon> cartoonOp = cartoonRepo.findById(cid);
		if(cartoonOp.isPresent()) {
			Cartoon cartoonOld = cartoonOp.get();
			if (cartoonOld.getUser().getUsername().equals(username)) {
				cartoonOld.setName(cartoon.getName());
				cartoonOld.setDescription(cartoon.getDescription());
				cartoonOld.setUrl(cartoon.getUrl());
				cartoonOld.setImage(cartoon.getImage());
				cartoonOld.setAiringDate(cartoon.getAiringDate());
				cartoonOld.setFinaleDate(cartoon.getFinaleDate());
				cartoonOld.setCreatedDate(cartoon.getCreatedDate());
				cartoonOld.setUpdatedDate(cartoon.getUpdatedDate());
				cartoonOld.setNetwork(cartoon.getNetwork());
				cartoonOld.setCreator(cartoon.getCreator());
				cartoonRepo.save(cartoonOld);
				return cartoonOld;
			}
		}
		return null;
	}

	@Override
	public boolean destroy(String username, int cid) {
		Optional<Cartoon> cartoonOp = cartoonRepo.findById(cid);
		if(cartoonOp.isPresent()) {
			Cartoon cartoon = cartoonOp.get();
			if(cartoon.getUser().getUsername().equals(username)) {
				try {
					if (cartoon.isActive()) {
						cartoon.setActive(cartoon.isActive());
					}
					return true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		}
		return false;
	}
	
	@Override
	public Cartoon updateFavorite(String username, int cid) {
		Optional<Cartoon> cartoonOp = cartoonRepo.findById(cid);
		 User u = userRepo.findByUsername(username);
		if(cartoonOp.isPresent()) {
			Cartoon cartoonFav = cartoonOp.get();
			cartoonFav.addFavorite(u);
			cartoonRepo.save(cartoonFav);
			return cartoonFav;
			
			
		}
		return null;
	}

	@Override
	public Cartoon deleteFavorite(String username, int cid) {
		Optional<Cartoon> cartoonOp = cartoonRepo.findById(cid);
		User u = userRepo.findByUsername(username);
		if(cartoonOp.isPresent()) {
			Cartoon cartoonFav = cartoonOp.get();
			cartoonFav.removeFavorite(u);
			cartoonRepo.saveAndFlush(cartoonFav);
			return cartoonFav;
		}
		return null;
	}



}

