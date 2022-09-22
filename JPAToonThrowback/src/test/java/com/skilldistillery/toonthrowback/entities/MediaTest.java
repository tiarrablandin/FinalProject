package com.skilldistillery.toonthrowback.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class MediaTest {
	static EntityManagerFactory emf;
	private EntityManager em;
	private Media media;

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
		media = em.find(Media.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		media=null;
	}

	@Test
	void test_media_entities() {
		assertNotNull(media);
		assertEquals("Video Clip", media.getTitle());
		assertTrue(media.getDescription().contains("Clips of"));
		assertNull(media.getSeason());
		assertNull(media.getEpisodeNum());
		assertTrue(media.isActive());
	}
	
	@Test
	void test_media_entity_mappings() {
		assertEquals(1, media.getUser().getId());
		assertEquals(1, media.getCartoon().getId());
	}

}
