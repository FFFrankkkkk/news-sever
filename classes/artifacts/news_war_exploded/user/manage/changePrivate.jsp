<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
 <head>
 	<meta charset="utf-8"></head>
  <body>
  <form action="/news/servlet/UserServlet?type1=changePrivate2" method="post"  enctype="multipart/form-data"  target="frame">
	<table width="400" border="0" align="center" cellspacing="0" cellpadding="0">
		<tbody>
			<tr><td height="50"></td><td>修改个人信息：</td></tr>		
			<tr><td>头像：</td>	
				<td><img src="${ sessionScope.user.headIconUrl}" height="100"/><input id="myFile" name="myFile" type="file" onchange="preview()">
				<br>预览：<img id="myImage" height="100"/></td></tr>
			<c:if test="${sessionScope.user.type=='user'}" >
				<tr><td height="30">性别：</td>	
					<td><select name="sex" id="sex">
							<option value="男">男</option>
							<option value="女">女</option>
						</select>
					</td></tr>
				<tr><td height="60">爱好：</td>
					<td><textarea name="hobby" value="${requestScope.userinformation.hobby}"></textarea></td>
				</tr> 
			</c:if>	
			<tr><td></td><td><input type="submit" value="提交"/></td></tr>					
		</tbody>
	</table> 
  </form>				   
  </body>
</html>

	 <script language=javascript>
		function preview() {
		 	var preview = document.getElementById("myImage");
		 	var file  = document.getElementById("myFile").files[0];
		 	var reader = new FileReader();
		 	reader.onloadend = function () {
		  		preview.src = reader.result;
		 	}
		 	
			if (file) 
			  	reader.readAsDataURL(file);
			else 
			  	preview.src = "";			
		}
		
		var sex = document.getElementById("sex");
		for (var i = 0; i < sex.options.length; i++) {
            if (sex.options[i].value == "${requestScope.userinformation.sex}") {
                sex.options[i].selected = true;
                break;
            }
        }
	</script> 
