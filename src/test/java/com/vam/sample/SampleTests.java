package com.vam.sample;

import static org.junit.Assert.assertNotNull;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SampleTests {
	private static final Logger log = LogManager.getLogger(SampleTests.class);
	@Autowired
	private Restaurant restaurant;
	
	@Test
	public void textExit() {
		
		assertNotNull(restaurant);
		
		log.info(restaurant);;
		log.info("-------------------------------");
//		log.info(restaurant.getChef());
		
	}
	
}
