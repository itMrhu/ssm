package com.service;

import java.util.List;

import com.model.User;

public interface UserService {
	public int addUser(User user) throws Exception;
	public List<User> getUserList(User user,int page,int rows) throws Exception;
	public int editUser(User user) throws Exception;
	public int deleteUser(String[] ids) throws Exception;
	public List<User> checkUsernamePassword(User user) throws Exception;
	public int getCount(User user) throws Exception;
	public List<User> searchUser(User user) throws Exception;
	
	
}
