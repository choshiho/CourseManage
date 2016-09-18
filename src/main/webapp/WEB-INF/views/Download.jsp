<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>课件管理界面</title>
<link rel="stylesheet" type="text/css" href="/resources/css/style1.css">
<!-- <link rel="stylesheet" type="text/css" href="/resources/dataTables/font-awesome/dataTables.fontAwesome.css">
<link rel="stylesheet" type="text/css" href="/resources/dataTables/bootstrap/3/dataTables.bootstrap.css">
<script type="text/javascript" src="/resources/dataTables/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="/resources/dataTables/bootstrap/3/dataTables.bootstrap.js"></script> -->
<script type="text/javascript" src="/resources/js/jquery-1.11.0.js"></script>
<script type="text/javascript" src="/resources/js/ajaxfileupload.js"></script>

<style>

</style>

<script type="text/javascript">
 	$(function() {
		//$("#username").val("${username}");
		/* 		alert("${pageContext.session.username}");
				alert('${session.getAttribute("username")}'); */
 		
		$('.tabbox').height($(window).height()-150)
		/*上传文件	弹出*/
		$('.newbuild-button').click(function(){
			$('.new-build-picture').show()
		})
		/*上传文件	关闭*/
		$('#cancel-build,.login_close').click(function(){
			$('.new-build-picture').hide()
		})
		
		/*修改密码	弹出*/
		$('.changeword').click(function(){
			$('.changepass').show()
		})
		/*修改密码	关闭*/
		$('#change-cancel').click(function(){
			$('.changepass').hide()
		})
		
		/*checkbox全部勾选*/
		$("#checkeall").click(function(){
			if(this.checked){
				$('[name=items]:checkbox').prop('checked',true);
			}else{
				 $('[name=items]:checkbox').prop('checked',false);
				}
		})
		
		//0 tourist, 1 administrator, 2 user
/* 		if (parseInt("${role}") == 1) {
			//$('#uploadFile').show();
		}
		else {
			$('#uploadFile').hide();
			$('#logout').hide();
			$('#username').hide();
			$('#changepassword').hide();
		} */
				
		/*退出*/
	/* 	$('#logout').click(function(){
			location.href="login.html";
		}) */	
		/*修改密码校验*/
		updatepassword();
	})

	/*获取文件名*/
	function getfilename(){
		var name=$('#file').val();
		$('#filename').text(name);
	}
	
	function submitFileUpload() {
        var title = $("#title").val();
        var fileName = $("#file").val();
        var desc = $("#desc").val();
        alert(title);
        alert(fileName);
        alert(desc);
        $("#fileUpload").submit();
        /* if (flag) {                   
            $.ajax({
                url:"/modifyPassword",
                data:{name:$("#username").val(), oldpassword:old, newpassword:pass},
                success:function(result) {   
                    if (result == "success") {
                        $("#tip4").show().html("<font color=\"green\" size=\"3\">密码修改成功</font>");
                        $("#oldpassword").val("");
                        $("#password1").val("");
                        $("#password2").val("");
                        $("#tip1").empty();
                        $("#tip2").empty();
                        $("#tip3").empty();
                        $("#tip4").delay(2000).hide(0); 
                        alert("密码修改成功");
                        $('.changepass').hide();
                    }
                    else {
                        $("#tip4").show().html("<font color=\"red\" size=\"3\">密码修改失败请重试</font>");
                    }  
                }
            });
        }
        else {
            $("#tip4").show().html("<font color=\"red\" size=\"3\">请根据提示修改填写信息</font>");
        } */
 	}
 	
	function checkinsert() {
		var addFlag = "${addFlag}";
		if (parseInt(addFlag) == 1) {
			alert("add success");
		}  
		else if(parseInt(addFlag) == 0){
			alert("add failure");
		}
		
	}
 	
	function getAllCourseFile() {
		$.ajax({
			url : "/getAllCourseFile",
			type : "get",
			success : function(objects) {
				//根据不同的表,生成各自表字段的表头
				var thead = "";
				//thead += '<th scope="col"><input name="" type="checkbox" value=""  class="center-checkbox" id="checkeall" /></th><th scope="col">id</th><th scope="col">title</th><th scope="col">name</th><th scope="col">desc</th><th scope="col">store_time</th><th scope="col">store_path</th><th scope="col">操作</th>';
				thead += '<th scope="col">id</th><th scope="col">title</th><th scope="col">name</th><th scope="col">desc</th><th scope="col">store_time</th><th scope="col">store_path</th><th scope="col">操作</th>';
				
				var table = '<table width="100%" cellspacing="0" cellpadding="0" class="center-tab" id="dataList">'
							+"<thead><tr>"
							+thead
							+"</tr></thead>"
							+"<tbody></tbody>"
							+"</table>";
				
				$("#result_div").html(table);
				
				//首先清理之前的表格数据
				var dataBefore = $("#result_div table tbody tr").length;
				if (dataBefore > 0) {
					$('#dataList').dataTable().fnDestroy();
				}
				
				//1,获取上面id为cloneTr的tr元素  
                //var tr = $("<tr><td><input type='checkbox' name='checkbox2' id='checkbox2' /></td><td>${file.id}</td><td>${file.title}</td><td>${file.name}</td><td>${file.desc}</td><td>${file.storeTime}</td><td>${file.storePath}</td><td><a href='javascript:void(0)' onclick=\"deleteCourseFile('${file.id}')\"><font color=blue>删除</font></a></td></tr>");  
				var tr = $("<tr><td>${file.id}</td><td>${file.title}</td><td>${file.name}</td><td>${file.desc}</td><td>${file.storeTime}</td><td>${file.storePath}</td><td><a href='javascript:void(0)' onclick=\"deleteCourseFile('${file.id}')\"><font color=blue>删除</font></a></td></tr>");
				
	             $.each(objects, function(index, item){                              
	                   //克隆tr，每次遍历都可以产生新的tr                              
	                     var clonedTr = tr.clone();  
	                    
	                     //循环遍历cloneTr的每一个td元素，并赋值  
	                     clonedTr.children("td").each(function(inner_index){  
	                            //根据索引为每一个td赋值         
	                                  switch(inner_index){  
/* 		                                   	case(0):   
		                                       $(this).html('<input type="checkbox" name="checkbox2" id="checkbox2" />');  
		                                       break;  */
	                                        case(0):   
	                                           $(this).html(item.id);  
	                                           break;  
	                                        case(1):  
	                                           $(this).html(item.title);  
	                                           break;  
	                                       	case(2):  
	                                           $(this).html(item.name);  
	                                           break;  
	                                       	case(3):  
	                                           $(this).html(item.desc);  
	                                           break;  
	                                       	case(4):  
	                                           $(this).html(item.storeTime);  
	                                           break;  
	                                       	case(5):  
	                                           $(this).html(item.storePath);  
	                                           break; 
	                                       	case(6):  
	                                           $(this).html("<input type='button' class='centersm-rbut' value='下载文件' onclick=\"downloadFile('" + item.name + "')\"/>");  
	                                           break;   
	                                 }//end switch                          
	                  });//end children.each  
	                
	                 //把克隆好的tr追加原来的tr后面  
	                 //clonedTr.insertAfter(tr);  
	                 clonedTr.appendTo("#dataList");
	              });//end $each 
				
			},
			error : function(er) {
				//获取课件列表失败
				alert("获取课件列表失败,请联系系统管理员");
			}
		});
	}
	
 	function ajaxFileUpload()
    {
/*         $("#loading")
        .ajaxStart(function(){
            $(this).show();            
        })
        .ajaxComplete(function(){
            $(this).hide();            
        }); */
        var flag=true;
        //var old=$("#oldpassword").val();
        var titleLength = $("#title").val().length;
        var fileLength = $("#file").val().length;
        var descLength = $("#desc").val().length;
        if (titleLength == 0 || fileLength == 0 || descLength == 0) {
            flag = false;
        }
        if (flag) {
        	$.ajaxFileUpload
            (
                {
                    url:'/uploadCourseFile',
                    data:{title:$("#title").val(), desc:$("#desc").val()},
                    secureuri:false,
                    fileElementId:'file',
                    //dataType: 'json',
                    //type : "post",
                    success: function(result)
                    {                
                    	alert("add success");
                   		$("#title").val("");
                   		$("#file").val("");
                   		$("#desc").val("");
                   		$('#filename').text("");
                   		$('.new-build-picture').hide();
                   		//重新获取课件列表
                   		getAllCourseFile();
                    },
                    error: function(error)
                    {
                        alert(error);
                        alert("add failure");
                    }
                }
            )
        }
        else {
        	alert("上传文件的标题, 文件名称, 描述不能为空，请确认!");
        }
    }

	function updatepassword() {
		$("#oldpassword").blur(function(){
                var oldpassword = $("#oldpassword").val();
                var name = $("#username").val();
                $.ajax({
                    url:"/checkoldpassword",
                    data:{oldpassword:oldpassword, name:name},                 
                    success:function(result){
                    	//alert(result);
                        if(result == "success"){                            
                             $("#tip1").html("<font color=\"green\" size=\"2\">旧密码正确</font>");
                        } 
                        else{                                 
                            $("#tip1").html("<font color=\"red\" size=\"2\">输入密码错误</font>");
                        }
                    }                 
                });
           });
          $("#password1").blur(function(){
              var num=$("#password1").val().length;
              if((num<6) || (num>18)){
                   $("#tip2").html("<font color=\"red\" size=\"2\">请输入6-18位的密码</font>");                
              }
              else{
                  $("#tip2").html("<font color=\"green\" size=\"2\"> </font>");                
              }
          });
          $("#password2").blur(function(){
              var tmp=$("#password1").val();
              var num=$("#password2").val().length;
              if($("#password2").val() != $("#password1").val()){
                  $("#tip3").html("<font color=\"red\" size=\"2\">两次输入密码不匹配</font>");                 
              }
              else{
                  if(num>=6 && num<=18){
                      $("#tip3").html("<font color=\"green\" size=\"2\"> </font>");                    
                  }                 
                  else{
                      $("#tip3").html("<font color=\"red\" size=\"2\">请输入6-18位的密码</font>");                           
                  }                
              }
          });
          $("#btn").click(function(){
              var flag=true;
              var old=$("#oldpassword").val();
              var pass=$("#password1").val();
              var pass2=$("#password2").val();
              var num1=$("#password1").val().length;
              var num2=$("#password2").val().length;
              if(num1!=num2||num1<6||num2<6||num1>18||num2>18||pass!=pass2){
                  flag=false;
              }
              else{
                  flag=true;
              }
              if (flag) {                   
               $.ajax({
                   url:"/modifyPassword",
                   data:{name:$("#username").val(), oldpassword:old, newpassword:pass},
                   success:function(result) {   
                       if (result == "success") {
                           $("#tip4").show().html("<font color=\"green\" size=\"3\">密码修改成功</font>");
                           $("#oldpassword").val("");
                           $("#password1").val("");
                           $("#password2").val("");
                           $("#tip1").empty();
                           $("#tip2").empty();
                           $("#tip3").empty();
                           $("#tip4").delay(2000).hide(0); 
                           alert("密码修改成功");
                           $('.changepass').hide();
                       }
                       else {
                           $("#tip4").show().html("<font color=\"red\" size=\"3\">密码修改失败请重试</font>");
                       }  
                   }
               });
              }
              else {
               $("#tip4").show().html("<font color=\"red\" size=\"3\">请根据提示修改填写信息</font>");
              }
          }); 
	}

	function validateTitle() {
		return true;
	}
	
    function delcfm() {
        if (!confirm("确认要删除？")) {
            return false;
        }
        return true;
    }
	
	//删除课件
  	function deleteCourseFile(id) {
	    //confirm whether delete course file
	    if (!delcfm()) {
	    	return false;
	    }
	    console.log("id=" + id);
		$.ajax({
			url : "/deleteCourseFile?id=" + id,
			type : "get",
			success : function(objects) {
				//根据不同的表,生成各自表字段的表头
				var thead = "";
				//thead += '<th scope="col"><input name="" type="checkbox" value=""  class="center-checkbox" id="checkeall" /></th><th scope="col">id</th><th scope="col">title</th><th scope="col">name</th><th scope="col">desc</th><th scope="col">store_time</th><th scope="col">store_path</th><th scope="col">操作</th>';
				thead += '<th scope="col">id</th><th scope="col">title</th><th scope="col">name</th><th scope="col">desc</th><th scope="col">store_time</th><th scope="col">store_path</th><th scope="col">操作</th>';
				
				var table = '<table width="100%" cellspacing="0" cellpadding="0" class="center-tab" id="dataList">'
							+"<thead><tr>"
							+thead
							+"</tr></thead>"
							+"<tbody></tbody>"
							+"</table>";
				
				$("#result_div").html(table);
				
				//首先清理之前的表格数据
				var dataBefore = $("#result_div table tbody tr").length;
				if (dataBefore > 0) {
					$('#dataList').dataTable().fnDestroy();
				}
				
				//1,获取上面id为cloneTr的tr元素  
                //var tr = $("<tr><td><input type='checkbox' name='checkbox2' id='checkbox2' /></td><td>${file.id}</td><td>${file.title}</td><td>${file.name}</td><td>${file.desc}</td><td>${file.storeTime}</td><td>${file.storePath}</td><td><a href='javascript:void(0)' onclick=\"deleteCourseFile('${file.id}')\"><font color=blue>删除</font></a></td></tr>");  
                var tr = $("<tr><td>${file.id}</td><td>${file.title}</td><td>${file.name}</td><td>${file.desc}</td><td>${file.storeTime}</td><td>${file.storePath}</td><td><a href='javascript:void(0)' onclick=\"deleteCourseFile('${file.id}')\"><font color=blue>删除</font></a></td></tr>");

	             $.each(objects, function(index, item){                              
	                   //克隆tr，每次遍历都可以产生新的tr                              
	                     var clonedTr = tr.clone();  
	                    
	                     //循环遍历cloneTr的每一个td元素，并赋值  
	                     clonedTr.children("td").each(function(inner_index){  
	                            //根据索引为每一个td赋值         
	                                  switch(inner_index){  
/* 		                                   	case(0):   
		                                       $(this).html('<input type="checkbox" name="checkbox2" id="checkbox2" />');  
		                                       break;  */
	                                        case(0):   
	                                           $(this).html(item.id);  
	                                           break;  
	                                        case(1):  
	                                           $(this).html(item.title);  
	                                           break;  
	                                       	case(2):  
	                                           $(this).html(item.name);  
	                                           break;  
	                                       	case(3):  
	                                           $(this).html(item.desc);  
	                                           break;  
	                                       	case(4):  
	                                           $(this).html(item.storeTime);  
	                                           break;  
	                                       	case(5):  
	                                           $(this).html(item.storePath);  
	                                           break; 
	                                       	case(6):  
	                                           $(this).html("<input type='button' class='centersm-rbut' value='下载文件' onclick=\"downloadFile('" + item.name + "')\"/>");  
	                                           break;   
	                                 }//end switch                          
	                  });//end children.each  
	                
	                 //把克隆好的tr追加原来的tr后面  
	                 //clonedTr.insertAfter(tr);  
	                 clonedTr.appendTo("#dataList");
	              });//end $each 
				
			},
			error : function(er) {
				//DNS主机删除失败
			}
		});
	}
	
	function downloadConfirm() {
	    if (!confirm("确认要下载该文件吗？")) {
	        return false;
	    }
	    else {
	    	return true;
	    }
	}
	  
	function downloadFile(id) {
	  	if (downloadConfirm() == false) {//cancel
	  		return false;
	  	}
/* 	   	var selectedData = [];
	   	var fileName;
	    var tb = document.getElementById("dataList");
	    var row;
	    var cell;
	    var chk;
	    for (var i = 1; i < tb.rows.length; i++) {
	        row = tb.rows[i];//迭代当前行
	        cell = row.cells[0];//复选框所在的单元格
	        chk = cell.getElementsByTagName("input")[0];//为单元格中第1个INPUT元素
	        if (chk.checked) {//如果选中
	            //alert(tb.rows[i].cells[1].innerHTML);
	            selectedData.push(tb.rows[i].cells[1].innerHTML);     //将选中的id值放到数组中 
	            fileName = tb.rows[i].cells[3].innerHTML;
	        }
	    }
	    if (selectedData.length == 0) {
	    	alert('未选取要下载的文件');
	    	return false;
	    }
	    else if (selectedData.length > 1) {
	    	alert('只能选择一个文件');
	    	return false;
	    } */
		
	    window.location.href="/resource_download?id=" + id;
  	}
	
	function logout() {
        if (!confirm("确认要退出？")) {
            return false;
        }
		window.location.href="/logout";
	}
	
</script>
</head>

<body onload="checkinsert()">
<div class="bigbox">
    <div class="center-tit">
    	<div class="text-tit">实体渠道课件发布平台V0.01 </div>
<!--         <input id="logout" name="" type="button" class="text-rbut" id="logout" value="退出" onclick="logout()"/>
        <input id="username" name="" type="button" class="text-rbut" value="用户名" />
        <input id="changepassword" name="" type="button" class="text-rbut changeword" value="修改密码" onclick=""/> -->
    </div>
    <div class="center-smbox">
        <div class="centersm-tit">
            <!-- <input id="uploadFile" type="button" class="centersm-r-but newbuild-button" value="上传文件" style="display:none;"/> -->
            <!-- <input name="" type="button" class="centersm-rbut" value="下载文件" onclick="downloadFile()"/> -->
           
            <!-- <a href="javascript:void(0)" class="centersm-rbut" onclick="downloadFile()">下载文件</a> -->
            <!-- <a href="resource_download?fileName=me.txt" class="centersm-rbut">下载文件</a> -->
        </div>
        <div class="tabbox" id="result_div">
            <table width="100%"  cellspacing="0" cellpadding="0" class="center-tab" id="dataList">

<!--               <tr>
                <td><input name="items" type="checkbox" value="" /></td>
                <td>蒙牛</td>
                <td>蒙牛1234有限公司</td>
                <td>张三</td>
                <td>zhangsan@163.com</td>
                <td><a href="">编辑</a><a href="">产品</a></td>
              </tr> -->
              
              <thead>
	              <tr>
	                <!-- <th scope="col"><input name="" type="checkbox" value=""  class="center-checkbox" id="checkeall" /></th> -->
	                <th scope="col">id</th>
	                <th scope="col">标题</th>
	                <th scope="col">名称</th>
	                <th scope="col">描述</th>
	                <th scope="col">存储时间</th>
	                <!-- <th scope="col">store_path</th> -->
	                <th scope="col">操作</th>
	              </tr>
			  </thead>
				<tbody>
					<c:forEach var="file" items="${fileList}">
					  <tr>
					    <!-- <td><input type="checkbox" name="checkbox2" id="checkbox2" /></td> -->
				        <td>${file.id}</td>
				        <td>${file.title}</td>
				        <td>${file.name}</td>
				        <td>${file.desc}</td>
				        <td>${file.chinaDate}</td>
				        <%-- <td>${file.storePath}</td> --%>
			        	<td>
			        		<input type="button" class="centersm-rbut" value="下载文件" onclick="downloadFile('${file.id}')"/>
			        	</td>
				      </tr>
					</c:forEach>
				</tbody>
            </table>
    	</div>
        
    </div>
</div>
<form:form id="fileUpload" action="/uploadCourseFile" method="post" modelAttribute="" enctype="multipart/form-data" target="uploadframe">
	<div class="login-box420a new-build-picture" style='display: none'>
		<div class="login_head">
	      <h4 class="loginin-title">文件上传</h4>
	    </div>
	    <div class="login_body">
	        <div class="center-text-word01">
	            <div class="center-textword">标题：</div>
	            <div class="center-textselect">
	            	<input name="title" id="title" type="text" class="" onblur="validateTitle()" />
	            </div>
	        </div>
	        <div class="center-text-word01">
	            <div class="center-textword">文件上传：</div>
	            <div class="center-textselect file" >选择文件<input type="file" id="file" name="file" class="" value="" onchange="getfilename()"/> </div>                       
	        </div>
	        <div id="filename"></div>
	        <div class="center-text-word01">
	            <div class="center-textword">描述：</div>
	            <div class="center-textselect">
	                <textarea id="desc" name="desc" cols="" rows="" class="login-textarea"></textarea>
	            </div>
	        </div>            
	    </div>
	    <div class="loginin-footer">
	      <button type="button" class="login_btn_l" id='cancel-build' data-dismiss="modal">取消</button>
	      <button type="button" class="login_btn_r" data-dismiss="modal" onclick="ajaxFileUpload()">保存</button>
	      
    	  <!-- <input id="reset" type="reset" tabindex="4"> -->
	      <!-- <input id="submit" type="submit" class="login_btn_r" data-dismiss="modal" value="保存"> -->
	    </div>
	</div>
</form:form>
<iframe id="uploadframe" name="result_frame" style="visibility:hidden;"></iframe>

<div class="login-box420b changepass" style='display: none'>
    <div class="login_head">
      <h4 class="loginin-title" id="myModalLabel">修改密码</h4>
    </div>
    <div class="login_body_auto">
    <form id="chatform">
        <div class="center-text-word">
            <div class="login_nameword">旧密码：</div>
            <div class="center-textselect ">
                <input name=""  type="password" class="center-textinput center-textinput160" id="oldpassword" placeholder="请输入旧密码"  /><div style="display: inline" id="tip1"></div>
            </div>
        </div>
        <div class="center-text-word">
            <div class="login_nameword">新密码：</div>
            <div class="center-textselect ">
                <input name=""  type="password" class="center-textinput center-textinput160" id="password1"  placeholder="请输入新密码"   /><div style="display: inline" id="tip2"></div>
            </div>
        </div> 
        <div class="center-text-word">
            <div class="login_nameword">再次输入密码：</div>
            <div class="center-textselect ">
                <input name=""  type="password" class="center-textinput center-textinput160" id="password2"  placeholder="请再次输入新密码"   /><div style="display: inline" id="tip3"></div>
            </div>
        </div>        
        <div class="loginin-footer">
            <button type="button" class="login_btn_l" id='change-cancel' data-dismiss="modal">取消</button>
            <button type="button" class="login_btn_r" id="btn" data-dismiss="modal">保存</button>
        </div>
        <div style="display:inline" id="tip4"></div>
        </form>  
    </div>
</div>

</body>
</html>

