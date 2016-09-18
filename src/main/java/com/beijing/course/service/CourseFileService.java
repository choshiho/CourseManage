package com.beijing.course.service;

import java.util.List;

import com.beijing.course.pojo.CourseFile;

public interface CourseFileService {
	public CourseFile getCourseFileById(int id);
	
	public List<CourseFile> getAllCourseFile();
	
	public int addCourseFile(CourseFile courseFile);
	
	public int deleteCourseFile(Integer id);
}
