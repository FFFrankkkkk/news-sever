<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/myTagLib" prefix="myTag"%>

<!doctype html>
<html>
 <head><link href="/news/css/1.css" rel="stylesheet" type="text/css"></head>
   <body>
	<div class="news">
	   <c:forEach items="${requestScope.newsTypes}"  var="newsType" varStatus="newsTypeStatus">
		<div class="newsleft" name="news1">
			<table class="invisibleTable"><tbody>
				<tr class="newsColumn"><td>
					<c:choose>
					    <c:when test="${newsType == 'all'}">
							最新
						</c:when>
					    <c:otherwise>
					        ${newsType}
					    </c:otherwise>
					</c:choose>
				</td><td align="right">
					<a href="/news/servlet/NewsServlet?type1=showNewsByNewsType&newsType=${newsType}&page=1&pageSize=5">更多</a>
				</td></tr>
				<c:forEach items="${requestScope.newsesList[newsTypeStatus.index]}"  var="news" varStatus="status">
					<tr><td class="mainPageUl">
							<a href="/news/servlet/NewsServlet?type1=showANews&newsId=${news.newsId}&page=1&pageSize=2"
									title="${news.caption}">
								${requestScope.newsCaptionsList[newsTypeStatus.index].get(status.index)}
							</a>
						</td>
					<td align="right" width="130">
						<myTag:LocalDateTimeTag dateTime="${news.newsTime}" type="YMD"/></td></tr>
				</c:forEach>
			</tbody></table>
		</div>
       </c:forEach>
	</div>
	<form>
		<input type="hidden" id="newsTypeNumber" value="${requestScope.newsTypesNumber}">
	</form>
   </body>
  	<script type="text/javascript">
 		a=document.getElementById('newsTypeNumber');
 		var newsTypeNumber=parseInt(a.value);
 		var divs=document.getElementsByName("news1");
 		for(var i=0;i<divs.length;i++){
 			if(i%2==1)
 				divs[i].setAttribute("class", "newsRight");
 		}
 	</script>

 </html>
<%--<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>--%>
<%--<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>--%>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>--%>
<%--<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>--%>
<%--<%@ taglib uri="/myTagLib" prefix="myTag"%>--%>

<%--<!doctype html>--%>
<%--<html>--%>
<%--<head>--%>
	<%--<meta charset="UTF-8">--%>
	<%--<link href="/news/css/1.css" rel="stylesheet" type="text/css">--%>
	<%--<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>--%>
    <%--<script src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>--%>
    <%--<script src="https://unpkg.com/axios/dist/axios.min.js"></script>--%>

<%--</head>--%>
<%--<body>--%>
<%--<div class="news">--%>
	<%--<c:forEach items="${requestScope.newsTypes}"  var="newsType" varStatus="newsTypeStatus">--%>

		<%--<div class="newsleft" name="news1">--%>
			<%--<table class="invisibleTable"><tbody>--%>
			<%--<tr class="newsColumn"><td>--%>
				<%--<c:choose>--%>
					<%--<c:when test="${newsType == 'all'}">--%>
						<%--最新--%>
					<%--</c:when>--%>
					<%--<c:otherwise>--%>
						<%--${newsType}--%>
					<%--</c:otherwise>--%>
				<%--</c:choose>--%>
			<%--</td><td align="right">--%>
				<%--<a href="/news/servlet/NewsServlet?type1=showNewsByNewsType&newsType=${newsType}&page=1&pageSize=5">更多</a>--%>
			<%--</td></tr>--%>
			<%--<c:forEach items="${requestScope.newsesList[newsTypeStatus.index]}"  var="news" varStatus="status">--%>
				<%--<tr><td class="mainPageUl">--%>
					<%--<a href="/news/servlet/NewsServlet?type1=showANews&newsId=${news.newsId}&page=1&pageSize=2"--%>
					   <%--title="${news.caption}">--%>
							<%--${requestScope.newsCaptionsList[newsTypeStatus.index].get(status.index)}--%>
					<%--</a>--%>
				<%--</td>--%>
					<%--<td align="right" width="130">--%>
						<%--<myTag:LocalDateTimeTag dateTime="${news.newsTime}" type="YMD"/></td></tr>--%>
			<%--</c:forEach>--%>
			<%--</tbody></table>--%>
		<%--</div>--%>
	<%--</c:forEach>--%>

<%--</div>--%>
<%--<form>--%>
	<%--<input type="hidden" id="newsTypeNumber" value="${requestScope.newsTypesNumber}">--%>
<%--</form>--%>
<%--</body>--%>
<%--<script type="text/javascript">--%>
    <%--window.onload = function(){--%>
    <%--var vue =new Vue({--%>
        <%--el: '#app',--%>
        <%--data: {--%>
            <%--newsTypes:[],--%>
            <%--newsTypesNumber:"",--%>
            <%--newsesList:[],--%>
            <%--newsCaptionsList:[]--%>
        <%--},--%>
        <%--methods: {--%>

            <%--get: function () {--%>
                <%--axios({--%>
                    <%--method: 'post',--%>
                    <%--url: 'http://localhost:8080/news/servlet/NewsServlet?type1=homepageTypes',--%>
                    <%--headers: {--%>
                        <%--'Content-Type': 'application/json;charset=UTF-8'--%>
                    <%--},--%>
                    <%--params: {--%>
                        <%--'grant_type': 'code',--%>
                        <%--'client_id': '1231453',--%>
                        <%--'client_secret': 'THIS_IS_THE_SECRET'--%>
                    <%--}--%>
                <%--}).then(function (response) {--%>
                    <%--// console.log(response.data);--%>
                    <%--this.newsTypes=response.data[0];--%>
                    <%--this.newsTypesNumber=response.data[1];--%>
                    <%--this.newsesList=response.data[2];--%>
                    <%--this.newsCaptionsList=response.data[3];--%>
                    <%--console.log(this.newsTypes);--%>
                    <%--console.log(this.newsTypesNumber);--%>
                    <%--console.log(this.newsesList);--%>
                    <%--console.log(this.newsCaptionsList);--%>

                <%--}).catch(function (reason) {--%>
                    <%--console.log(reason);--%>
                <%--});--%>
                <%--// axios.post('http://localhost:8080/news/servlet/NewsServlet?type1=homepageTypes').then(function (response) {--%>
                <%--//    console.log(response.data);--%>
                <%--//    this.lists=response.data;--%>
                <%--//     console.log(lists);--%>
				<%--//--%>
                <%--// })--%>
                <%--//     .catch(function (error) {--%>
                <%--//         console.log(error);--%>
                <%--//     });--%>

            <%--}--%>
        <%--}--%>
    <%--});--%>
    <%--vue.get();--%>
    <%--}--%>
    <%--//初始化Vue对象完毕之后，就调用init方法 （一进入页面，就显示数据）--%>
<%--</script>--%>


<%--</html>--%>
