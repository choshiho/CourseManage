package com.beijing.course.service;

import java.util.List;

import com.beijing.course.pojo.User;

public interface UserService {
	public List<User> getAllUser();
	
	public int modifyPassword(Integer id, String newPassword);
}