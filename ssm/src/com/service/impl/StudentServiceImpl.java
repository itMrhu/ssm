package com.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapper.StudentMapper;
import com.model.Student;
import com.service.StudentService;
@Service("studentService")
public class StudentServiceImpl implements StudentService {

	@Autowired
	private StudentMapper studentmapper;
	@Override
	public int addStudent(Student student) throws Exception {
		String id=UUID.randomUUID().toString();
		student.setId(id);		
		return studentmapper.addStudent(student);
	}
	@Override
	public List<Student> getStudentList(Student student,int page,int rows) throws Exception {
		String stuname=student.getStuname();
        page = (page-1)*rows;
		return studentmapper.getStudentList(stuname,page,rows);
	}
	@Override
	public int editStudent(Student student) throws Exception {
		return studentmapper.editStudent(student);
	}
	@Override
	public int deleteStudent(String[] ids) throws Exception {
		return studentmapper.deleteStudent(ids);
	}
	@Override
	public List<Student> checkStudentnamePassword(Student student) throws Exception {
		// TODO Auto-generated method stub
		return studentmapper.checkStudentnamePassword(student);
	}
	@Override
	public int getCount(Student student) throws Exception {
		// TODO Auto-generated method stub
		return studentmapper.getCount(student);
	}
	@Override
	public List<Student> searchStudent(Student student) throws Exception {
		// TODO Auto-generated method stub
		return studentmapper.searchStudent(student);
	}

}
