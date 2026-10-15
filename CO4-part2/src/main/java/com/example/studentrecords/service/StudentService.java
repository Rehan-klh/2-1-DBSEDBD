package com.example.studentrecords.service;

import com.example.studentrecords.dto.StudentRequest;
import com.example.studentrecords.entity.Student;
import com.example.studentrecords.repository.StudentRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StudentService {

    private final StudentRepository repository;

    public StudentService(StudentRepository repository) {
        this.repository = repository;
    }

    public Student create(StudentRequest request) {
        Student student = new Student();
        apply(student, request);
        return repository.save(student);
    }

    public List<Student> getAll() {
        return repository.findAll();
    }

    public Optional<Student> getById(String id) {
        return repository.findById(id);
    }

    public Optional<Student> update(String id, StudentRequest request) {
        return repository.findById(id).map(student -> {
            apply(student, request);
            return repository.save(student);
        });
    }

    public boolean delete(String id) {
        if (!repository.existsById(id)) {
            return false;
        }

        repository.deleteById(id);
        return true;
    }

    private void apply(Student student, StudentRequest request) {
        student.setName(request.getName());
        student.setAge(request.getAge());
        student.setCourse(request.getCourse());
        student.setEmail(request.getEmail());
    }
}