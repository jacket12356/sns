<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>忘记密码 - AESOPSNS - Powered By AESOPSNS</title>
    <meta name="keywords" content="AESOPSNS,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
    <link rel="shortcut icon" href="/Aesopsns/favicon.ico">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link href="/Aesopsns/res/common/css/bootstrap.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/font-awesome.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/jeesns.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="/Aesopsns/res/common/js/html5shiv.min.js"></script>
    <script src="/Aesopsns/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="/Aesopsns/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="/Aesopsns/res/common/js/bootstrap.min.js"></script>
    <script src="/Aesopsns/res/plugins/metisMenu/metisMenu.js"></script>
    <script src="/Aesopsns/res/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.form.js"></script>
    <script src="/Aesopsns/res/common/js/manage.js"></script>
    <script src="/Aesopsns/res/common/js/jeesns.js"></script>

</head>

<body class="gray-bg">
<script>
function infoCheck(){
	var name = $("#name").val();
	var mail = $("#mail").val();
	if(name != "" && mail != "") {  
		$.ajax({
    		type : 'post',
    		url : '/Aesopsns/user/passwordgetback',
    		data : 'name='+name+'&mail='+mail,
    		//回调函数
    		success : function(error){
    			if(error != "") {
    				$("#popup").html(error);
    				setTimeout("deletee()",6000);
    			}
    		}
    	});
    }
}
function deletee(){
	$("#popup").html(" ");
}
</script>
<div id="wrapper">
    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
        
        <!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/user_header.jspf"%>
		
        </div>
<div class="animated fadeInDown">
    <div class="row login-panel">
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <div class="ibox ibox-content">
                <h2 class="font-bold">忘记密码</h2>
                <form class="m-t jeesns_form" action="" method="post">
                    <input type="hidden" name="redirectUrl" value="">
                    <div class="form-group">
                        用户名
                        <input type="text" class="form-control" id="name" name="name" placeholder="用户名" data-type="require">
                    </div>
                    <div class="form-group">
                        邮箱
                        <input type="email" class="form-control" id="mail" name="mail" placeholder="邮箱"
                               data-type="require">
                    </div>
                    <button type="submit" class="btn btn-primary block full-width m-b" onclick="infoCheck()">找回密码</button>
                </form>
                <p></p>
                <p class="text-muted text-center">
                    <a href="/Aesopsns/user/login">我要登录</a> | 
                    <a href="/Aesopsns/user/regist">我要注册</a>
                </p>
            </div>
        </div>
    </div>
</div>
<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/user_header.jspf"%>
		</body>
<div id="popup"></div>
</html>