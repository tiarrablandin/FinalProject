package com.skilldistillery.toonthrowback.services;

import java.util.List;

import com.skilldistillery.toonthrowback.entities.Cartoon;
import com.skilldistillery.toonthrowback.entities.Merchandise;

public interface MerchandiseService {

	public List<Merchandise> index(int cid);

	public Merchandise show(int id, int cid);

	public Merchandise create(Merchandise merchandise, int cid, String username);

	public Merchandise update(int id, Merchandise merchandise, String username);

	public boolean destroy(int id, String username);

	public List<Merchandise> index();

	public List<Merchandise> findByUser_id(int id);
}
