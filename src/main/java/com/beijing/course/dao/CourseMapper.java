package com.beijing.course.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.beijing.course.pojo.CourseFile;

//@Repository(value="courseMapper")
public interface CourseMapper {
//    int insert(CourseFile courseFile);

//    int insertSelective(CourseFile courseFile);
	
	  CourseFile getCourseFileById(int id);
	  
	  List<CourseFile> getAllCourseFile();
	  
	  int addCourseFile(CourseFile courseFile);
	  
	  int deleteCourseFile(Integer id);
}