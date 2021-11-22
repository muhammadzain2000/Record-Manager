package com.record.keeping.services;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.record.keeping.models.File;
import com.record.keeping.repositories.FileRepository;

@Service
public class FileService {

	private static final Logger logger = LoggerFactory.getLogger(FileService.class);

	@Autowired
	private FileRepository fileRepository;

	public List<File> getAll() {
		return fileRepository.findAll();
	}

	public File getOne(Long id) {
		return fileRepository.findById(id).orElse(null);
	}

	public File insert(File file) {
		return fileRepository.save(file);
	}

	public File update(File file, Long id) {
		File existingFile = getOne(id);
		if (existingFile != null) {
			existingFile.setId(file.getId());
			existingFile.setSubject(file.getSubject());
			existingFile.setName(file.getName());
			existingFile.setDate(file.getDate());
			existingFile.setFileBytes(file.getFileBytes());
			existingFile.setDepartments(file.getDepartments());
//			existingFile.setCreater(file.getCreater());
			return fileRepository.save(existingFile);
		} else {
			return null;
		}

	}

	public void delete(Long id) {
		File existingFile = getOne(id);
		if (existingFile != null) {
			fileRepository.delete(existingFile);
		}
	}

}
