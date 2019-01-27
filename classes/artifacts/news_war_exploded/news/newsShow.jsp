<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/myTagLib" prefix="myTag"%>
<!doctype html>
<html>
 <head>
 	<meta charset="utf-8"> 
 	<link href="/news2/css/1.css" rel="stylesheet" type="text/css">
 	<script type="text/javascript" src="/news2/plugin/jquery/jquery-3.2.1.min.js"></script>
 	<script type="text/javascript"> 
 		function getOnePage(type,orderFieldName){
		  	var url1;
		  	var page = $("#page");
		  	var pageSize = $("#pageSize");
		  	var totalPageCount = $("#totalPageCount");
		  	
				var order = $("#order");
				var orderField = $("#orderField");
			
			if(orderFieldName != ""){//切换排序
				orderField.val(orderFieldName);//设置排序字段名
				if(order.val() == "asc")//切换排序
					order.val("desc");
				else
					order.val("asc");	
					
				page.val("1");//排序后从第一页开始显示												
			}
			
		  	pageValue = parseInt(page.val());
		  	if(type=="first")
		  		page.val("1");
		  	else if(type=="pre"){
		  		pageValue-=1;
		  		page.val(pageValue.toString());
		  	}else if(type=="next"){
		  		pageValue+=1;
		  		page.val(pageValue.toString());
		  	}else if(type=="last"){
		  		page.val(totalPageCount.val());
		  	}
		  	//提交
		  	var path="/news2/servlet/NewsServlet?type1=showNews";
			$('#myform').attr("action", path).submit();
		}
	</script>  
  </head>
  
  <body>
  	<form action="" id="myform" method="post">
  	 <table align="center" border='1' class="tableDefault">
	    <tr bgcolor='#FFACAC'>
	      <td><a href='javascript:void(0);' onclick="getOnePage('','newsId');">Id</a></td>
	      <td>标题</td><td>作者</td>
	    </tr>	    
	    <c:forEach items="${requestScope.newses}"  var="news">    
	   		<tr>
		   		<td>${news.newsId}</td>
		   		<td><a href="/news2/servlet/NewsServlet?type1=showANews&newsId=${news.newsId}&page=1&pageSize=5">${news.caption}</a></td>	
		   		<td>${news.author}</td>     	
		   	</tr>
		</c:forEach> 	    
	</table>
	 <table align="center" border='1' class="tableDefault">     
	   	<tr>			
			<c:if test="${requestScope.pageInformation.page > 1}">
				<td><a href="javascript:void(0);" onclick="getOnePage('first','');">首页</a></td>  
			</c:if>
			
			<c:if test="${requestScope.pageInformation.page > 1}">
				<td><a href="javascript:void(0);" onclick="getOnePage('pre','');">上一页</a></td>  
			</c:if>			 
			
			<c:if test="${requestScope.pageInformation.page < requestScope.pageInformation.totalPageCount}">
				<td><a href="javascript:void(0);" onclick="getOnePage('next','');">下一页</a></td>
			</c:if>	  			
			<c:if test="${requestScope.pageInformation.page < requestScope.pageInformation.totalPageCount}">
				<td><a href="javascript:void(0);" onclick="getOnePage('last','');">尾页</a></td>
			</c:if>
			<td>第${requestScope.pageInformation.page}页/共${requestScope.pageInformation.totalPageCount}页</td>   		
		</tr>    
	 </table>
	 	<input type="hidden" name="page" id="page" value="${requestScope.pageInformation.page}">
		<input type="hidden" name="pageSize" id="pageSize" value="${requestScope.pageInformation.pageSize}">
	 	<input type="hidden" name="totalPageCount" id="totalPageCount" value="${requestScope.pageInformation.totalPageCount}">
		<input type="hidden" name="allRecordCount" id="allRecordCount" value="${requestScope.pageInformation.allRecordCount}">
	 	<input type="hidden" name="orderField" id="orderField" value="${requestScope.pageInformation.orderField}">
		<input type="hidden" name="order" id="order" value="${requestScope.pageInformation.order}">
	 	<input type="hidden" name="ids" id="ids" value="${requestScope.pageInformation.ids}">
		<input type="hidden" name="searchSql" id="searchSql" value="${requestScope.pageInformation.searchSql}">
	 	<input type="hidden" name="result" id="result" value="${requestScope.pageInformation.result}">
  </form>
  </body>
</html>
