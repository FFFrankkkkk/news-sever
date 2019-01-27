<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!doctype html>
<html>
 <head>
     <meta charset="UTF-8">
     <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
 </head>
   <body>
	<jsp:include page='<%="/servlet/NewsServlet?type1=homepageTypes"%>' flush="true" />
	<%--<jsp:include page='<%="index2.jsp"%>' flush="true" />--%>
   </body>
 </html>
