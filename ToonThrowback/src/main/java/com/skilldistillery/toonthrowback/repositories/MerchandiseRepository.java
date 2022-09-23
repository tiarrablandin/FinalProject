package com.skilldistillery.toonthrowback.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Merchandise;

public interface MerchandiseRepository extends JpaRepository<Merchandise, Integer> {

	Merchandise getById(int userId);
	
	List<Merchandise> findByUserId(int id);
	
	List<Merchandise> findByCartoonId(int id);
	
	List<Merchandise> findByIdAndCartoonId(int id, int cid);
	
}
