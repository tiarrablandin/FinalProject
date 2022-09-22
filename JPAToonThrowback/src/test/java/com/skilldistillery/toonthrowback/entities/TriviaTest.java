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

class TriviaTest {
	static EntityManagerFactory emf;
	private EntityManager em;
	private Trivia trivia;

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
		trivia = em.find(Trivia.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		trivia=null;
	}

	@Test
	void test_trivia_entities() {
		assertNotNull(trivia);
		assertTrue(trivia.getQuestion().contains("In what historic event"));
		assertEquals("The Fall of Saigon.", trivia.getAnswer());
	}
	
	@Test
	void test_trivia_entity_mappings() {
		assertEquals(1, trivia.getCartoon().getId());
	}

}
