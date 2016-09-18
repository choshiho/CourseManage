package com.beijing.course.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.beijing.course.dao.CourseMapper;
import com.beijing.course.pojo.CourseFile;
import com.beijing.course.service.CourseFileService;

@Service
public class CourseFileServiceImpl implements CourseFileService {
	@Resource
	private CourseMapper courseMapper;
	
	@Override
	public CourseFile getCourseFileById(int id) {
		// TODO Auto-generated method stub
		return this.courseMapper.getCourseFileById(id);
	}
	
	@Override
	public List<CourseFile> getAllCourseFile() {
		return this.courseMapper.getAllCourseFile();
	}
	
	@Override
	public int addCourseFile(CourseFile courseFile) {
		return this.courseMapper.addCourseFile(courseFile);
	}
	
	@Override
	public int deleteCourseFile(Integer id) {
		return this.courseMapper.deleteCourseFile(id);
	}
}
