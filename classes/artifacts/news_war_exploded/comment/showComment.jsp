<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/myTagLib" prefix="myTag"%>
<!doctype html>
<html>
 <head>
 	<meta charset="utf-8">
  	<link href="/news/css/1.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">

      function getOnePage(type){
    	  	var pages=document.getElementsByClassName("page");
    	  	var page=pages[0];
		
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
      	
      	function praise(commentId,newsId){
      		document.getElementById('myform').action="/news/servlet/CommentServlet?type=praise&"
      			+"&commentId="+commentId+"&newsId="+newsId;
      		document.getElementById('myform').submit();
      	}
      	
      	function model(commentId){
      		document.getElementById('myModel').innerHTML=
      			"<form action='/news/servlet/CommentServlet?type=addCommnet' method='post'> \
      				<div class='modelContent'>  \
	      				<table><tbody><tr><td colspan='2'> \
									<textarea name='content' cols='60' rows='8' id='textarea' required></textarea></td>\
								</tr><tr>\
								<td align='center'><input type='submit' name='submit' id='submit' value='提交'></td>\
								<td align='center'><input type='submit' onclick='cancel();' value='取消'></td>\
							</tr></tbody></table>\
					</div>  \
					<input type='hidden' name='newsId' id='newsId' value='${param.newsId}'>\
					<input type='hidden' name='page' id='page' value='${param.page}'>\
					<input type='hidden' name='pageSize' id='pageSize' value='${param.pageSize}'>\
					<input type='hidden' name='totalPageCount' id='totalPageCount' value='${param.totalPageCount}'>\
					<input type='hidden' name='commentId' id='commentId'>\
				</form>";
			document.getElementById('commentId').value=commentId;
      		document.getElementById('myModel').style.display="block";      		
      	}
      	
      	function cancel(){
      		document.getElementById('myModel').innerHTML="";
      		document.getElementById('myModel').style.display="none"; 
      	}
      	
	</script>  
  </head>
  
  <body>
	<form action="/news/servlet/NewsServlet?type1=showANews&newsId=${param.newsId}" id="myform" method="post">
		<div class="center" style="width:600px">
		  <a name="commentsStart"></a>
		  <div class="commentsHead">最新评论</div>
		  <c:forEach items="${requestScope.commentUserViews}"  var="commentUserView">	
			<div style="margin-bottom: 10px;;">
				<div>
					<div class="commentIcon">
						<img width="35" src="${commentUserView.headIconUrl}">
					</div>
					<div class="comment1">
						<div class="commentAuthor">${commentUserView.userName}</div>
						<div class="commentTime">
							<myTag:TimestampTag dateTime="${commentUserView.time}" type="latest"/>
						</div>
					</div>
					<div class="comment2">
						<div class="comment3">
							<a class="commentReplay" href="javascript:void(0);" onclick="model(${commentUserView.commentId});">
								回复
							</a>
						</div>			
						<div class="comment4">
							<span class="commentPraiseText">第${commentUserView.stair}楼</span>
							<a class="commentPraiseA" href="javascript:void(0);" onclick="praise(${commentUserView.commentId},${param.newsId});">							
							</a><span class="commentPraiseText">${commentUserView.praise}</span>
						</div>			
					</div>
				</div>	
				<div class="clear">
					<div class="comment5 ">
						<div class="commentContent">
							${commentUserView.content}
						</div>
					</div>
				</div>
			</div>
		  </c:forEach>
		  <div class="commentsHead" style="text-align:center;">
			<c:if test="${requestScope.pageInformation.page > 1}">
				<td><a href="javascript:void(0);" onclick="getOnePage('pre');">上一页</a></td>  
			</c:if>
			<c:if test="${requestScope.pageInformation.page < requestScope.pageInformation.totalPageCount}">
				<td><a href="javascript:void(0);" onclick="getOnePage('next');">下一页</a></td>
			</c:if> 		  
		  </div>		  
		</div> 

	 	<input type="hidden" class="page" name="page" id="page" value="${requestScope.pageInformation.page}">
		<input type="hidden" class="pageSize" name="pageSize" id="pageSize" value="${requestScope.pageInformation.pageSize}">
	 
	</form>   
   
   <div id="myModel" class="model"></div>
  </body>

  
</html>
