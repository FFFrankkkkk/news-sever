<%@ page language="java" import="java.util.*,tools.Message" pageEncoding="UTF-8"%>
<%	
	Message message=(Message) request.getAttribute("message");
	response.setHeader("refresh", message.getRedirectTime()+";URL="+message.getRedirectUrl());
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<!doctype html>
<html>
 <head>
 	<link href="/news/css/1.css" rel="stylesheet" type="text/css">
 	<meta charset="utf-8"></head>  
  <body>
	  <div class="center" style="width:300px;">
		<table width="300" border="0" align="center" style="margin:50px;">
			<tbody>
				<tr><td>${requestScope.message.message}  </td>
				</tr>
				<tr><td>
					<c:if test="${requestScope.message.redirectTime < 10}">
						${requestScope.message.redirectTime}秒后将跳转页面。<br>
						如果没有跳转,请按 <a href="${requestScope.message.redirectUrl} ">这里</a>!!!
					</c:if>				
					<c:if test="${requestScope.message.redirectTime >= 10}">
						<a href="javascript:void(0);" onclick="history.go(-1);">返回上一步</a>
					</c:if>	
						&nbsp;&nbsp;<a href="javascript:self.close()" >关闭窗口</a>
				</td></tr>
			</tbody>
		</table>
	  </div>	    
  </body>
</html>
