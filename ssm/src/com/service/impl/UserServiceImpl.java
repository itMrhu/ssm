package com.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mapper.UserMapper;
import com.model.User;
@Service("userService")
public class UserServiceImpl implements com.service.UserService {
	@Autowired
	private UserMapper usermapper;
	@Override
	public int addUser(User user) throws Exception {
		String id=UUID.randomUUID().toString();
		user.setId(id);		
		return usermapper.addUser(user);
	}
	@Override
	public List<User> getUserList(User user,int page,int rows) throws Exception {
		String username=user.getUsername();
        page = (page-1)*rows;
		return usermapper.getUserList(username,page,rows);
	}
	@Override
	public int editUser(User user) throws Exception {
		return usermapper.editUser(user);
	}
	@Override
	public int deleteUser(String[] ids) throws Exception {
		return usermapper.deleteUser(ids);
	}
	@Override
	public List<User> checkUsernamePassword(User user) throws Exception {
		// TODO Auto-generated method stub
		return usermapper.checkUsernamePassword(user);
	}
	@Override
	public int getCount(User user) throws Exception {
		// TODO Auto-generated method stub
		return usermapper.getCount(user);
	}
	@Override
	public List<User> searchUser(User user) throws Exception {
		// TODO Auto-generated method stub
		return usermapper.searchUser(user);
	}

	
}
