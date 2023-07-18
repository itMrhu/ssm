package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.model.User;

public interface UserMapper {
	public int addUser (User user) throws Exception;
	public List<User> getUserList(@Param("username") String username,@Param("page") int page,@Param("rows") int rows) throws Exception;
	public int editUser(User user) throws Exception;
	public int deleteUser (@Param("ids") String[] ids) throws Exception;
	public List<User> checkUsernamePassword(User user) throws Exception;
	public int getCount(User user) throws Exception;
	public List<User> searchUser(User user) throws Exception;

}
