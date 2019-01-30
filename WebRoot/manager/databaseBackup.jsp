<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
 	<meta charset="utf-8">
 	<link href="/news/css/1.css" rel="stylesheet" type="text/css">
 	<script type="text/javascript" src="/news/plugin/jquery/jquery-3.2.1.min.js"></script>
 	<script type="text/javascript"> 
		$(document).ready(function(){
			$("#backup").click(function() {
				$.ajax({
			        type: "post",
			        dataType: "json",
			        url: '/news/servlet/DatabaseServlet?type=backup',
			        data: "",
			        success: function (message) {
			            if (message != null) 
			            	$("#rightDiv").html("操作结束。"+message.message);  
			            else
			            	$("#rightDiv").html("服务器异常！"); 
			        },
			        error: function() { 
				        $("#rightDiv").html("服务器异常！"); 
			        }
			    });
			})
		}); 	
  	</script>	
  </head>
 
  <body>
    <form>
		<input type="button" id="backup" value="  开 始 备份   "/>  	
  	</form> 
  </body>
</html>
