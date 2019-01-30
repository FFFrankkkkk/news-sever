<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
 <head><meta charset="utf-8">
 	<link href="/news/css/1.css" rel="stylesheet" type="text/css">
 	<script type="text/javascript" src="/news/plugin/jquery/jquery-3.2.1.min.js"></script>
 	<script type="text/javascript">
 		$(document).ready(function(){
			$("#myform").on("submit",function(ev) {
				var formdata = new FormData($("#myform")[0]);
			 	$.ajax({
			        type: "post",
			        dataType: "json",
			        url: '/news/servlet/UserServlet?type1=batchAdd',
			        data: formdata,
			        cache: false,
			        async: false,
			        processData : false,
			        contentType : false,
			        success: function (data) {
			            if (data != null) 
			            	if(data.result==1){
			            		$("#rightDiv").html(data.message+"<a href='"+data.redirectUrl+"'>初始密码文件</a>");
			            	
			            	}else			            
			            		$("#rightDiv").html(data.message);  
			            else
			            	$("#rightDiv").html("异常！"); 
			        },
			        error: function() { 
				        $("#rightDiv").html("异常！"); 
			        }
			    });
			    ev.preventDefault();//阻止表单提交
			});	
		});	
 	</script>
  </head>
  
  <body>
  	文件格式为: 文件格式为: 第一列是用户名称（要求符合本系统注册时的用户名要求，且不能有重复）,第一行就是数据<br><br>
  	<form action="" id="myform" method="post">
  	 <table align="center" class="tableDefault"  style="width:500px;">		     
        <tr>
            <td>excel文件上传:</td>
            <td><input id="myFile" name="myFile" type="file" accept="application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
        		<input type="submit" value="提交"/></td>
        </tr>  
	 </table>
   </form>
  </body>
</html>
