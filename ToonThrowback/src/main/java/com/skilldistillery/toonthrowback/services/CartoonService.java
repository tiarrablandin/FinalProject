package com.skilldistillery.toonthrowback.services;

import java.util.List;

import com.skilldistillery.toonthrowback.entities.Cartoon;

public interface CartoonService {
	 public List<Cartoon> index();

	    public Cartoon show( int cid);

	    public Cartoon create(String username, Cartoon cartoon);

	    public Cartoon update(String username, int cid, Cartoon cartoon);

	    public boolean destroy(String username, int cid);
	

}
