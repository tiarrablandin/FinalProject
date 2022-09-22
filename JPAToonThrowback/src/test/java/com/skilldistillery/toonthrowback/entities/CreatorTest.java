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

class CreatorTest {
	static EntityManagerFactory emf;
	private EntityManager em;
	private Creator creator;

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
		creator = em.find(Creator.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		creator=null;
	}

	@Test
	void test_creator_entities() {
		assertNotNull(creator);
		assertEquals("Craig Bartlett", creator.getName());
		assertTrue(creator.getBio().contains("Born in 1956"));
	}
	
	@Test
	void test_creator_entity_mappings() {
		assertTrue(creator.getCartoon().size() > 0);
	}

}
