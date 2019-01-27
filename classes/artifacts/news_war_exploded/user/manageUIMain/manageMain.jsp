<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!doctype html>
<html>
 <head>
 	<link href="/news/css/1.css" rel="stylesheet" type="text/css">
 	<meta charset="utf-8"> 
 	<script type="text/javascript"> 
 		function getOnePage(type){
    	  	var url1;
    	  	var page=document.getElementById("page");
    	  	var pageSize=document.getElementById("pageSize");
    	  	var totalPageCount=document.getElementById("totalPageCount");
			
    	  	pageValue=parseInt(page.value);
    	  	if(type=="pre"){
    	  		pageValue-=1;
    	  		page.value=pageValue.toString();
    	  	}else if(type=="next"){
    	  		pageValue+=1;
    	  		page.value=pageValue.toString();
    	  	}
    	  	//提交
    	  	document.getElementById('myform').submit();
      	}
	</script>  
  </head>
  	  <div class="newsShowByType_frame center"  id="frameDiv">
  	  	<div class="newsShowByType_left" id="leftDiv">
  	  		<ul style="list-style-type: none;">
		    	<li><a href="/news/servlet/UserServlet?type1=showPrivate" target='frame'>显示个人信息</a></li>
  				<li><a href="/news/servlet/UserServlet?type1=changePrivate1" target='frame'>修改个人信息</a></li>
  				<li><a href="/news/user/manage/changePassword.jsp" target='frame'>修改密码</a></li>
  				<c:if test="${sessionScope.user.type=='manager'}" >
  					<br>
	 		    	<li><a href="/news/servlet/UserServlet?type1=showPage&page=1&pageSize=2" target='frame'>浏览用户</a></li>
	  				<li><a href="/news/servlet/UserServlet?type1=check&page=1&pageSize=2" target='frame'>审查信息</a></li>
	  				<li><a href="/news/manager/userSearch.jsp" target='frame'>查询用户</a></li>
	  				<li><a href="/news/servlet/UserServlet?type1=delete&page=1&pageSize=2" target='frame'>删除用户</a></li>
	  				<br>
	  				<li><a href="/news/servlet/NewsServlet?type1=manageNews&page=1&pageSize=2" target='frame'>管理新闻</a></li>
	 			</c:if>	
  				<c:if test="${sessionScope.user.type=='newsAuthor'}" >
  					<br>
	 		    	<li><a href="/news/news/manage/addNews.jsp" target='_blank'>添加新闻</a></li>
 					<li><a href="/news/servlet/NewsServlet?type1=manageNews&page=1&pageSize=2" target='frame'>管理新闻</a></li>
	 			</c:if>		 			
  	  		</ul>
		</div>	
		<div class="manageMain_right">
			<iframe name="frame" id="frame" scrolling="no" seamless frameborder="0" width="100%" height="100%">
			</iframe>
		</div>
		<div class="clear"></div>
  	  </div>	
  </body>
  
  <script type="text/javascript">
  	//让父div与子div高度一致（这里因为子div是绝对定位，脱离了文档流，导致父div高度为0了，所以要手动设定父div高度。
  	//否则下面父div后面的兄弟div就会往上移，因为父div的高度为0
  	var father = document.getElementById('frameDiv');
    var son = document.getElementById('leftDiv');
    frameDiv.style.height=leftDiv.offsetHeight+'px';
  </script>
  
</html>
