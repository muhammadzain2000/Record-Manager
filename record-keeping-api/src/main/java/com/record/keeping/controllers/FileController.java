package com.record.keeping.controllers;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.record.keeping.models.Department;
import com.record.keeping.models.File;
import com.record.keeping.services.FileService;

@RestController
public class FileController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private FileService fileService;

	@GetMapping("/files")
	public ResponseEntity<List<File>> getAll() {
		return ResponseEntity.ok(fileService.getAll());
	}

	@GetMapping("/file/{id}")
	public ResponseEntity<File> getOne(@PathVariable Long id) {
		return ResponseEntity.ok(fileService.getOne(id));
	}

	@PostMapping("/file")
	public void insert(@RequestBody File file) {
		ResponseEntity.ok(fileService.insert(file));
	}

	@PostMapping("/files")
	public ResponseEntity<List<File>> inserts(@RequestBody File file) {
		fileService.insert(file);
		return ResponseEntity.ok(fileService.getAll());
	}

	@PutMapping("/file/{id}")
	public void update(@RequestBody File file, @PathVariable Long id) {
		ResponseEntity.ok(fileService.update(file, id));
	}

	@PutMapping("/files/{id}")
	public ResponseEntity<List<File>> updates(@RequestBody File file, @PathVariable Long id) {
		fileService.update(file, id);
		return ResponseEntity.ok(fileService.getAll());
	}

	@DeleteMapping("/file/{id}")
	public void delete(@PathVariable Long id) {
		fileService.delete(id);
	}

	@DeleteMapping("/files/{id}")
	public ResponseEntity<List<File>> deletes(@PathVariable Long id) {
		fileService.delete(id);
		return ResponseEntity.ok(fileService.getAll());
	}

	// GET FILE BY DEPARTMENT
	@GetMapping("/getFile/{id}")
	public ResponseEntity<List<File>> getFilesFromDepartment(@PathVariable Long id) {
		List<File> files = fileService.getAll();
		List<File> extractedFile = new ArrayList<File>();
		for (File file : files) {
			List<Department> departments = file.getDepartments();
			for (Department depart : departments) {
				if (depart.getId().equals(id)) {
					extractedFile.add(file);
				}
			}
		}
		return ResponseEntity.ok(extractedFile);
	}

}
