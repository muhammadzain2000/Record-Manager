package com.record.keeping.controllers;

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

import com.record.keeping.services.DepartmentService;

@RestController
public class DepartmentController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private DepartmentService departmentService;
	
	@GetMapping("/departments")
	public ResponseEntity<List<Department>> getAll() {
		return ResponseEntity.ok(departmentService.getAll());
	}

	@GetMapping("/department/{id}")
	public ResponseEntity<Department> getOne(@PathVariable Long id) {
		return ResponseEntity.ok(departmentService.getOne(id));
	}
	
	@PostMapping("/department")
	public void insert(@RequestBody Department department) {
		ResponseEntity.ok(departmentService.insert(department));
	}

	@PostMapping("/departments")
	public ResponseEntity<List<Department>> inserts(@RequestBody Department department) {
		departmentService.insert(department);
		return ResponseEntity.ok(departmentService.getAll());
	}
	
	@PutMapping("/department/{id}")
	public void update(@RequestBody Department department, @PathVariable Long id) {
		ResponseEntity.ok(departmentService.update(department, id));
	}

	@PutMapping("/departments/{id}")
	public ResponseEntity<List<Department>> updates(@RequestBody Department department, @PathVariable Long id) {
		departmentService.update(department, id);
		return ResponseEntity.ok(departmentService.getAll());
	}
	
	@DeleteMapping("/department/{id}")
	public void delete(@PathVariable Long id) {
		departmentService.delete(id);
	}

	@DeleteMapping("/departments/{id}")
	public ResponseEntity<List<Department>> deletes(@PathVariable Long id) {
		departmentService.delete(id);
		return ResponseEntity.ok(departmentService.getAll());
	}

}
