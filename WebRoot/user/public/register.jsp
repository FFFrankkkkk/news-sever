<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<script src="/news/plugin/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	function passwordSame(){
		var password = $("#password").val();
		var password2 = $("#password2").val();
		if(password2==null || password2==""){
			//通过元素对象的setCustomValidity方法，可以自定义元素（标签）的提示信息
			$("#password2")[0].setCustomValidity('*不能为空');
			return false;
		}else if(password2==password){			
			return true ;
		}else{
			$("#password2")[0].setCustomValidity('*两次密码不一样');
			return false;
		}				
	}
	
	$(document).ready(function(){				
		$("#checkImg").on("click", function(){
			$(this).attr("src","/news/servlet/ImageCheckCodeServlet?rand="+Math.random());
		});		
		
		//click事件比submit事件先执行
		$("#submitform").on("click", function(ev) {
			var $name=$("#name");
			if( $name.val().length<8){
				$name[0].setCustomValidity('至少需要8个字符，以字母开头，以字母或数字结尾，可以有-和_');
			}else  if( $password.val().length<6){
				var $password=$("#password");
				$password[0].setCustomValidity('只能输入6-20个字母、数字、下划线');
			}		
		});
		//submit事件比click事件后执行
		$("#submitform").on("submit", function(ev) {
			if( passwordSame()==false){
				ev.preventDefault();//阻止表单提交
				return false;
			}else{		
	            $.ajax({
	 		        type: "post",
			        dataType: "json",
			        url: '/news/servlet/UserServlet?type1=register',
			        data: $("#submitform").serialize(),
			        success: function (data) {
			            if (data != null) {
			            	if(data.result==1){
			            		window.location.href=data.redirectUrl; //跳转网页
			            	}else//登录失败		                
								alert(data.message);
			            }
			        },
			        error: function() { 
				        alert("登录失败!未能连接到服务器!");   
			        }               
	            });
	            ev.preventDefault();
			}
        });
	});   
	
</script>
</head>

<body>

<form id="submitform">
   <div class="center" style="width:600px;margin-top:40px">
	<table  border="0" align="center">
		<tbody>
			<tr height="30">
				<td></td><td>注册</td>
			</tr>
			<tr height="30">
				<td align="right">用户类型：</td>
				<td><select name="type">
						<option value="user">普通用户</option>
						<option value="newsAuthor">新闻发布员</option>
						<option value="manager">管理员</option>
				</select></td>
			</tr>			
			<tr height="30">
				<td  align="right">用户名：</td>
				<td align="left">
					<input type="text" name="name" id="name" pattern="[a-z]([a-z0-9])*[-_]?([a-z0-9]+)" required 
							oninvalid="setCustomValidity('至少需要8个字符，以字母开头，以字母或数字结尾，可以有-和_')" oninput="setCustomValidity('');"></td>
			</tr>
		    <tr>
		      <td align="right">电子邮箱：</td>
		      <td>
		      	<input name="email" type="email" id="email" required  placeholder="电子邮箱" title="电子邮箱" />		       
		      </td>
		    </tr>  			
			<tr height="30">
				<td align="right">密码：</td>
				<td align="left">
					<input type="password" name="password" id="password" required 
							pattern="(\w){6,20}" title="只能输入6-20个字母、数字、下划线" maxlength=20 >
				</td>
			</tr>
			<tr height="30">
				<td align="right">重新输入密码：</td>
				<td align="left">
					<input type="password" name="password2" id="password2" required maxlength=20>
				</td>
			</tr>
		    <tr>
		      <td align="right">图形验证码：</td>
		      <td valign="middle">
		      		<input type="text" name="checkCode" id="checkCode" required  title="不能为空">
		      		<img id="checkImg" onclick="changeCode();"  src="/news/servlet/ImageCheckCodeServlet?rand=-1" class="hand" /></td>
		    </tr>			
			<tr height="30">
				<td></td><td><input  type="submit" value="      注     册     "/></td>
			</tr>
		</tbody>
	</table>
  </div>
  <div>
	表单提交事件顺序如下：<br>
	（1）submit按钮的click事件，若取消默认事件，则终止<br>
	（2）html5表单验证和提示，若表单验证不通过，则提示第一个不合法输入，并终止<br>
	（3）form表单的submit事件，若取消默认事件，则终止  <br>
	  
  </div>
  
</form>
</body>
</html>
