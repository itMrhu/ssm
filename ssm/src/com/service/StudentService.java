package com.service;

import java.util.List;


import com.model.Student;


public interface StudentService {
	public int addStudent(Student student) throws Exception;
	public List<Student> getStudentList(Student student,int page,int rows) throws Exception;
	public int editStudent(Student student) throws Exception;
	public int deleteStudent(String[] ids) throws Exception;
	public List<Student> checkStudentnamePassword(Student student) throws Exception;
	public int getCount(Student student) throws Exception;
	public List<Student> searchStudent(Student student) throws Exception;
}
