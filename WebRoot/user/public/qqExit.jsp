<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8"> 
        <script src="/news2/plugin/jquery/jquery-3.2.1.min.js"></script> 
        <script type="text/javascript" src="//connect.qq.com/qc_jssdk.js" data-appid="101504585" 
        	data-redirecturi="http://220a27a0.nat123.cc:19537/news2/user/public/qqLoginCallback.jsp" charset="utf-8"></script>
		<script type="text/javascript">
            $(document).ready(function(){
                if(QC.Login.check()){
                    QC.Login.signOut();
                }
                window.location.href="/news2/index.jsp"; 
            });
		</script>
	</head>
    <body></body>
</html>
 


