package com.controller;

import java.io.File;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import com.model.Student;
import com.service.StudentService;

@Controller
@RequestMapping("/student")
public class StudentController {
	@Autowired
	private StudentService studentService;	
	@RequestMapping("/studentlist")
	public String Studentlist(){
		return "studentsource";
	}
	@RequestMapping("/addStudent")
	@ResponseBody
	public Map<String, Object> addStudent(@RequestBody Student student) throws Exception{
		 Map<String, Object> resmap=new HashMap<String, Object>();
		 
		 List<Student> Studentlist= studentService.searchStudent(student);
		 if(Studentlist.size()>=1){
			 resmap.put("res", "fail");
			 resmap.put("message", "该用户已存在");
			 return resmap;
		 }
		 int res= studentService.addStudent(student);
		 System.out.println(student.getStuname()+"===========");
		 if(res>=1){
			 resmap.put("res", "ok");
			 resmap.put("message", "添加成功");
		 }
		 else{
			 resmap.put("res", "fail");
			 resmap.put("message", "添加失败");
		 }
		 return resmap;
		
	}
	@RequestMapping("/getStudentlist")
	@ResponseBody
	public Map<String, Object> getStudentList(HttpServletRequest request,Student student,int page,int rows) throws Exception{
		 Map<String, Object> resmap=new HashMap<String, Object>();		 
		 System.out.println("==========order"+"=="+page+"==="+rows);
		 List<Student> Studentlist=studentService.getStudentList(student,page,rows);
		 resmap.put("rows", Studentlist);
		 resmap.put("total", studentService.getCount(student));
		return resmap;
	}
	@RequestMapping("/editStudent")
	@ResponseBody
	public Map<String, Object> editStudent(@RequestBody Student Student) throws Exception{
		 Map<String, Object> resmap=new HashMap<String, Object>();
		 List<Student> Studentlist= studentService.searchStudent(Student);
		 if(Studentlist.size()>=1){
			 resmap.put("res", "fail");
			 resmap.put("message", "该用户已存在");
			 return resmap;
		 }
		 int res= studentService.editStudent(Student);
		 System.out.println(Student.getStuname()+"===========");
		 if(res>=1){
			 resmap.put("res", "ok");
			 resmap.put("message", "修改成功");
		 }
		 else{
			 resmap.put("res", "fail");
			 resmap.put("message", "修改失败");
		 }
		 return resmap;
		
	}
	@RequestMapping("/deleteStudent")
	@ResponseBody
	public Map<String, Object> deleteStudent(String [] stulist) throws Exception{
		 Map<String, Object> resmap=new HashMap<String, Object>();
		 int res= studentService.deleteStudent(stulist);
		 System.out.println(stulist.toString()+"===========");
		 if(res>=1){
			 resmap.put("status", "ok");
			 resmap.put("message", "删除成功");
		 }
		 else{
			 resmap.put("status", "fail");
			 resmap.put("message", "删除失败");
		 }
		 return resmap;
		
	}	

	
	@RequestMapping("/uploadStudent")
	@ResponseBody
	public Map<String, Object> uploadStudent(@RequestParam("uploadFile") MultipartFile filename,HttpServletRequest request){
		 Map<String, Object> resmap=new HashMap<String, Object>();
		 String originalFilename=filename.getOriginalFilename();
		 String suffixname=originalFilename.substring(originalFilename.lastIndexOf("."));
		 String path=request.getServletContext().getRealPath("/upload/");
		 File filepath=new File(path);
		 if(!filepath.exists())
			 filepath.mkdirs();
		 String newfilename=System.currentTimeMillis()+suffixname;
		 try {
			filename.transferTo(new File(path+newfilename));			
			 resmap.put("res", "ok");
			 resmap.put("message", "上传成功！");
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			 resmap.put("res", "fail");
			 resmap.put("message", "上传失败！");
			e.printStackTrace();
		} catch (IOException e) {
			 resmap.put("res", "fail");
			 resmap.put("message", "上传失败！");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return resmap;
	}
	

}
