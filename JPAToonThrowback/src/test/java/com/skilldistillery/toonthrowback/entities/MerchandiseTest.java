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

class MerchandiseTest {
	static EntityManagerFactory emf;
	private EntityManager em;
	private Merchandise merch;

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
		merch = em.find(Merchandise.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		merch=null;
	}

	@Test
	void test_merchandise_entities() {
		assertNotNull(merch);
		assertTrue(merch.isActive());
	}
	
	@Test
	void test_merchandise_entity_mappings() {
		assertEquals(1, merch.getUser().getId());
		assertEquals(1, merch.getCartoon().getId());
	}

}
