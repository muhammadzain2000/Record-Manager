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

import com.record.keeping.models.User;
import com.record.keeping.repositories.UserRepository;
import com.record.keeping.services.UserService;

@RestController
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userService;

	@Autowired
	private UserRepository userRepository;

	@GetMapping("/users")
	public ResponseEntity<List<User>> getAll() {
		return ResponseEntity.ok(userService.getAll());
	}

	@GetMapping("/user/{id}")
	public ResponseEntity<User> getOne(@PathVariable String id) {
		return ResponseEntity.ok(userService.getOne(id));
	}

	@GetMapping("/login/{email}")
	public User Login(@PathVariable String email) {
		return userRepository.findByEmail(email);
	}

	@PostMapping("/user")
	public void insert(@RequestBody User user) {
		ResponseEntity.ok(userService.insert(user));
	}

	@PostMapping("/users")
	public ResponseEntity<List<User>> inserts(@RequestBody User user) {
		userService.insert(user);
		return ResponseEntity.ok(userService.getAll());
	}

	@PutMapping("/user/{id}")
	public void update(@RequestBody User user, @PathVariable String id) {
		ResponseEntity.ok(userService.update(user, id));
	}

	@PutMapping("/users/{id}")
	public ResponseEntity<List<User>> updates(@RequestBody User user, @PathVariable String id) {
		userService.update(user, id);
		return ResponseEntity.ok(userService.getAll());
	}

	@DeleteMapping("/user/{id}")
	public void delete(@PathVariable String id) {
		userService.delete(id);
	}

	@DeleteMapping("/users/{id}")
	public ResponseEntity<List<User>> deletes(@PathVariable String id) {
		userService.delete(id);
		return ResponseEntity.ok(userService.getAll());
	}

}
