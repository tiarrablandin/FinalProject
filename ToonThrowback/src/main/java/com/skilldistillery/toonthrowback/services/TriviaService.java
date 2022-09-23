package com.skilldistillery.toonthrowback.services;

import java.util.List;

import com.skilldistillery.toonthrowback.entities.Trivia;

public interface TriviaService {
	
	 public List<Trivia> index(int cid);

	 public Trivia show( int id, int cid);

	 public Trivia create(Trivia trivia, int cid, String username);
	    
	 public Trivia update(int id, int cid, Trivia trivia, String username);

	 public boolean destroy(int id, String username);
}
