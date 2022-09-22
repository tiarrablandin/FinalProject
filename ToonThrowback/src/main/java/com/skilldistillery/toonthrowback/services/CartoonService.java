package com.skilldistillery.toonthrowback.services;

import java.util.Set;

import com.skilldistillery.toonthrowback.entities.Cartoon;

public interface CartoonService {
	 public Set<Cartoon> index(String name);

	    public Cartoon show(String name, int cid);

	    public Cartoon create(String name, Cartoon cartoon);

	    public Cartoon update(String name, int cid, Cartoon cartoon);

	    public boolean destroy(String name, int cid);
	

}
