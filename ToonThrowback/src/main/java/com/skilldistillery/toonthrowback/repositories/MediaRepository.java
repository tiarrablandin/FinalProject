package com.skilldistillery.toonthrowback.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Media;

public interface MediaRepository extends JpaRepository<Media, Integer> {

	Media getUserByIdAndActiveTrue(int userId);
	
	List<Media> findByUserIdAndActiveTrue(int id);
	
	List<Media> findByCartoonIdAndActiveTrue(int id);
	
	List <Media> findByIdAndCartoonIdAndActiveTrue(int id , int cid);
}
