<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!doctype html>
<html>
 <head>
 	<meta charset="utf-8">
 	<link href="/news/css/1.css" rel="stylesheet" type="text/css">
	 <script src="/news/jquery-3.3.1.min.js"></script>
	 <script type="text/javascript"  charset="utf-8"    src="http://connect.qq.com/qc_jssdk.js"
			 data-appid="101516482"  data-redirecturi="https://www.appfull.cn/doorAlarm"></script>
 	<script type="text/javascript">
		$(function () {
            $(".loginChoice1").css({
                "border-bottom" :"1px solid #111111",
                "color" : "#111111"
            });
            $(".loginChoice2").css({
                "border-bottom" :"1px solid #A8A297",
                "color" : "#A8A297"
            });
            $(".loginChoice3").css({
                "border-bottom" :"1px solid #A8A297",
                "color" : "#A8A297"
            });
            $(".phoneLogin").css("display","none");
            $(".emailLogin").css("display","none");
            $(".userLogin").css("display","block");
			$(".userLogin  .submit").click(function () {
				if($(".userLogin .name").val()==null||$(".userLogin .name").val()==""){
				    $(".namespan").html("*不能为空");
				    return;
				}
				  $(".namespan").html("ok");
                if($(".userLogin .password").val()==null||$(".userLogin .password").val()==""){
                    $(".userLogin .passwordspan").html("*不能为空");
                    return;
                }
                $(".userLogin .passwordspan").html("ok");
               // $("form").submit();
                $.ajax({
                    url: "http://localhost:8080/news/servlet/UserServlet?type1=login",
                    type: "POST",
                    timeout : 5000,
                    data: {
                        "name":$(".userLogin .name").val(),
						  "password":$(".userLogin .password").val()
                    },
                    dataType:"text",
                 //   contentType: "application/json;charset=UTF-8",
                    success: function (data) {
                        if(data.indexOf("h")!=-1){
                        //    $(".userLogin >form").submit();
                            window.location.href="http://localhost:8080/news/index.jsp";
						}else  alert(data);
                    },
                    error : function(data) {
                        alert("提交失败");
                    },
                });

            });
			$(".phoneLogin .submit").click(function () {
                if($(".phoneLogin .name").val()==null||$(".phoneLogin .name").val()==""){
                    $(".phoneLogin .namespan").html("*不能为空");
                    return;
                }
                $(".phoneLogin .namespan").html("ok");
                if($(".phoneLogin .password").val()==null||$(".phoneLogin .password").val()==""){
                    $(".phoneLogin .passwordspan").html("*不能为空");
                    return;
                }
                $(".phoneLogin .passwordspan").html("ok");
                $.ajax({
                    url: "http://localhost:8080/news/servlet/UserServlet?type1=phoneLogin",
                    type: "POST",
               //     timeout : 5000,
                    data: {
                        "phoneNumber":$(".phoneLogin .name").val(),
                        "phoneMessage":$(".phoneLogin .password").val()
                    },
                    dataType:"text",
                    //   contentType: "application/json;charset=UTF-8",
                    success: function (data) {
                        if(data.indexOf("s")!=-1){
                            window.location.href="http://localhost:8080/news/index.jsp";
                        }else  alert(data);
                    },
                    error : function(data) {
                        alert("提交失败");
                    },
                });
            });
            $(".emailLogin .submit").click(function () {
                if($(".emailLogin .name").val()==null||$(".emailLogin .name").val()==""){
                    $(".emailLogin .namespan").html("*不能为空");
                    return;
                }
                $(".emailLogin.namespan").html("ok");
                if($(".emailLogin .password").val()==null||$(".emailLogin .password").val()==""){
                    $(".emailLogin .passwordspan").html("*不能为空");
                    return;
                }
                $(".emailLogin .passwordspan").html("ok");
                $.ajax({
                    url: "http://localhost:8080/news/servlet/UserServlet?type1=emailLogin",
                    type: "POST",
                    //     timeout : 5000,
                    data: {
                        "phoneNumber":$(".emailLogin .name").val(),
                        "phoneMessage":$(".emailLogin .password").val()
                    },
                    dataType:"text",
                    //   contentType: "application/json;charset=UTF-8",
                    success: function (data) {
                        if(data.indexOf("s")!=-1){
                            window.location.href="http://localhost:8080/news/index.jsp";
                        }else  alert(data);
                    },
                    error : function(data) {
                        alert("提交失败");
                    },
                });
            });
			$(".phoneLogin .sendMessage").click(function () {
                if($(".phoneLogin .name").val()==null||$(".phoneLogin .name").val()==""){
                    $(".phoneLogin .namespan").html("*不能为空");
                    return;
                }
                $(".phoneLogin .namespan").html("ok");
                var i=60;
                $(".phoneLogin  .sendMessage").attr('disabled',true);
                window.timer=setInterval(function () {
                    i=i-1;
                    $(".phoneLogin  .sendMessage").val(i+"后可再次发送");
                    if(i==0){
                        clearInterval(timer);
                        $(".phoneLogin  .sendMessage").val("获取验证码");
                        $(".phoneLogin  .sendMessage	").attr('disabled',false);
                        i=60;
                    }
                },10);
                $.ajax({
                   // url: "http://localhost:8080/news/servlet/UserServlet?type1=login",
					  url:"http://localhost:8080/news/servlet/UserServlet?type1=sendMessage",
                    type: "POST",
              //      timeout : 5000,
                    data: {
                        "phoneNumber":$(".phoneLogin .name").val()
                    },
                    dataType:"text",
                    //   contentType: "application/json;charset=UTF-8",
                    success: function (data) {
                        alert(data);
                        if(data.indexOf("!")!=-1){
                            clearInterval(timer);
                            $(".phoneLogin .sendMessage").val("获取验证码");
                            $(".phoneLogin .sendMessage").attr('disabled',false);
                            i=60;
						}
                    },
                    error : function() {
                        alert("提交失败");
                        clearInterval(timer);
                        $(".phoneLogin .sendMessage").val("获取验证码");
                        $(".phoneLogin .sendMessage").attr('disabled',false);
                        i=60;
                    },
                });
            })
            $(".emailLogin .sendMessage").click(function () {
                if($(".emailLogin .name").val()==null||$(".emailLogin .name").val()==""){
                    $(".emailLogin .namespan").html("*不能为空");
                    return;
                }
                $(".emailLogin.namespan").html("ok");
                var i=60;
                $(".emailLogin .sendMessage").attr('disabled',true);
                window.timer=setInterval(function () {
                    i=i-1;
                    $(".emailLogin .sendMessage").val(i+"后可再次发送");
                    if(i==0){
                        clearInterval(timer);
                        $(".emailLogin .sendMessage").val("获取验证码");
                        $(".emailLogin .sendMessage	").attr('disabled',false);
                        i=60;
                    }
                },10);
                $.ajax({
                    url:"http://localhost:8080/news/servlet/UserServlet?type1=sendEmail",
                    type: "POST",
                    //      timeout : 5000,
                    data: {
                        "emailUser":$(".emailLogin .name").val()
                    },
                    dataType:"text",
                    //   contentType: "application/json;charset=UTF-8",
                    success: function (data) {
                        alert(data);
                        if(data.indexOf("!")!=-1){
                            clearInterval(timer);
                            $(".emailLogin .sendMessage").val("获取验证码");
                            $(".emailLogin .sendMessage	").attr('disabled',false);
                            i=60;
                        }
                    },
                    error : function() {
                        alert("提交失败");
                        clearInterval(timer);
                        $(".emailLogin .sendMessage").val("获取验证码");
                        $(".emailLogin .sendMessage	").attr('disabled',false);
                        i=60;
                    },
                });
            })
			$(".loginChoice1").click(function () {
                   $(".loginChoice1").css({
                       "border-bottom" :"1px solid #111111",
				        "color" : "#111111"
				   });
                $(".loginChoice2").css({
                    "border-bottom" :"1px solid #A8A297",
                    "color" : "#A8A297"
                });
                $(".loginChoice3").css({
                    "border-bottom" :"1px solid #A8A297",
                    "color" : "#A8A297"
                });
				$(".phoneLogin").css("display","none");
                $(".userLogin").css("display","block");
                $(".emailLogin").css("display","none");
            });
            $(".loginChoice2").click(function () {
                $(".loginChoice2").css({
                    "border-bottom" :"1px solid #111111",
                    "color" : "#111111"
                });
                $(".loginChoice1").css({
                    "border-bottom" :"1px solid #A8A297",
                    "color" : "#A8A297"
                });
                $(".loginChoice3").css({
                    "border-bottom" :"1px solid #A8A297",
                    "color" : "#A8A297"
                });
                $(".phoneLogin").css("display","block");
                $(".userLogin").css("display","none");
                $(".emailLogin").css("display","none");
            });
            $(".loginChoice3").click(function () {
                $(".loginChoice3").css({
                    "border-bottom" :"1px solid #111111",
                    "color" : "#111111"
                });
                $(".loginChoice1").css({
                    "border-bottom" :"1px solid #A8A297",
                    "color" : "#A8A297"
                });
                $(".loginChoice2").css({
                    "border-bottom" :"1px solid #A8A297",
                    "color" : "#A8A297"
                });
                $(".emailLogin").css("display","block");
                $(".userLogin").css("display","none");
                $(".phoneLogin").css("display","none");
            });
        });
	</script>
</head>

<body>
<div class="loginChoice1">
	<p>账号登陆</p>
</div>
<div class="loginChoice2">
	<p>手机短信登陆</p>
</div>
<div class="loginChoice3">
	<p>邮箱登陆</p>
</div>
<div class="userLogin">
<form   action="/news/servlet/UserServlet?type1=login" method="post">
	<div class="center" style="width:400px;margin-top:40px">
		<table  height="121" border="0" align="center">
			<tbody>
				<tr height="30">
				</tr>			
				<tr height="30">
					<td align="right">用户名：</td>
					<td align="left"><input type="text" name="name" id="name"  class="name"><span class="namespan"></span></td>
				</tr>
				<tr height="30">
					<td align="right">密码：</td>
					<td align="left"><input type="password" name="password" id="password" class="password"><span class="passwordspan"></span></td>
				</tr>
				<tr height="30">
					<td></td><td><input type="button" value="    登  录    " class="submit"/></td>
				</tr>
			<tr>
				<%--<input type="button" value="手机登陆" class="phoneLogin">--%>
			</tr>
			</tbody>
		</table>
	</div>
</form>
</div>
<div class="phoneLogin">
	<form   action="/news/servlet/UserServlet?type1=sendMessage" method="post">
		<div class="center" style="width:400px;margin-top:40px">
			<table  height="121" border="0" align="center">
				<tbody>
				<tr height="30">
				</tr>
				<tr height="30">
					<td align="right">手机号码：</td>
					<td align="left"><input type="text" name="name"    class="name"><span class="namespan"></span></td>
				</tr>
				<tr height="30">
					<td align="right">手机验证码：</td>
					<td align="left"><input type="text" name="password" class="password"><input type="button" name="sendMessage" class="sendMessage" value="获取验证码"><span class="passwordspan"></span></td>
				</tr>
				<tr height="30">
					<td></td><td><input type="button" value="    登  录    " class="submit"/></td>
				</tr>
				<tr>
				</tr>
				</tbody>
			</table>
		</div>
	</form>
</div>
<div class="emailLogin">
	<form   action="/news/servlet/UserServlet?type1=sendMessage" method="post">
		<div class="center" style="width:400px;margin-top:40px">
			<table  height="121" border="0" align="center">
				<tbody>
				<tr height="30">
				</tr>
				<tr height="30">
					<td align="right">邮箱号码：</td>
					<td align="left"><input type="text" name="name"    class="name"><span class="namespan"></span></td>
				</tr>
				<tr height="30">
					<td align="right">邮箱证码：</td>
					<td align="left"><input type="text" name="password" class="password"><input type="button" name="sendMessage" class="sendMessage" value="获取验证码"><span class="passwordspan"></span></td>
				</tr>
				<tr height="30">
					<td></td><td><input type="button" value="    登  录    " class="submit"/></td>
				</tr>
				<tr>
				</tr>
				</tbody>
			</table>
		</div>
		</tr>
	</form>
</div>
<tr height="30">
		<td>
		<span id="qqLoginBtn" style="left: 48%;top: 253px;position: absolute;"></span>
		<script type="text/javascript">
            QC.Login({
                btnId:"qqLoginBtn",    //插入按钮的节点id
                showModal :true
            });
		</script>
	</td>
</tr>
  </body>
</html>
