<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="/resources/css/style1.css">
<script type="text/javascript" src="/resources/js/jquery-1.11.0.js"></script>
<title>登录</title>
<script type="text/javascript">
	function checkinsert() {
		var addFlag = "${addFlag}";
		if (parseInt(addFlag) == 1) {
			alert("add success");
		}  
		else if(parseInt(addFlag) == 0){
			alert("add failure");
		}
		
	}
	
/* 	$(function() {
	    $('#errorMsg').empty();
	  }); */
</script>
</head>

<body>    
<div class="lloginbg">
    <div class="login_head">
      <h4 class="loginin-title" id="myModalLabel">登录</h4>
    </div>
    <div class="login_body_auto">
	    <form:form id="chatform" commandName="login" action="user_login" method="post">
	    	<center id="errorMsg" style="color:red">${errorMsg}</center> 
	        <div class="center-text-word">
	            <div class="login_nameword">用户名：</div>
	            <div class="center-textselect ">
	                <!-- <input name="" type="text" class="center-textinput center-textinput160" id="author" placeholder="请输入用户名"  /> -->
	                <form:input class="center-textinput center-textinput160" placeholder="请输入用户名" id="userName" path="userName" cssErrorClass="error"/>
	            </div>
	        </div>
	        <div class="center-text-word">
	            <div class="login_nameword">密&nbsp;码：</div>
	            <div class="center-textselect ">
	                <!-- <input name="" type="password" class="center-textinput center-textinput160" id="password"  placeholder="******"   /> -->
	                <form:password class="center-textinput center-textinput160" placeholder="******" id="password" path="password" cssErrorClass="error"/>
	            </div>
	        </div>        
	        <!-- <input name="" type="button" id="login-but" class="llogin-but" value="登录">  -->
            <input type="submit" class="llogin-but" value="登录"> 
                
	    </form:form>  
    </div>
</div>
<script>
	$("#login-but").click(function(){
		
		var url="";	
		var name=$("#author").val();	
		var pwd=$("#password").val();	
		
		$.ajax({
			url: url,
			dataType: "json",
			data: {author:name,password:pwd},
			type: "POST",
			success: function (response) {
			//这里是请求成功之后做的事情
			if(response.rows==xxxx){
			alert("登录信息正确");
			localtion.href=""
			}
			else{
			alert("登录信息错误");
			}
			},
			error:function (response) {
				alert("登录超时")
				}
			});					
						  })
</script>
    
</body>

</html>