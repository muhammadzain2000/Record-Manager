package com.record.keeping.services;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.record.keeping.models.Department;
import com.record.keeping.repositories.DepartmentRepository;

@Service
public class DepartmentService {

	private static final Logger logger = LoggerFactory.getLogger(UserService.class);

	@Autowired
	private DepartmentRepository departmentRepository;

	public List<Department> getAll() {
		return departmentRepository.findAll();
	}

	public Department getOne(Long id) {
		return departmentRepository.findById(id).orElse(null);
	}

	public Department insert(Department department) {
		return departmentRepository.save(department);
	}

	public Department update(Department department, Long id) {
		Department existingDepartment = getOne(id);
		if (existingDepartment != null) {
			existingDepartment.setId(department.getId());
			existingDepartment.setName(department.getName());

			return departmentRepository.save(existingDepartment);
		} else {
			return null;
		}

	}

	public void delete(Long id) {
		Department existingDepartment = getOne(id);
		if (existingDepartment != null) {
			departmentRepository.delete(existingDepartment);
		}
	}

}
