package com.skilldistillery.toonthrowback.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class UserTest {
	static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAToonThrowback");
	}
	
	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user=null;
	}

	@Test
	void test_user_entity_mapping() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
		assertEquals("admin", user.getPassword());
		assertEquals("", user.getEmail());
		assertEquals(null, user.getFirstName());
		assertEquals(null, user.getLastName());
		assertTrue(user.getBio().contains("administrator"));
		assertTrue(user.getActive());
		assertEquals("admin", user.getRole());
	}
	
	@Test
	void test_comment_entity_mappings() {
		assertTrue(user.getCartoon().size() > 0);
		assertTrue(user.getFavCartoons().size() > 0);
		assertTrue(user.getMedia().size() > 0);
		assertTrue(user.getComment().size() > 0);
		assertTrue(user.getFacts().size() > 0);
		assertTrue(user.getMerch().size() > 0);
	}

}
