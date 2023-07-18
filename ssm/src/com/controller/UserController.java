package com.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.model.User;
import com.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	@RequestMapping("/main")
	public String main(){
		return "main";
	}
	@RequestMapping("/userlist")
	public String userlist(){
		return "userlist";
	}
	@RequestMapping("/addUser")
	@ResponseBody
	public Map<String, Object> addUser(@RequestBody User user) throws Exception{
		 Map<String, Object> resmap=new HashMap<String, Object>();
		 
		 List<User> userlist= userService.searchUser(user);
		 if(userlist.size()>=1){
			 resmap.put("res", "fail");
			 resmap.put("message", "该用户已存在");
			 return resmap;
		 }
		 int res= userService.addUser(user);
		 System.out.println(user.getUsername()+"===========");
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
	@RequestMapping("/getUserlist")
	@ResponseBody
	public Map<String, Object> getUserList(HttpServletRequest request,User user,int page,int rows) throws Exception{
		 Map<String, Object> resmap=new HashMap<String, Object>();		 
		 System.out.println("==========order"+"=="+page+"==="+rows);
		 List<User> userlist=userService.getUserList(user,page,rows);
		 resmap.put("rows", userlist);
		 resmap.put("total", userService.getCount(user));
		return resmap;
	}
	@RequestMapping("/editUser")
	@ResponseBody
	public Map<String, Object> editUser(@RequestBody User user) throws Exception{
		 Map<String, Object> resmap=new HashMap<String, Object>();
		 List<User> userlist= userService.searchUser(user);
		 if(userlist.size()>=1){
			 resmap.put("res", "fail");
			 resmap.put("message", "该用户已存在");
			 return resmap;
		 }
		 int res= userService.editUser(user);
		 System.out.println(user.getUsername()+"===========");
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
	@RequestMapping("/deleteUser")
	@ResponseBody
	public Map<String, Object> deleteUser(String [] userlist) throws Exception{
		 Map<String, Object> resmap=new HashMap<String, Object>();
		 int res= userService.deleteUser(userlist);
		 System.out.println(userlist.toString()+"===========");
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
	
	@RequestMapping("/logindo")
	@ResponseBody
	public Map<String, Object> logindo(@RequestBody User user,HttpSession session) throws Exception{
		 Map<String, Object> resmap=new HashMap<String, Object>();
		 List<User> userlist= userService.checkUsernamePassword(user);
		 if(userlist.size()>=1){
			 session.setAttribute("currentUser", user);
			 session.setMaxInactiveInterval(1800);
			 resmap.put("res", "1");
		 }else{
			 resmap.put("res", "0");
		 }
		 System.out.println(user.getUsername()+"===========");
		 return resmap;
		
	}
	
	@RequestMapping("/logout")
	public Map<String, Object> logout(HttpSession session){
		 Map<String, Object> resmap=new HashMap<String, Object>();
		 if(session!=null)
			 session.invalidate();
		 resmap.put("result", "1");		 
		 return resmap;
	}
	
	@RequestMapping("/uploadUser")
	@ResponseBody
	public Map<String, Object> uploadUser(@RequestParam("uploadFile") MultipartFile filename,HttpServletRequest request){
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
