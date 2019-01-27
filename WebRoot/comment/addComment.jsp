<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!doctype html>
<html>
  <head>
	<link href="/news/css/1.css" rel="stylesheet" type="text/css">
	<meta charset="utf-8">
  </head>
  <body>
    <div class="center" style="width:800px;margin-top:30px;">
	  	<form action="/news/servlet/CommentServlet?type=addCommnet" method="post">
	  		<div class="center" style="width:500px">
				<textarea name="content" cols="72" rows="8" id="textarea" required></textarea>
			</div>
			<p>
			<div class="center" style="width:50px;height:80px;">
				<br>
				<input type="submit" name="submit" id="submit" value="  提 交 1评 论  ">
			</div>		
			<input type="hidden" name="newsId" id="newsId" value="${param.newsId}">
		 	<input type="hidden" name="page" id="page" value="${param.page}">
			<input type="hidden" name="pageSize" id="pageSize" value="${param.pageSize}">
		</form> 
	 </div>   	
  </body>
</html>
