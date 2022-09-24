package com.skilldistillery.toonthrowback.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Cartoon;
import com.skilldistillery.toonthrowback.entities.User;

public interface CartoonRepository extends JpaRepository<Cartoon, Integer>{
	
	List<Cartoon> findByName(String name);
	
	List<Cartoon> findByNameIgnoreCaseLikeOrDescriptionIgnoreCaseLikeOrNetworkIgnoreCaseLikeOrCreatorIgnoreCaseLike(
			String name, String description, String network, String creator);

	List<Cartoon> findByUserFavs(User userFavs);
	
}
