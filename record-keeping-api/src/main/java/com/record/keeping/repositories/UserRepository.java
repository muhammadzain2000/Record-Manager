package com.record.keeping.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.record.keeping.models.User;

@Repository
public interface UserRepository extends JpaRepository<User, String> {

	public User findByEmail(String email);

}
