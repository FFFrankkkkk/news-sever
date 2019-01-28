<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/myTagLib" prefix="myTag"%>
<!--bootstrap必须使用html5规范-->
<!doctype html><html lang="cn">
<head>
	<meta charset="utf-8">
	<!--Bootstrap必须设定 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!--以下css和js都必须按此顺序引入 -->
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/news/plugin/boostrap/bootstrap-4.2.1-dist/css/bootstrap.min.css">
    <!-- Font-Awesome图标 -->
    <link rel="stylesheet" href="/news/plugin/Font-Awesome-3.2.1/css/font-awesome.min.css">
	<!--Bootstrap必须先引入jquery -->
	<script type="text/javascript" src="/news/plugin/jquery/jquery-3.2.1.min.js"></script>
    <script src="/news/plugin/boostrap/bootstrap-4.2.1-dist/js/popper.min.js"></script>
    <script src="/news/plugin/boostrap/bootstrap-4.2.1-dist/js/bootstrap.min.js"></script>
 </head>  
  <body>
  	<!--bootstrap的grid系统，必须 依次使用container、row和col样式，来表示一行的一格-->
  	<div class="container">
	  	<div class="row">
	  		<div class="col">
	  			<!-- 导航栏组件（菜单） -->				
				<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
					<!-- navbar-brand表示导航栏的标志（左边，大字体）， icon-book是Font-Awesome图标 的一个图标  icon-2x表示图标放大两倍-->	
				  <a class="navbar-brand" href="#"><i class="icon-book icon-2x"></i> 新闻网</a>
				  	<!-- 在小屏幕上，此button才会显示 -->
				  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				    <span class="navbar-toggler-icon"></span>
				  </button>
					<!-- 菜单项 -->
				  <div class="collapse navbar-collapse" id="navbarSupportedContent">
				    <ul class="navbar-nav mr-auto" >
			    	<c:if test="${!(empty sessionScope.user) }">
			    		<li class="nav-item">
							<a class="nav-link" href="/news/user/manageUIMain/manageMain.jsp">管理</a>
						</li>
					</c:if>
						<li class="nav-item">
				      		<a class="nav-link" href="/news/index.jsp">首页</a>
				      	</li>
						<li class="nav-item">
				      		<a class="nav-link" href="/news/onPhone.html">手机端效果：</a>
				      	</li>				      	
			    	<c:if test="${empty sessionScope.user }">
			    		<li class="nav-item">
							<a class="nav-link" href="/news/user/public/login.jsp">登录</a>
						</li>
					</c:if>
			    	<c:if test="${empty sessionScope.user }">
			    		<li class="nav-item">
							<a class="nav-link" href="/news/user/public/register.jsp">注册</a>
						</li>
					</c:if>
					<c:if test="${!(empty sessionScope.user) }">
			    		<li class="nav-item">
							<a class="nav-link" href="/news/servlet/UserServlet?type1=exit">注销</a>
						</li>
					</c:if>
						<!-- 子菜单 -->
						<li class="nav-item dropdown d-block d-sm-none">
						  <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						    	新闻类别
						  </a>
						  <div class="dropdown-menu" aria-labelledby="navbarDropdown">
						  		<a class="dropdown-item" href="/news/servlet/NewsServlet?type1=showNewsByNewsType&newsType=all&page=1&pageSize=10">全部</a>
						  		<a class="dropdown-item" href="/news/servlet/NewsServlet?type1=showNewsByNewsType&newsType=国际&page=1&pageSize=10">国际</a>
						  		<a class="dropdown-item" href="/news/servlet/NewsServlet?type1=showNewsByNewsType&newsType=社会&page=1&pageSize=10">社会</a>
								<a class="dropdown-item" href="/news/servlet/NewsServlet?type1=showNewsByNewsType&newsType=体育&page=1&pageSize=10">体育</a>
						  		<a class="dropdown-item" href="/news/servlet/NewsServlet?type1=showNewsByNewsType&newsType=科学&page=1&pageSize=10">科学</a>
						  		<a class="dropdown-item" href="/news/servlet/NewsServlet?type1=showNewsByNewsType&newsType=汽车&page=1&pageSize=10">汽车</a>
						  </div>
						</li>																
				    </ul>
					<form class="form-inline" id="searchForm" action="/news/servlet/NewsServlet?type1=newsSearch&page=1&pageSize=5">
					  <input class="form-control" type="search" placeholder="搜索新闻" name="search">
					  <!-- btn-outline-light表示按钮的显示方式：外框浅色 -->
					  <button class="btn btn-outline-light" type="submit">搜索</button>
					</form>				    
				  </div>
				</nav>			
			</div>
	  	</div>
	</div>
	</body>
  </html>
