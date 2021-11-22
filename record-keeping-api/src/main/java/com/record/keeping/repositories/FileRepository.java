package com.record.keeping.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.record.keeping.models.File;

@Repository
public interface FileRepository extends JpaRepository<File, Long> {

}
