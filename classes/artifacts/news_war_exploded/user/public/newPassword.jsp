<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html>
 <head>
 	<meta charset="utf-8">
 	<link href="/news2/css/1.css" rel="stylesheet" type="text/css">
 	<script type="text/javascript" src="/news2/plugin/jquery/jquery-3.2.1.min.js"></script>
	<script type="text/javascript">	
		//判断两次密码是否相同
		function passwordSame(){
			var password = $("#password").val();
			var password1 = $("#password1").val();
			
			if(password==password1){	
				$("#password1")[0].setCustomValidity('');				
				return true ;
			}else{
				$("#password1")[0].setCustomValidity('*两次新密码不一样');
				return false;
			}				
		}
		
		$(document).ready(function(){
			$("#submitform").on("submit", function(ev) {
				if( passwordSame()==false){
					ev.preventDefault();//阻止表单提交				
				}else{		
					//符合条件往下执行修改密码操作：
				 	$.ajax({
				        type: 		"post",
				        dataType: 	"json",
				        url: 		'/news2/servlet/UserServlet?type1=newPassword',
				        data: 		$("#submitform").serialize(),
				        success: 	function (data) {
							            if (data != null){
							            	if(data.result==1){
							            		alert(data.message);
							            		window.location.href=data.redirectUrl; //跳转网页
							            	}else
							            		alert(data.message);
							            }else
							            	alert("修改异常！");
							        },
				        error: 		function() { 
								        alert("修改异常！"); 
							        }
				    });	
		            ev.preventDefault();
				}
	        });
		}); 		
	</script>
  </head>
  
  <body>
  	<div class="center" style="width:600px;margin-top:40px">
	 	<form id="submitform">
		  <table width="400" align="center">
		    <tr><td colspan="2" align="center">输入新密码</td></tr>
		    <tr>
		      <td align="right">新密码：</td>
		      <td><input type="password" id="password" name="password" 
		      		pattern="^(\w){6,20}$" title="*只能输入6-20个字母、数字、下划线"  ></td>
		    </tr>	            
		    <tr>
		      <td align="right">重复一遍新密码：</td>
		      <td><input type="password" id="password1" oninput="setCustomValidity('');"/></td>
		    </tr>		    
		    <tr>
		      <td colspan="2" align="center"><input type="submit" value="修改密码"/></td>
	        </tr>	        
		  </table>
		  <input type="hidden" name="rand" id="rand" value="${param.rand}">
	</form>  
	 </div>
  </body>
</html>
