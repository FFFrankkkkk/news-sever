<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
	<link href="/news/css/1.css" rel="stylesheet" type="text/css">
	<script src="/news2/plugin/jquery/jquery-3.2.1.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#submitButton").click(function() {
			 	$.ajax({
			        type: "post",
			        dataType: "json",
			        url: '/news2/servlet/UserServlet?type1=byEmail',
			        data: $("#myform").serialize(),
			        success: function (data) {
			            if (data != null) {
			            	if(data.result==1){
			            		alert("发送邮件成功，请登录邮箱，点击其中链接，修改密码，然后登录！");
			            		window.location.href=data.redirectUrl; //跳转网页
			            	}else//登录失败		                
								alert(data.message);
			            }else
			            	alert("失败！请继续尝试");
			        },
			        error: function() { 
				       	alert("失败！");
			        }
			    });					
			});
		});
	</script>	
</head>  
  <body>
  	<div id=""  class="center" style="width:600px;margin-top:40pix">
	 	<form id="myform">
		  <table width="400" align="center">
		    <tr><td colspan="2" align="center">找回密码</td></tr>            
		    <tr>
		      <td align="right">电子邮箱：</td>
		      <td><input name="email" type="email"  size="30"/></td>
		    </tr>		    
		    <tr>
		      <td colspan="2" align="center"><input type="button" id="submitButton" value="找回密码"/></td>
	        </tr>	        
		  </table>
		</form>
	</div>  
  </body>
</html>
