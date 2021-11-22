package com.record.keeping.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.record.keeping.models.Department;

@Repository
public interface DepartmentRepository extends JpaRepository<Department, Long> {

}
