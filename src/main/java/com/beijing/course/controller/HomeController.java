package com.beijing.course.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONArray;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.beijing.course.pojo.CourseFile;
import com.beijing.course.pojo.Login;
import com.beijing.course.pojo.UploadedFile;
import com.beijing.course.pojo.User;
import com.beijing.course.service.CourseFileService;
import com.beijing.course.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private String realPath = "E:" + File.separator + "upload";//for Windows
	
//	private String realPath = File.separator + "opt" + File.separator + "upload";//for Linux
	
	private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Autowired
	private CourseFileService courseFileService;
	
	@Autowired
	private UserService userService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value="/login")
	public String toLogin(@ModelAttribute Login login, Model model) {
		return "LoginForm";
	}
	
	@RequestMapping(value="/logout")
	public String logout(@ModelAttribute Login login, HttpServletRequest httpServletRequest, Model model) {
		httpServletRequest.getSession().invalidate();
		return "LoginForm";
	}
	
	@RequestMapping(value="/user_login")
	public String login(@ModelAttribute Login login, HttpSession session, Model model) {
	    model.addAttribute("login", new Login());
	    List<User> userList = userService.getAllUser();
	    for (User user : userList) {
		    if ((user.getName()).equals(login.getUserName()) &&
		            (user.getPassword()).equals(login.getPassword())) {
		        session.setAttribute("loggedIn", Boolean.TRUE);
				//获取课件列表
				List<CourseFile> fileList = courseFileService.getAllCourseFile();
				//设置中文日期
				for (int i = 0; i < fileList.size(); i++) {
					fileList.get(i).setChinaDate(dateFormat.format(fileList.get(i).getStoreTime()));
				}
				model.addAttribute("fileList", fileList);
				model.addAttribute("username", login.getUserName());
				model.addAttribute("role", user.getRole());
//				session.setAttribute("username", login.getUserName());
	            return "Main";
		    }
	    }
	    
    	model.addAttribute("errorMsg", "username or password incorrect");
        return "LoginForm";
	}
	
	@RequestMapping(value="/download")
	public String download(@ModelAttribute Login login, HttpSession session, Model model) {
		//获取课件列表
		List<CourseFile> fileList = courseFileService.getAllCourseFile();
		//设置中文日期
		for (int i = 0; i < fileList.size(); i++) {
			fileList.get(i).setChinaDate(dateFormat.format(fileList.get(i).getStoreTime()));
		}
		model.addAttribute("fileList", fileList);
        return "Download";
	}
	
	@RequestMapping(value="/checkoldpassword")
	@ResponseBody
	public String validateOldPassword(HttpSession session, Model model, @RequestParam String oldpassword, @RequestParam String name) {
		List<User> userList = userService.getAllUser();
		int validateFlag = 0;//0 error, 1 success
		for (User user : userList) {
		    if (name.equals(user.getName())) {
		    	if (oldpassword.equals(user.getPassword())) {
		    		validateFlag = 1;//password match
		    		break;
		    	}
		    }
	    }
		if (validateFlag == 0) {
			return "error";
		}
		else {
			return "success";
		}
	}
	
	@RequestMapping(value="/modifyPassword")
	@ResponseBody
	public String modifyPassword(HttpSession session, Model model, @RequestParam String name, @RequestParam String oldpassword, @RequestParam String newpassword) {
		List<User> userList = userService.getAllUser();
		int modifyFlag = 0;//0 error, 1 success
		for (User user : userList) {
		    if ( name.equals(user.getName()) && oldpassword.equals(user.getPassword()) ) {
		    	modifyFlag = userService.modifyPassword(user.getId(), newpassword);
		    	break;
		    }
	    }
		if (modifyFlag == 0) {
			return "error";
		}
		else {
			return "success";
		}
	}
	
	@RequestMapping("/uploadCourseFile")
	@ResponseBody
	public void uploadCourseFile(HttpServletRequest request, HttpServletResponse response, @RequestParam("file") MultipartFile mf) throws IOException {
		String filename = mf.getOriginalFilename();
		logger.info("fileName = " + filename);
		//文件路径
		String filePath = realPath + File.separator + filename;
		File file = new File(filePath); 
		// 写入本地
		Map map=new HashMap();
		try {
			mf.transferTo(file);
			map.put("result", "上传成功！");
    		map.put("code", 1);
    		map.put("filePath", filePath);
			logger.info("成功");
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "上传失败！");
    		map.put("code", 0);
    		logger.info("失败");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "上传失败！");
    		map.put("code", 0);
    		logger.info("失败");
		}
		 JSONArray json = JSONArray.fromObject(map);
		 try {
			response.getWriter().write(json.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 点击上传课件对话框的取消按钮删除已上传的课件
	 */
	@RequestMapping("/deleteUploadedCourseFile")
	@ResponseBody
	public String deleteUploadedCourseFile(@ModelAttribute Login login, Model model, @RequestParam String fileName) {
		try {
			//delete course file from corresponding directory
			File file = new File(realPath, fileName);
		    // 路径为文件且不为空则进行删除  
		    if (file.isFile() && file.exists()) {  
		        file.delete(); 
		        return "success";
		    } 
	      } catch (Exception e) {
	    	  logger.error("deleteUploadedCourseFile exception:", e);
	      }
		return "error";
	}
	
	@RequestMapping("/submitUploadFileParams")
	@ResponseBody
	public String submitUploadFileParams(HttpServletRequest httpServletRequest, @ModelAttribute UploadedFile uploadedFile, BindingResult bindingResult, Model model) throws Exception {
        String title = uploadedFile.getTitle();
        String fileName = uploadedFile.getName();
        String desc = uploadedFile.getDesc();
        int addFlag = courseFileService.addCourseFile(new CourseFile(title, fileName, desc, new Date(), realPath + File.separator + fileName));
        logger.info("addFlag=" + addFlag);
		if (addFlag == 1) {
			return "success";
		}
		else {
			return "error";
		}
	}
	
/*	@RequestMapping("/uploadCourseFile")
	@ResponseBody
	public String uploadCourseFile(HttpServletRequest httpServletRequest, @ModelAttribute UploadedFile uploadedFile, BindingResult bindingResult, Model model) throws Exception {
        MultipartFile multipartFile = uploadedFile.getMultipartFile();
        String title = uploadedFile.getTitle();
        String desc = uploadedFile.getDesc();
        String fileName = null;
//        String realPath = null;
        if (null != multipartFile && multipartFile.getSize() > 0) {
        	fileName = multipartFile.getOriginalFilename();
        	logger.info("OriginalFileName=" + fileName);
        }
        try {
//            realPath = httpServletRequest.getSession().getServletContext().getRealPath("/WEB-INF/upload"); 
//        	File myFile = new File("C:" + File.separator + "tmp" + File.separator, "test.txt");//C:\tmp\test.txt
        	
            File file = new File(realPath, fileName);
            File parent = file.getParentFile(); 
            if ( parent != null && !parent.exists() ) { 
            	parent.mkdirs(); 
            } 
            multipartFile.transferTo(file);
        } catch (IOException e) {
            e.printStackTrace();
        }
		
        logger.info("realPath = " + realPath);
        int addFlag = courseFileService.addCourseFile(new CourseFile(title, fileName, desc, new Date(), realPath + File.separator + fileName));
        logger.info("addFlag=" + addFlag);
        
		if (addFlag == 1) {
			return "success";
		}
		else {
			return "error";
		}
	}*/
	
	@RequestMapping("/resource_download")
	public String downloadResource(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestParam Integer id) throws UnsupportedEncodingException {
/*        if (session == null || session.getAttribute("loggedIn") == null) {
            return "LoginForm";
        }*/
		CourseFile courseFile = courseFileService.getCourseFileById(id);
		String fileName = courseFile.getName();
//        String dataDirectory = request.getSession().getServletContext().getRealPath("/WEB-INF/upload");
        String dataDirectory = realPath;
        File file = new File(dataDirectory, fileName);
        if (file.exists()) {
            response.setContentType("application/octet-stream");
/*            response.addHeader("Content-Disposition", 
                    "attachment; filename=" + fileName);*/
            response.addHeader("Content-Disposition", 
                    "attachment; filename=" + URLEncoder.encode(fileName, "utf-8"));
            
            byte[] buffer = new byte[1024];
            FileInputStream fis = null;
            BufferedInputStream bis = null;
            // if using Java 7, use try-with-resources
            try {
                fis = new FileInputStream(file);
                bis = new BufferedInputStream(fis);
                OutputStream os = response.getOutputStream();
                int i = bis.read(buffer);
                while (i != -1) {
                    os.write(buffer, 0, i);
                    i = bis.read(buffer);
                }
            } catch (IOException ex) {
                // do something, 
                // probably forward to an Error page
            } finally {
                if (bis != null) {
                    try {
                        bis.close();
                    } catch (IOException e) {
                    }
                }
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e) {
                    }
                }
            }
        }
        return null;
	}
	
	/**
	 * 删除课件
	 */
	@RequestMapping(value = "/deleteCourseFile", method = RequestMethod.GET, produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody List<CourseFile> deleteCourseFile(@ModelAttribute Login login, Model model, @RequestParam Integer id) {
		int delFlag = 0;//1表示删除成功，0表示删除失败
		try {
			//delete course file from corresponding directory
			String fileName = courseFileService.getCourseFileById(id).getName();
			File file = new File(realPath, fileName);
		    // 路径为文件且不为空则进行删除  
		    if (file.isFile() && file.exists()) {  
		        file.delete();  
		    } 
			//delete course file record from mysql
			delFlag = courseFileService.deleteCourseFile(id);
			logger.info("delFlag=" + delFlag);
	      } catch (Exception e) {
	    	  logger.error("deleteCourseFile exception:", e);
	      }
		//获取课件列表
		List<CourseFile> fileList = courseFileService.getAllCourseFile();
		//设置中文日期
		for (int i = 0; i < fileList.size(); i++) {
			fileList.get(i).setChinaDate(dateFormat.format(fileList.get(i).getStoreTime()));
		}
		return fileList;
	}
	
	/**
	 * 获取课件列表
	 */
	@RequestMapping(value = "/getAllCourseFile", method = RequestMethod.GET, produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody List<CourseFile> getAllCourseFile(@ModelAttribute Login login, Model model) {
		//获取课件列表
		List<CourseFile> fileList = courseFileService.getAllCourseFile();
		//设置中文日期
		for (int i = 0; i < fileList.size(); i++) {
			fileList.get(i).setChinaDate(dateFormat.format(fileList.get(i).getStoreTime()));
		}
		logger.info("fileList.size() = " + fileList.size());
		return fileList;
	}
}
