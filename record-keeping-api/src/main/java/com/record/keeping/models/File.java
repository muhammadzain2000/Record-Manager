package com.record.keeping.models;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Table(name = "files")
public class File {

	@Id
	private Long id;

	private String subject;
	private String name;
	private String date;

	@Lob
	private String fileBytes;

	@ManyToMany
	@JoinTable(name = "department_file")
	List<Department> departments = new ArrayList<Department>();

//	@ManyToOne
//	@JoinColumn(name = "creater_id")
//	private User creater;

	public File() {
		super();
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

//	public User getCreater() {
//		return creater;
//	}
//
//	public void setCreater(User creater) {
//		this.creater = creater;
//	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getFileBytes() {
		return fileBytes;
	}

	public void setFileBytes(String fileBytes) {
		this.fileBytes = fileBytes;
	}

	public List<Department> getDepartments() {
		return departments;
	}

	public void setDepartments(List<Department> departments) {
		this.departments = departments;
	}

}
