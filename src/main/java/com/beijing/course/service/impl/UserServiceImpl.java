package com.beijing.course.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.beijing.course.dao.UserMapper;
import com.beijing.course.pojo.User;
import com.beijing.course.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	@Resource
	private UserMapper userMapper;

	@Override
	public List<User> getAllUser() {
		// TODO Auto-generated method stub
		return this.userMapper.getAllUser();
	}

	@Override
	public int modifyPassword(Integer id, String newPassword) {
		// TODO Auto-generated method stub
		return this.userMapper.modifyPassword(id, newPassword);
	}
	
	

}
