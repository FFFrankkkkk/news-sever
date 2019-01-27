<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/myTagLib" prefix="myTag"%>
<!doctype html>
<html>
 <head>
 	<meta charset="utf-8"> 
 	<!--修改bootstrap自带的样式-->
 	<style type="text/css">
		#newsTypesPage li{
			padding:0em;
			border:0em;
			margin-top: 0em
		}
		#newsTypes li:hover{
			color:red
		}
		#rightDiv .list-group{
			list-style:disc inside;
		}
		#rightDiv .list-group-item{
			display:list-item;
		}		
    </style>  	
 	<script type="text/javascript" src="/news2/plugin/jquery/jquery-3.2.1.min.js"></script>
 	<script type="text/javascript">
 	
        function getYearMonthDay( date ){
            if(date!=null)
                return date.date.year+"-"
                    +(date.date.month>9?date.date.month:"0"+date.date.month)+"-"
                    +(date.date.day>9?date.date.day:"0"+date.date.day);
            else
                return "";
        } 	
 		//更新新闻列表
 		function refreshNews( data ){
            if (data != null) {
           		$("#newsShowByTypeUL").empty();   //清空新闻列表的所有内容
           	var newsShow = "";
           	//生成新闻列表
           	for(var i=2;i<data.length;i++){ 
 				newsShow+='<li class="list-group-item border-0 p-1"><a href="/news2/servlet/NewsServlet?type1=showANews&newsId='
				  				+data[i].newsId+'&page=1&pageSize=10" target="_blank">'
				  				+data[i].caption+'</a>&nbsp; &nbsp;'
				  				+getYearMonthDay(data[i].newsTime)+'</li> ';         	
           	}
           	$("#newsShowByTypeUL").html(newsShow);
           	//更新分页信息
           	$("#page").val(data[0].page);
           	$("#pageSize").val(data[0].pageSize);
           	$("#totalPageCount").val(data[0].totalPageCount);
           	$("#allRecordCount").val(data[0].allRecordCount);
           	$("#newsType").val(data[1]);
           }		
 		}
 	
 		function changeNewsByType(){ 			
			$.ajax({//异步请求
				type:		"post",
				url:		"/news2/servlet/NewsServlet?type1=showNewsByNewsTypeAjax",//异步请求的网址
				dataType:	"json",//预期服务器返回的数据类型
				data:		$("#myform").serialize(),//serialize()序列表表单内的表单元素值为字符串，用于 Ajax 请求。此处使用$("#myform").serialize()可以将id为myform的表单的数据传送到服务器端
				success: 	function (data) {//success，ajax请求成功后自动执行的回调函数，data包含了服务器返回给客户端的数据（json格式）
									refreshNews( data );
		        			},
			    error: 		function() {
				        		alert("有其他问题！");
			        		}
      		});
      	}
 		
 		//一般的函数，比如这里的refreshNews和changeNewsByType函数，要放在$(document).ready之外
 		$(document).ready(function(){		
			//点击新闻类别的事件
	   		$("#leftMenu li").click( function() {
	   			var label = $(this).text();
	
	   			if(label == "全部")
	   				label="all";
	   			
   				$.ajax({
   					type:		"post",
   					url:		"/news2/servlet/NewsServlet?type1=showNewsByNewsTypeAjax",
   					dataType:	"json",
   					data:		{"newsType":label,"page":"1","pageSize":"10"},//json格式的数据，这种数据也可以提交到服务器端
   					success: 	function (data) {
									refreshNews( data );
	            				},	        		
	        		error: 		function() { 
							        alert("有其他问题！");
						        }
   				});	   			     				
	   		});	
	   		
			//上一页按钮click事件 
			$("#previous").click(function() {
				var page = parseInt($("#page").val());
				if (page != 1) {
					page--;
					$("#page").val(page.toString());
				}
				changeNewsByType();
			}); 
			
			//下一页按钮click事件 
			$("#next").click(function() { 
				var pageCount = parseInt($("#totalPageCount").val());
				var page = parseInt($("#page").val());
				if (page < pageCount) {
					page++; 
					$("#page").val(page.toString());
				}
				changeNewsByType();
			}); 	   				
		});	
	</script>
  </head>  
  <body>
  
 	<div class="container">
 	  <!--border使用了Utilities的Borders工具，Borders工具可以控制边框的显示、颜色和圆角 ：border表示显示边框；border-right表示显示右边框；  -->
 	  <!--p-0 m-0 ml-0 pl-0 mb-0使用了Utilities的Spacing工具，Spacing工具可以控制margin和padding  -->
	  <div class="row border  p-0 m-0" id="#newsTypesPage">
	  	<!-- 使用了Utilities的Display工具：d-none d-sm-block 表示在sm及以下屏幕中，该div会隐藏。   -->
		<div class="col-md-2  col-sm-3  d-none d-sm-block ml-0 pl-0 border-right text-center " id="leftMenu">
	        <ul class="list-group" id="newsTypes">
			  <li class="list-group-item border-0">全部</li>
			  <li class="list-group-item border-0">国际</li>
			  <li class="list-group-item border-0">社会</li>
			  <li class="list-group-item border-0">体育</li>
			  <li class="list-group-item border-0">科学</li>
			  <li class="list-group-item border-0">汽车</li>			  				  
			</ul>
	   </div>
	   
	   <div class="col">
			<div class=""  id="rightDiv">
		        <ul class="list-group p-2" id="newsShowByTypeUL">
		        	<c:forEach items="${requestScope.newses}"  var="news">
		        		<!--使用了Utilities的Borders工具，border-0表示无边框；p-1表示padding设置  -->
				  		<li class="list-group-item border-0 p-1">
				  			<a href="/news2/servlet/NewsServlet?type1=showANews&newsId=${news.newsId}&page=1&pageSize=10" target="_blank">${news.caption}</a>
				  			&nbsp; &nbsp; <myTag:LocalDateTimeTag dateTime="${news.newsTime}" type="YMD-"/>
				  		</li>
				  	</c:forEach>			  
				</ul>
				<div class="m-2">
					<a class="mr-3" id="previous" href="javascript:void(0);">上一页</a>
					<a id="next" href="javascript:void(0);">下一页</a>					
				</div>
						
			</div>	
	   </div>	   	   
	 </div>  			
   </div>
   <form action="" id="myform" method="post">  
		<!-- 隐藏的分页数据  -->
 		<input type="hidden" name="page" id="page" value="${requestScope.pageInformation.page}">
		<input type="hidden" name="pageSize" id="pageSize" value="${requestScope.pageInformation.pageSize}">
 		<input type="hidden" name="totalPageCount" id="totalPageCount" value="${requestScope.pageInformation.totalPageCount}">
		<input type="hidden" name="allRecordCount" id="allRecordCount" value="${requestScope.pageInformation.allRecordCount}">
		<input type="hidden" name="newsType" id="newsType" value="${requestScope.newsType}">
	</form>
  </body>
</html>
