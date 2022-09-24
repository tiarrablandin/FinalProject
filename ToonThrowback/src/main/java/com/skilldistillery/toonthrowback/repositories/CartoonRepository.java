package com.skilldistillery.toonthrowback.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.toonthrowback.entities.Cartoon;
import com.skilldistillery.toonthrowback.entities.Creator;
import com.skilldistillery.toonthrowback.entities.Network;
import com.skilldistillery.toonthrowback.entities.User;

public interface CartoonRepository extends JpaRepository<Cartoon, Integer>{
	
	List<Cartoon> findByName(String name);
	
	List<Cartoon> findByNameIgnoreCaseLikeOrDescriptionIgnoreCaseLike(
			String name, String description);
	
//	List<Cartoon> findByNetworkIgnoreCaseLike(Network network);
//	
//	List<Cartoon> findByCreatorIgnoreCaseLike(Creator creator);

	List<Cartoon> findByUserFavs(User userFavs);
	
}
