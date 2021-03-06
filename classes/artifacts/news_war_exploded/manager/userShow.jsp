<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/myTagLib" prefix="myTag"%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="/news/plugin/bootstrap-table-develop/bootstrap-table.min.css">
	<script type="text/javascript" src="/news/plugin/jquery/jquery-3.2.1.min.js"></script>
	<script src="/news/plugin/bootstrap-table-develop/bootstrap-table.min.js"></script>
	<script src="/news/plugin/bootstrap-table-develop/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript">
        $(document).ready(function(){
            //1.初始化Table
            var oTable = new TableInit();
            oTable.Init();

        });

        var TableInit = function () {
            var oTableInit = new Object();
            //初始化Table
            oTableInit.Init = function () {
                $('#userTable').bootstrapTable({
                    url: '/news/servlet/UserServlet?type1=showPage',         //请求后台的URL（*）
                    method: 'post',                      //请求方式（*）
                    contentType: "application/x-www-form-urlencoded",//post请求的话就加上这个句话
                    //toolbar: '#toolbar',                //工具按钮用哪个容器
                    striped: true,                      //是否显示行间隔色
                    cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                    pagination: true,                   //是否显示分页（*）
                    //sortable: false,                     //是否启用排序
                    //sortOrder: "asc",                   //排序方式

                    //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
                    //设置为limit可以获取limit, offset, search, sort, order
                    queryParamsType : "undefined",
                    queryParams: oTableInit.queryParams,//传递参数（*）,比如页码，每页记录数
                    sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                    pageNumber:1,                       //初始化加载第一页，默认第一页
                    pageSize: 10,                       //每页的记录行数（*）
                    //pageList: [10, 20, 30],        //可供选择的每页的行数（*）
                    //search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                    //strictSearch: true,
                    showColumns: false,                  ////显示下拉框勾选要显示的列
                    //showRefresh: true,                  //是否显示刷新按钮
                    //minimumCountColumns: 2,             //最少允许的列数
                    //clickToSelect: true,                //是否启用点击选中行
                    //height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                    uniqueId: "userId",                     //每一行的唯一标识，一般为主键列
                    //showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
                    cardView: false,                    //是否显示详细视图
                    detailView: false,                   //是否显示父子表
                    columns: [{
                        field: 'userId',
                        title: 'id'
                    }, {
                        field: 'name',
                        title: '用户名'
                    }, {
                        field: 'type',
                        title: '类型'
                    }, {
                        field: 'registerDate',
                        title: '注册日期'
                    }, {
                        field: 'enable',
                        title: '可用性'
                    }, ]
                });
            };

            //得到查询的参数
            oTableInit.queryParams = function (params) {
                var temp = {   //这里的键的名字和servlet的变量名必须一直，这边改动，servlet也需要改成一样的
                    page: params.pageNumber,   //页面大小
                    pageSize: params.pageSize  //页码
                };
                return temp;
            };
            return oTableInit;
        };
	</script>

</head>

<body>
<table id="userTable"></table>
</body>
</html>
