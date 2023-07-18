package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.model.Student;
public interface StudentMapper {
	public int addStudent (Student student) throws Exception;
	public List<Student> getStudentList(@Param("stuname") String stuname,@Param("page") int page,@Param("rows") int rows) throws Exception;
	public int editStudent(Student student) throws Exception;
	public int deleteStudent (@Param("ids") String[] ids) throws Exception;
	public List<Student> checkStudentnamePassword(Student student) throws Exception;
	public int getCount(Student student) throws Exception;
	public List<Student> searchStudent(Student student) throws Exception;
}
