<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  	<link href="/news/css/1.css" rel="stylesheet" type="text/css">
  	<script type="text/javascript" src="/news/jquery-3.2.1.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){	
			$("#addCommentForm").on("submit", function(ev) {
				var url="/news/servlet/CommentServlet?type=addComment"+
						"&newsId="+$("#newsId").val()+"&pageSize="+$("#pageSize").val()
						+"&page=1";
			
				//jQuery.post(url, [data], [callback], [type])
				//callback:发送成功时回调函数。
				//type:返回内容格式，xml, html, script, json, text, _default。
				$.post(url,	$("#addCommentForm").serialize(),function(data,textStatus){
						if (textStatus=="success"){	
							$("#showComment").html(data);
							$("#myTextarea11").val("");//清空内容
						}else
					      	alert("添加失败！");
 				}, "html");	
 				ev.preventDefault();	
			});	
		});	
		
       function getOnePage(type){	
    	  	var pageValue=parseInt( $("#page1").val() );
   	  	
    	  	if(type=="pre"){
    	  		pageValue-=1;
    	  	}else if(type=="next"){
    	  		pageValue+=1;   	  		
    	  	}
    	  	
    	  	var url="/news/servlet/CommentServlet?type=showComment"
    	  			+"&newsId="+$("#newsId").val()+"&pageSize="+$("#pageSize").val()
					+"&page="+pageValue;
					
			$("#showComment").load(url);
      	}
      	
      	function praise(element, commentId,newsId){
			$.ajax({
 		        type: "post",
		        dataType: "json",
		        url: "/news/servlet/CommentServlet?type=praise&"+"&commentId="+commentId+"&newsId="+newsId,
		        data: $("#showCommnentForm").serialize(),
		        success: function (data) {
		            if (data != null) {
		            	if(data.result>0){
		            		$(element).next().html(data.result); 
		            	}else//登录失败		                
							alert("点赞失败！");
		            }
		        },
		        error: function() { 
			        alert("未能连接到服务器!");   
		        }               
            }); 
      	}
      	
      	function model(commentId){
      		$("#myModel").show();
      		$("#replyCommentForm").on("submit", function(ev) {
      			var url="/news/servlet/CommentServlet?type=addComment"+
      					"&newsId="+$("#newsId").val()+"&pageSize="+$("#pageSize").val()
						+"&page=1"+"&commentId="+commentId;			
      			
				$("#showComment").load(url,$("#replyCommentForm").serialize());	
 				ev.preventDefault();	
			});	
      	}		
	</script>  	
  </head>
  <body>
  	<!--新闻内容 -->
  	<div class="center" style="width:800px;margin-top:30px;">
		<table width="800" border="0">
			<tbody>
				<tr><td class="newsCaption">${news.caption}</td>
				<tr><td align="center" height="50">作者：${news.author}&nbsp;	&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
						<myTag:LocalDateTimeTag dateTime="${news.newsTime}" type="YMDHM"/></td>
				</tr><tr><td height="30"><hr></td></tr>
				<tr>
					<td>${news.content}</td>
				</tr>
				<tr><td height="30"><hr></td></tr>
			</tbody>
		</table>
		<input type="hidden" name="newsId" id="newsId" value="${news.newsId}">
		<input type="hidden" name="pageSize" id="pageSize" value="${pageInformation.pageSize}">
	</div>
	
	<!--回复评论 -->
	<div id="addComment">
	    <div class="center" style="width:800px;margin-top:30px;">
		  	<form id="addCommentForm">
		  		<div class="center" style="width:500px">
					<textarea name="content" cols="72" rows="8" id="myTextarea11" required></textarea>
				</div><p>
				<div class="center" style="width:50px;height:80px;">
					<br><input type="submit" value="  提 交 评 论  ">
				</div>
			</form> 
		 </div>
	</div>		 
	 
	 <!--对回复的回复 -->
	<div id="showComment"> 
		<form id="showCommnentForm">
			<div class="center" style="width:600px">
			  <a name="commentsStart"></a>
			  <div class="commentsHead">最新评论</div>
			  <#list commentUserViews as commentUserView>
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
								<a class="commentPraiseA" href="javascript:void(0);" onclick="praise(this,${commentUserView.commentId},${news.newsId});">							
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
			  </#list>
			  <div class="commentsHead" style="text-align:center;">
				<#if (pageInformation.totalPageCount > 1) >
					<td><a href="javascript:void(0);" onclick="getOnePage('next');">下一页</a></td>
				</#if> 		  
			  </div>		  
			</div>
		 	<input type="hidden" class="page" name="page" id="page1" value="${pageInformation.page}">
		</form>
		
	    <div id="myModel" class="model">
			<form id="replyCommentForm"> 
				<div class='modelContent'>  
					<table><tbody><tr><td colspan='2'> 
							<textarea name='content' cols='60' rows='8' id='textarea' required></textarea></td>
						</tr><tr>
							<td align='center'><input type='submit'  value='提交'></td>
							<td align='center'><input type='button' onclick='$("#myModel").hide();' value='取消'></td>
						</tr></tbody></table>
				</div>
			</form>   
	    </div>
  </body>
</html>
