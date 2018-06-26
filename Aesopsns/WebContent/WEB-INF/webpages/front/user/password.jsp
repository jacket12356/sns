<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改密码 - AESOPSNS - Powered By AESOPSNS</title>
    <meta name="keywords" content="AESOPSNS,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
    <link href="/Aesopsns/res/common/css/bootstrap.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/Aesopsns/res/common/css/jeesns.css">
    <link rel="stylesheet" href="/Aesopsns/res/common/css/jeesns-skin.css">
    <!--[if lt IE 9]>
    <script src="/Aesopsns/res/common/js/html5shiv.min.js"></script>
    <script src="/Aesopsns/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="/Aesopsns/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="/Aesopsns/res/common/js/bootstrap.min.js"></script>
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.form.js"></script>
    <script src="/Aesopsns/res/common/js/jeesns.js"></script>
</head>

<body class="gray-bg">
<script>
function infoCheck(){
	var oldpassword = $("#oldpassword").val();
	var repassword = $("#newPassword").val();
	if(oldpassword != "" && repassword != "") {  
		$.ajax({
    		type : 'post',
    		url : '/Aesopsns/user/editpassword',
    		data : 'oldpassword='+oldpassword+'&repassword='+repassword,
    		//回调函数
    		success : function(error){
    			if(error != "") {
    				$("#popup").html(error);
    				setTimeout("deletee()",2000);
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
<div class="wrapper wrapper-content">
<div class="container">
    <div class="row">
        <div class="ibox">
            <div class="ibox-content float-left">
                <div class="col-sm-2">
                    <div class="float-e-margins">
                        <div class="feed-activity-list">
                            <a href="/Aesopsns/user/uploadicon">
                                <div class="feed-element">
                                    <div class="media-body">
                                        修改头像
                                    </div>
                                </div>
                            </a>
                            <a href="/Aesopsns/user/editinfo">
                                <div class="feed-element">
                                    <div class="media-body">
                                        修改信息
                                    </div>
                                </div>
                            </a>
                            <a href="/Aesopsns/user/password">
                                <div class="feed-element">
                                    <div class="media-body">
                                        修改密码
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>    <div class="col-sm-9">
        <div class="ibox-title">
            <h5>修改密码</h5>
        </div>
        <div class="ibox-content">
            <form class="form-horizontal m-t jeesns_form" action="" method="post">
                <div class="form-group">
                    <label class="col-sm-2 control-label">旧密码：</label>
                    <div class="col-sm-8">
                        <input id="oldpassword" name="oldpassword" class="form-control" type="password"
                               data-type="require" alt="密码">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">新密码：</label>
                    <div class="col-sm-8">
                        <input id="newPassword" name="repassword" class="form-control" type="password"
                               data-type="require" alt="新密码">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">确认新密码：</label>
                    <div class="col-sm-8">
                        <input id="renewPassword" name="renewpassword" class="form-control" type="password"
                               data-type="require" data-rule="equal[newPassword]" alt="两次密码必须一致">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-8 col-sm-offset-2">
                        <input type="submit" class="btn btn-primary block full-width m-b jeesns-submit" value="修改密码" onclick="infoCheck()">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</div>
</div>
</div>
</div><div id="popup"></div>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<!-- 静态引用footer -->
		<%@ include file="/WEB-INF/webpages/front/jspf/footer.jspf"%>
		</body>

</html>