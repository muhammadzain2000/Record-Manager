package com.record.keeping.services;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.record.keeping.models.User;
import com.record.keeping.repositories.UserRepository;

@Service
public class UserService {

	private static final Logger logger = LoggerFactory.getLogger(UserService.class);

	@Autowired
	private UserRepository userRepository;

	public List<User> getAll() {
		return userRepository.findAll();
	}

	public User getOne(String id) {
		return userRepository.findById(id).orElse(null);
	}

	public User insert(User user) {
		return userRepository.save(user);
	}

	public User update(User user, String id) {
		User existingUser = getOne(id);
		if (existingUser != null) {
			existingUser.setId(user.getId());
			existingUser.setName(user.getName());
			existingUser.setEmail(user.getEmail());
			existingUser.setPassword(user.getPassword());
			existingUser.setDepartment(user.getDepartment());
			return userRepository.save(existingUser);
		} else {
			return null;
		}

	}

	public void delete(String id) {
		User existingUser = getOne(id);
		if (existingUser != null) {
			userRepository.delete(existingUser);
		}
	}

}
