package com.skilldistillery.toonthrowback.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
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

class FactTest {
	static EntityManagerFactory emf;
	private EntityManager em;
	private Fact fact;

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
		fact = em.find(Fact.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		fact=null;
	}

	@Test
	void test_fact_entities() {
		assertNotNull(fact);
		assertTrue(fact.getFact().contains("This cartoon bridged"));
		assertTrue(fact.isActive());
	}

	@Test
	void test_fact_entity_mappings() {
		assertEquals(1, fact.getUser().getId());
		assertEquals(1, fact.getCartoon().getId());
	}
	
}
