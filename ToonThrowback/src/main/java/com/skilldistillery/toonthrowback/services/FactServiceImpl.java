package com.skilldistillery.toonthrowback.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.toonthrowback.entities.Cartoon;
import com.skilldistillery.toonthrowback.entities.Fact;
import com.skilldistillery.toonthrowback.entities.User;
import com.skilldistillery.toonthrowback.repositories.CartoonRepository;
import com.skilldistillery.toonthrowback.repositories.FactRepository;
import com.skilldistillery.toonthrowback.repositories.UserRepository;

@Service
public class FactServiceImpl implements FactService {

	@Autowired
	CartoonRepository toonRepo;

	@Autowired
	private FactRepository factRepo;
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public List<Fact> index(int cid) {
		return factRepo.findByCartoonId(cid);
	}

	@Override
	public Fact show(int id, int cid) {
		Optional<Fact> factOp = factRepo.findById(id);
		if (factOp.isPresent()) {
			Fact fact = factOp.get();
			return fact;
		}
		return null;
	}

	@Override
	public Fact create(Fact fact, int cid, String username) {
		Optional<Cartoon> toonOpt = toonRepo.findById(cid);
		User user = userRepo.findByUsername(username);
		if (toonOpt.isPresent() && user != null) {
			fact.setUser(user);
			fact.setCartoon(toonOpt.get());
			return factRepo.saveAndFlush(fact);
		}
		return null;
	}

	@Override
	public Fact update(int id, Fact fact, String username) {
		Optional<Fact> factOp = factRepo.findById(id);
		if (factOp.isPresent()) {
			User user = userRepo.findByUsername(username);
			Fact factOld = factOp.get();
			if (factOld.getId() == id && user != null && factOld.getUser().equals(user)) {
				factOld.setFact(fact.getFact());
				factOld.setActive(fact.isActive());
				factOld.setCartoon(fact.getCartoon());
				factRepo.save(factOld);
				return factOld;
			}
		}
		return null;
	}

	@Override
	public boolean destroy(int id, String username) {
		Optional<Fact> factOp = factRepo.findById(id);
		if (factOp.isPresent() ) {
			User user = userRepo.findByUsername(username);
			Fact fact = factOp.get();
			if (fact.getId() == id && user != null && fact.getUser().equals(user)) {
				try {
					if (fact.isActive()) {
						fact.setActive(fact.isActive());
					}
					return true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return false;
	}
}
