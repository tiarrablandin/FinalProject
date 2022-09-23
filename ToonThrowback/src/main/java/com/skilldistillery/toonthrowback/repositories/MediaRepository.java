package com.skilldistillery.toonthrowback.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Media;

public interface MediaRepository extends JpaRepository<Media, Integer> {

	Media getUserById(int userId);
	
	List<Media> findByUserId(int id);
	
	List<Media> findByCartoonId(int id);
	
	List <Media> findByIdAndCartoonId(int id , int cid);
}
