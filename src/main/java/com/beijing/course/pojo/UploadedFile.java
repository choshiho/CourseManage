package com.beijing.course.pojo;
import java.io.Serializable;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

public class UploadedFile implements Serializable {
    private static final long serialVersionUID = 72348L;

    private MultipartFile multipartFile;
    
    private String title;
    
    private String name;
    
    private String desc;
    
    public MultipartFile getMultipartFile() {
        return multipartFile;
    }
    
    public void setMultipartFile(MultipartFile multipartFile) {
        this.multipartFile = multipartFile;
    }
    
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getDesc() {
		return desc;
	}
	
	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
    
}