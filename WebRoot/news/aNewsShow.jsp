<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="tools.WebProperties" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="/myTagLib" prefix="myTag"%>
<!doctype html>
<html>
  <head>
  	<link href="/news2/css/1.css" rel="stylesheet" type="text/css">	
  </head>
  <body>
	<div class="container"><div class="row"><div class="col">
				${requestScope.news.caption}				
	</div></div></div>	
			  
	<div class="container"><div class="row"><div class="col">
				作者：${requestScope.news.author}&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
				<myTag:LocalDateTimeTag dateTime="${requestScope.news.newsTime}" type="YMDHM"/>				
	</div></div></div>		  

	<div class="container border-top border-bottom"><div class="row"><div class="col">
				${requestScope.news.content}				
	</div></div></div>	
		
	<div class="container">
	  <div class="row">
		<div class="col">
				
				
		</div>	   	   
	 </div>  			
	</div>	
	
	<div class="container">
	  <div class="row">
		<div class="col">
				
				
		</div>	   	   
	 </div>  			
	</div>		  
  	<div class="center" style="width:800px;margin-top:30px;">
		<table width="800" border="0">
			<tbody>
				<tr><td class="newsCaption">${requestScope.news.caption}</td>
				<tr><td align="center" height="50">作者：${requestScope.news.author}&nbsp;	&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
						<myTag:LocalDateTimeTag dateTime="${requestScope.news.newsTime}" type="YMDHM"/></td>
				</tr><tr><td height="30"><hr></td></tr>
				<tr>
					<td>${requestScope.news.content}</td>
				</tr>
				<tr><td height="30"><hr></td></tr>
			</tbody>
		</table>
		<input type="hidden" name="newsId" id="newsId" value="${param.newsId}">
		<input type="hidden" name="pageSize" id="pageSize" value="${param.pageSize}">
	</div>
	<div id="addComment">
		<jsp:include page='/comment/addComment.jsp' flush="true" />
	</div>
	<div id="showComment">
		<jsp:include page='<%="/servlet/CommentServlet?type=showComment"%>' flush="true" >
			<jsp:param name="newsId" value="${requestScope.news.newsId}" />
			<jsp:param name="page" value="${param.page}" />
			<jsp:param name="pageSize" value="${param.pageSize}" />
		</jsp:include>	
	</div>		
  </body>
</html>
