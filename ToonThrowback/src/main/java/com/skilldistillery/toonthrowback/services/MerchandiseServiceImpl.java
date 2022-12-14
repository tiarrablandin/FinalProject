package com.skilldistillery.toonthrowback.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.toonthrowback.entities.Cartoon;
import com.skilldistillery.toonthrowback.entities.Merchandise;
import com.skilldistillery.toonthrowback.entities.User;
import com.skilldistillery.toonthrowback.repositories.CartoonRepository;
import com.skilldistillery.toonthrowback.repositories.MerchandiseRepository;
import com.skilldistillery.toonthrowback.repositories.UserRepository;

@Service
public class MerchandiseServiceImpl implements MerchandiseService {

	@Autowired
	CartoonRepository toonRepo;

	@Autowired
	private MerchandiseRepository merchandiseRepo;
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public List<Merchandise> index() {
		return merchandiseRepo.findAll();
	}
	
	@Override
	public List<Merchandise> index(int cid) {
		return merchandiseRepo.findByCartoonIdAndActiveTrue(cid);
	}

	@Override
	public Merchandise show(int id, int cid) {
		Optional<Merchandise> merchandiseOp = merchandiseRepo.findById(id);
		if (merchandiseOp.isPresent()) {
			Merchandise merchandise = merchandiseOp.get();
			return merchandise;
		}
		return null;
	}
	@Override
	public List<Merchandise> findByUser_id(int id) {
		if ( userRepo.existsById(id)) {
			return merchandiseRepo.findByUser_idAndActiveTrue(id);
		}
		return null;
	}

	@Override
	public Merchandise create(Merchandise merchandise, int cid, String username) {
		Optional<Cartoon> toonOpt = toonRepo.findById(cid);
		User user = userRepo.findByUsername(username);
		if (toonOpt.isPresent() && user != null) {
			merchandise.setUser(user);
			merchandise.setCartoon(toonOpt.get());
			return merchandiseRepo.saveAndFlush(merchandise);
		}
		return null;
	}

	@Override
	public Merchandise update(int id, Merchandise merchandise, String username) {
		Optional<Merchandise> merchandiseOp = merchandiseRepo.findById(id);
		if (merchandiseOp.isPresent()) {
			User user = userRepo.findByUsername(username);
			Merchandise merchandiseOld = merchandiseOp.get();
			if (merchandiseOld.getId() == id && user != null && (merchandiseOld.getUser().equals(user) || user.getRole().equals("admin"))) {
				merchandiseOld.setImage(merchandise.getImage());
				merchandiseOld.setUrl(merchandise.getUrl());
				merchandiseOld.setCartoon(merchandise.getCartoon());
				merchandiseOld.setDescription(merchandise.getDescription());
				merchandiseRepo.save(merchandiseOld);
				return merchandiseOld;
			}
		}
		return null;
	}

	@Override
	public boolean destroy(int id, String username) {
		Optional<Merchandise> merchandiseOp = merchandiseRepo.findById(id);
		if (merchandiseOp.isPresent() ) {
			User user = userRepo.findByUsername(username);
			Merchandise merchandise = merchandiseOp.get();
			if (merchandise.getId() == id && user != null && (merchandise.getUser().equals(user) || user.getRole().equals("admin"))) {
				try {
					if (merchandise.isActive()) {
						merchandise.setActive(false);
						merchandiseRepo.save(merchandise);
					}
					return true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return false;
	}
	
	@Override
	public List<Merchandise> toonMerch(int cid) {
		return merchandiseRepo.findByCartoonIdAndActiveTrue(cid);
	}
}
