package com.skilldistillery.toonthrowback.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Rating;

public interface RatingRepository extends JpaRepository<Rating, Integer>{
	
	
}
