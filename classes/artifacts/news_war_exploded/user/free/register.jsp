<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<link href="/news/css/1.css" rel="stylesheet" type="text/css">
	<script src="/news/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	function valName(){
		var pattern = new RegExp("^[a-z]([a-z0-9])*[-_]?([a-z0-9]+)$","i");//创建模式对象
		var str1=document.getElementById("name").value;//获取文本框的内容
		
		if(str1==null || str1==""){
			document.getElementById("namespan").innerHTML="*不能为空";
			return false;
		}else if(str1.length>=8 && pattern.test(str1)){//pattern.test() 模式如果匹配，会返回true，不匹配返回false
			document.getElementById("namespan").innerHTML="ok";
			return true;
		}else{
			document.getElementById("namespan").innerHTML="*至少需要8个字符，以字母开头，以字母或数字结尾，可以有-和_";
			return false;
		}
	}
	
	function valPassword(){
		var str = document.getElementById("password").value;
		var pattern=/^(\w){6,20}$/;
		
		if(document.getElementById("password").value==null || document.getElementById("password").value==""){
			document.getElementById("passwordspan").innerHTML="*不能为空";
			return false;
		}else if(str.match(pattern)==null){
			document.getElementById("passwordspan").innerHTML="*只能输入6-20个字母、数字、下划线";
			return false;
		}else{
			document.getElementById("passwordspan").innerHTML="ok";
			return true;
		}
	}
	
	function passwordSame(){
		var str = document.getElementById("password").value;
		if(document.getElementById("password2").value==null || document.getElementById("password2").value==""){
			document.getElementById("passwordspan2").innerHTML="*不能为空";
			return false;
		}else if(document.getElementById("password").value==document.getElementById("password2").value){			
			document.getElementById("passwordspan2").innerHTML="ok";
			return true ;
		}else{
			document.getElementById("passwordspan2").innerHTML="*两次密码不一样";
			return false;
		}
				
	}
    function phoneNumbercheck(){
	       var str=document.getElementById("phoneNumber").value;
	       if(str==null||str==""){
               document.getElementById("phoneNumberspan").innerHTML="*请输入手机号";
	           return false;
		   }else{
	           return true;
		   }
		}
    function emailNumbercheck(){
        var str=document.getElementById("emailNumber").value;
        if(str==null||str==""){
            document.getElementById("emailNumberspan").innerHTML="*请输入邮箱账号";
            return false;
        }else{
            return true;
        }
    }
	function submit1(){
		result1=valName();
		result1=valPassword() && result1;
		result1=passwordSame() && result1;
        result1=phoneNumbercheck() && result1;
        result1=emailNumbercheck() && result1;
		if( result1){
            $.ajax({
                url: "http://localhost:8080/news/servlet/UserServlet?type1=register",
                type: "POST",
                //     timeout : 5000,
                data: {
                    "type":$("#type").find("option:selected").val(),
                    "name":$("#name").val(),
                    "password":$("#password").val(),
                    "phoneNumber":$("#phoneNumber").val(),
                    "emailNumber":$("#emailNumber").val()
                },
                dataType:"text",
                //   contentType: "application/json;charset=UTF-8",
                success: function (data) {
                    alert(data)
                    if(data.indexOf("!")==-1)
                    window.location.href="http://localhost:8080/news/user/free/login.jsp";
                },
                error : function(data) {
                    alert("提交失败");
                },
            });
            return false;
		}

	}
</script>
</head>

<body>

<form action="/news/servlet/UserServlet?type1=register" method="post" onsubmit="return submit1()">
   <div class="center" style="width:600px;margin-top:40px">
	<table  border="0" align="center">
		<tbody>
			<tr height="30">
				<td></td><td>注册</td>
			</tr>
			<tr height="30">
				<td align="right">用户类型：</td>
				<td><select id="type">
						<option value="user">普通用户</option>
						<option value="newsAuthor">新闻发布员</option>
						<option value="manager">管理员</option>
				</select></td>
			</tr>			
			<tr height="30">
				<td  align="right">用户名：</td>
				<td align="left"><input type="text" name="name" id="name" onBlur="valName()">
					<br><span id="namespan"  style="color: #E7060A;"></span></td>
			</tr>
			<tr height="30">
				<td align="right">密码：</td>
				<td align="left"><input type="password" name="password" id="password" onBlur="valPassword()">
					<br><span id="passwordspan"  style="color: #E7060A;"></span></td>
			</tr>
			<tr height="30">
				<td align="right">重新输入密码：</td>
				<td align="left"><input type="password" name="password2" id="password2" onBlur="passwordSame()">
					<br><span id="passwordspan2"  style="color: #E7060A;"></span></td>
			</tr>
			<tr height="30">
				<td align="right">手机号码：</td>
				<td align="left"><input type="text" name="phoneNumber" id="phoneNumber" onBlur="phoneNumbercheck()">
					<br><span id="phoneNumberspan"  style="color: #E7060A;"></span></td>
			</tr>
            <tr height="30">
                <td align="right">邮箱账号：</td>
                <td align="left"><input type="text" name="emailNumber" id="emailNumber" onBlur="emailNumbercheck()">
                    <br><span id="emailNumberspan"  style="color: #E7060A;"></span></td>
            </tr>
			<tr height="30">
				<td></td><td><input type="submit" value="      注     册     "  /></td>
			</tr>
		</tbody>
	</table>
  </div>
</form>
</body>
</html>
