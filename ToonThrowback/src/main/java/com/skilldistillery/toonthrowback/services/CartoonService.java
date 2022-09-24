package com.skilldistillery.toonthrowback.services;

import java.util.List;

import com.skilldistillery.toonthrowback.entities.Cartoon;
import com.skilldistillery.toonthrowback.entities.User;

public interface CartoonService {
	 public List<Cartoon> index();

	    public Cartoon show( int cid);

	    public Cartoon create(String username, Cartoon cartoon);

	    public Cartoon update(String username, int cid, Cartoon cartoon);

	    public boolean destroy(String username, int cid);

		public Cartoon updateFavorite(String username, int cid);
		
		public Cartoon deleteFavorite(String username, int cid);

		List<Cartoon> findByKeyword(String keyword);
		
		List<Cartoon> findByUserFavs(User userFavs);
	    
}
