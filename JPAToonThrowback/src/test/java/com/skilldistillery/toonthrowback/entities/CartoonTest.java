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

class CartoonTest {
	static EntityManagerFactory emf;
	private EntityManager em;
	private Cartoon cartoon;

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
		cartoon = em.find(Cartoon.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		cartoon=null;
	}

	@Test
	void test_cartoon_entities() {
		assertNotNull(cartoon);
		assertEquals("Hey Arnold", cartoon.getName());
		assertTrue(cartoon.getDescription().contains("A young boy"));
		assertTrue(cartoon.getActive());
	}
	
	@Test
	void test_cartoon_entity_mappings() {
		assertEquals(1, cartoon.getUser().getId());
		assertTrue(cartoon.getUserFavs().size() > 0);
		assertEquals(1, cartoon.getNetwork().getId());
		assertEquals(1, cartoon.getRating().getId());
		assertEquals(1, cartoon.getCreator().getId());
		assertTrue(cartoon.getComment().size() > 0);
		assertTrue(cartoon.getFacts().size() > 0);
		assertTrue(cartoon.getTrivias().size() > 0);
		assertTrue(cartoon.getMerch().size() > 0);
	}

}
