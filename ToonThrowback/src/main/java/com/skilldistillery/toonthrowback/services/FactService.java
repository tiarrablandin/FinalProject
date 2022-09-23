package com.skilldistillery.toonthrowback.services;

import java.util.List;

import com.skilldistillery.toonthrowback.entities.Fact;

public interface FactService {
	
	 public List<Fact> index(int cid);

	 public Fact show( int id, int cid);

	 public Fact create(Fact fact, int cid, String username);
	    
	 public Fact update(int cid, int id, Fact fact, String username);

	 public boolean destroy(int id, String username);
}
