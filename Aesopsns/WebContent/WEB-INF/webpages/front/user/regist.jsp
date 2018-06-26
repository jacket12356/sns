<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>会员注册 - AESOPSNS - Powered By AESOPSNS</title>
    <meta name="keywords" content="AESOPSNS,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="shortcut icon" href="/Aesopsns/favicon.ico">
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
	var mail = $("#mail").val();
	var name = $("#name").val();
	var password = $("#password").val();
	if(mail != "" || name != "") {  
		$.ajax({
    		type : 'post',
    		url : '/Aesopsns/user/infovalidate',
    		data : 'mail='+mail+'&name='+name+'&password='+password,
    		//回调函数
    		beforeSend: function () {
                index = jeesnsDialog.loading();
            },
    		success : function(error){
    			if(error != "") {
    				$("#popup").html(error);
    				setTimeout("deletee()",2000);
    			}else{
    				//前台的bug果然只能用前台的代码来解决呢（解决后台doregist无法跳转的问题）
    				//现在到了有点弄懂前台这堆东西的时候，感觉这段js写的有点傻
    				jeesnsDialog.successTips("发送成功！");
    				setTimeout(function () {
                        jeesnsDialog.closeAll();
                    },1000);
    				window.location.href="/Aesopsns/user/login";
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
        
            <!-- <nav class="navbar navbar-static-top" role="navigation">
                <div class="container">
                    <div class="navbar-header jeesns-logo">
                        <button aria-controls="navbar" aria-expanded="false" data-target="#navbar" data-toggle="collapse"
                                class="navbar-toggle collapsed" type="button">
                            <i class="fa fa-reorder"></i>
                        </button>
                        <a href="/Aesopsns/index" class="navbar-brand"><img src="/Aesopsns/res/common/images/logo.png" height="50px" width="150"/></a>
                    </div>
                    <div class="navbar-collapse collapse" id="navbar">
                        <ul class="nav navbar-nav">
                            <li>
                                <a href="/"> 首页</a>
                            </li>
                            <li>
                                <a href="/article/list"> 文章</a>
                            </li>
                            <li>
                                <a href="/weibo/list"> 微博</a>
                            </li>
                            <li>
                                <a href="/group/"> 群组</a>
                            </li>
                            <li>
                                <a href="/action/list"> 动态</a>
                            </li>
                            <li>
                                <a href="/picture/"> 图库</a>
                            </li>
                        </ul>
                        <ul class="nav navbar-top-links navbar-right">
                            <div class="header-action-btn">
                                <li><a href="/Aesopsns/user/login">登录</a></li>
                                <li><a href="/Aesopsns/user/register">注册</a></li>
                            </div>
                        </ul>
                    </div>
                </div>
            </nav>-->
        </div>
<div class="animated fadeInDown">
    <div class="row login-panel">
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <div class="ibox-content">
                <h3>欢迎加入AESOPSNS</h3>
                <form class="m-t jeesns_form" action="/Aesopsns/user/doregist" method="post">
                
                    <div class="form-group">
                        用户名
                        <input type="text" id="name" name="name" class="form-control" placeholder="用户名" data-type="require"/>
                    </div>
                    <div class="form-group">
                        邮箱
                        <input type="email" id="mail" name="mail" class="form-control" placeholder="邮箱" data-type="require,email"/>
                    </div>
                    <div class="form-group">
                        密码
                        <input type="password" id="password" name="password" class="form-control" placeholder="密码" data-type="require"/>
                    </div>
                    <div class="form-group">
                        确认密码
                        <input type="password" name="repassword" class="form-control" placeholder="确认密码" data-type="require" data-rule="equal[password]"/>
                    </div>
                    <button type="submit" class="btn btn-primary block full-width m-b" onclick="infoCheck()">注册</button>
                    <p></p>
                    <p class="text-muted text-center">
                    <a href="/Aesopsns/user/forgotpassword">忘记密码?</a> | 
                    <a href="/Aesopsns/user/regist">我要注册</a>
            </div>
            </div>
        </div>
    </div>
</div>

<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/user_header.jspf"%>
<div id="popup"></div>

</body>

</html>