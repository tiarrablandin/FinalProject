package com.skilldistillery.toonthrowback.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.toonthrowback.entities.Cartoon;
import com.skilldistillery.toonthrowback.entities.Trivia;
import com.skilldistillery.toonthrowback.entities.User;
import com.skilldistillery.toonthrowback.repositories.CartoonRepository;
import com.skilldistillery.toonthrowback.repositories.TriviaRepository;
import com.skilldistillery.toonthrowback.repositories.UserRepository;

@Service
public class TriviaServiceImpl implements TriviaService {

	@Autowired
	CartoonRepository toonRepo;

	@Autowired
	private TriviaRepository triviaRepo;

	@Autowired
	private UserRepository userRepo;

	@Override
	public List<Trivia> index() {
		return triviaRepo.findAll();
	}

	@Override
	public Trivia show(int id, int cid) {
		Optional<Trivia> triviaOp = triviaRepo.findById(id);
		if (triviaOp.isPresent()) {
			Trivia trivia = triviaOp.get();
			return trivia;
		}
		return null;
	}

	@Override
	public Trivia create(Trivia trivia, int cid, String username) {
		Optional<Cartoon> toonOpt = toonRepo.findById(cid);
		User user = userRepo.findByUsername(username);
		if (toonOpt.isPresent() && user != null) {
			trivia.setUser(user);
			trivia.setCartoon(toonOpt.get());
			return triviaRepo.saveAndFlush(trivia);
		}
		return null;
	}

	@Override
	public Trivia update(int id, int cid, Trivia trivia, String username) {
		Optional<Trivia> triviaOp = triviaRepo.findById(id);
		if (triviaOp.isPresent()) {
			User user = userRepo.findByUsername(username);
			Trivia triviaOld = triviaOp.get();
			if (triviaOld.getId() == id && user != null && triviaOld.getUser().equals(user)) {
				triviaOld.setQuestion(trivia.getQuestion());
				triviaOld.setAnswer(trivia.getAnswer());
				triviaOld.setCartoon(trivia.getCartoon());
				triviaOld.setCartoon(new Cartoon());
				triviaOld.getCartoon().setId(cid);
				triviaRepo.save(triviaOld);
				return triviaOld;
			}
		}
		return null;
	}

	@Override
	public boolean destroy(int id, String username) {
		Optional<Trivia> triviaOp = triviaRepo.findById(id);
		if (triviaOp.isPresent()) {
			User user = userRepo.findByUsername(username);
			Trivia trivia = triviaOp.get();
			if (trivia.getId() == id && user != null && trivia.getUser().equals(user)) {
				try {
					if (trivia.isActive()) {
						trivia.setActive(trivia.isActive());
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
