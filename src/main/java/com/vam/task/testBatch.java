package com.vam.task;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.scheduling.annotation.Scheduled;


public class testBatch {

	private static final Logger log = LogManager.getLogger(testBatch.class);
	@Scheduled(cron = "0 * * * * *")
	public void testMethod() throws Exception{
		
		log.warn("배치 실행 테스트.......");
		log.warn("===================================");

		
	}
	
}
