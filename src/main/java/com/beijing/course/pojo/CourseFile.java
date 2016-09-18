package com.beijing.course.pojo;

import java.util.Date;

public class CourseFile {
    private Integer id;

    private String title;

    private String name;

    private String desc;

    private Date storeTime;

    private String storePath;
    
    private String chinaDate;

	public String getChinaDate() {
		return chinaDate;
	}

	public void setChinaDate(String chinaDate) {
		this.chinaDate = chinaDate;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public Date getStoreTime() {
		return storeTime;
	}

	public void setStoreTime(Date storeTime) {
		this.storeTime = storeTime;
	}

	public String getStorePath() {
		return storePath;
	}

	public void setStorePath(String storePath) {
		this.storePath = storePath;
	}

	public CourseFile() {
		super();
	}

	public CourseFile(String title, String name, String desc, Date storeTime, String storePath) {
		super();
		this.title = title;
		this.name = name;
		this.desc = desc;
		this.storeTime = storeTime;
		this.storePath = storePath;
	}
    
}