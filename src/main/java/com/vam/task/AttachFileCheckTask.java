package com.vam.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.vam.mapper.AdminMapper;
import com.vam.model.AttachImageVO;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class AttachFileCheckTask {
	private static final Logger log = LogManager.getLogger(AttachFileCheckTask.class);
	@Autowired
	private AdminMapper mapper;
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}	
	
	@Scheduled(cron="0 * * * * *")
	public void checkFiles() throws Exception{	
		
		log.warn("File Check Task Run..........");
		log.warn(new Date());
		log.warn("========================================");		
		
		// DBì—� ì €ìž¥ë�œ íŒŒì�¼ ë¦¬ìŠ¤íŠ¸
		List<AttachImageVO> fileList = mapper.checkFileList();		
		
		
		// ë¹„êµ� ê¸°ì¤€ íŒŒì�¼ ë¦¬ìŠ¤íŠ¸(Pathê°�ì²´)
		List<Path> checkFilePath = new ArrayList<Path>();
			//ì›�ë³¸ ì�´ë¯¸ì§€
		fileList.forEach(vo -> {
			Path path = Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
			checkFilePath.add(path);
		});		
			//ì�¸ë„¤ì�¼ ì�´ë¯¸ì§€
		fileList.forEach(vo -> {
			Path path = Paths.get("C:\\upload", vo.getUploadPath(), "s_" +  vo.getUuid() + "_" + vo.getFileName());
			checkFilePath.add(path);
		});
		
		
		// ë””ë ‰í† ë¦¬ íŒŒì�¼ ë¦¬ìŠ¤íŠ¸
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
		File[] targetFile = targetDir.listFiles();
		
		
		// ì‚­ì œ ëŒ€ìƒ� íŒŒì�¼ ë¦¬ìŠ¤íŠ¸(ë¶„ë¥˜)
		List<File> removeFileList = new ArrayList<File>(Arrays.asList(targetFile));		
		for(File file : targetFile){
			checkFilePath.forEach(checkFile ->{
				if(file.toPath().equals(checkFile)) 
					removeFileList.remove(file);	
			});
		}
		
		
		// ì‚­ì œ ëŒ€ìƒ� íŒŒì�¼ ì œê±°
		log.warn("file Delete : ");
		for(File file : removeFileList) {
			log.warn(file);
			file.delete();
		}		
		
		log.warn("========================================");
		
	}
	
	
}
