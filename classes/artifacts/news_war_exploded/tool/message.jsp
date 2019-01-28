<%@ page language="java" import="java.util.*,tools.Message" pageEncoding="UTF-8"%>
<%	
	Message message=(Message) request.getAttribute("message");
	response.setHeader("refresh", "3;URL="+message.getRedirectUrl());
%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>消息</title>
  	<script type="text/javascript">
  		var time = 4;
		function returnUrlByTime() {
			<!--每隔1秒调用该函数-->
			window.setTimeout('returnUrlByTime()', 1000);
			<!--时间递减-->
			time = time - 1;
			<!--显示动态时间的层-->
			document.getElementById("layer").innerHTML = time+"秒后将跳转页面。"; 
		}
  	</script>
  </head>
  
  <body onload="returnUrlByTime()">
	<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
		<tbody>
			<tr>
				<td>${requestScope.message.message}</td>
			</tr>
			<tr>
				<td><p id="layer">3秒后将跳转页面。</p>
				如果没有跳转,请按 <a href="${requestScope.message.redirectUrl} ">这里</a>!!!</td>
			</tr>
		</tbody>
	</table>    
  </body>
</html>
