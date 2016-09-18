package com.beijing.course.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.beijing.course.pojo.User;

public interface UserMapper {
	List<User> getAllUser();
	
	int modifyPassword(@Param("id")Integer id, @Param("password")String newPassword);
}
