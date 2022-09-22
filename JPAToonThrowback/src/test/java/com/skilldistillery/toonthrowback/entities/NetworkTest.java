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

class NetworkTest {
	static EntityManagerFactory emf;
	private EntityManager em;
	private Network network;

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
		network = em.find(Network.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		network=null;
	}

	@Test
	void test_network_entities() {
		assertNotNull(network);
		assertEquals("Nickelodeon", network.getName());
		assertTrue(network.getDescription().contains("First American cable"));
	}
	
	@Test
	void test_network_entity_mappings() {
		assertTrue(network.getCartoon().size() > 0);
	}

}
