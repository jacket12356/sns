<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改资料 - AESOPSNS - Powered By AESOPSNS</title>
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
    <script src="/Aesopsns/res/plugins/My97DatePicker/WdatePicker.js"></script>
</head>

<body class="gray-bg">
<script>
function infoCheck(){
	var sex = $('input:checkbox:checked').val();
	var intro = $("#intro").val();
	if(sex != "" && intro != "") {  
		$.ajax({
    		type : 'post',
    		url : '/Aesopsns/user/editbaseinfo',
    		data : 'sex='+sex+'&intro='+intro,
    		//回调函数
    		success : function(info){
    			$("#popup").html(info);
    			setTimeout("deletee()",2000);
    		}
    	});
    }
}
function otherInfoCheck(){
	var birthday = $("#birthday").val();	
	var qq = $("#qq").val();
	var wechat = $("#wechat").val();
	var cellphone = $("#cellphone").val();
	var personal_web = $("#personal_web").val();
	if(birthday != "" || qq != "" || wechat != "" || cellphone != "" || personal_web != "") {  
		$.ajax({
    		type : 'post',
    		url : '/Aesopsns/user/editotherinfo',
    		data : 'birthday='+birthday+'&qq='+qq+'&wechat='+wechat+'&cellphone='+cellphone+'&personal_web='+personal_web,
    		//回调函数
    		success : function(info){
    			$("#popup").html(info);
    			setTimeout("deletee()",2000);
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
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>修改资料</h5>
            </div>
            <div class="ibox-content">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class="active"><a data-toggle="tab" href="tabs.html#tab-1">基本资料</a></li>
                        <li class=""><a data-toggle="tab" href="tabs.html#tab-2">个人资料</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane active">
                            <div class="panel-body">
                                <form class="form-horizontal m-t jeesns_form" action="/Aesopsns/user/editotherinfo"
                                      method="post">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">登录账号：</label>
                                        <div class="col-sm-8">
                                        ${currentuser.mail }	/	${currentuser.name }
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">昵称：</label>
                                        <!-- <div class="col-sm-8">
                                            <input id="name" name="name" class="form-control" type="text"
                                                   data-type="require" value="jack12356">
                                        </div> -->
                                        <div class="col-sm-8">
                                        ${currentuser.name }
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">性别：</label>
                                        <div class="col-sm-8">
                                        <c:if test="${userdetail.sex == 'privacy' }">
                                            <label><input type="radio" value="privacy" name="sex" 
                                                          checked/>
                                                <i></i> 保密</label>
                                            <label><input type="radio" value="male" name="sex"
                                                          > <i></i>
                                                男</label>
                                            <label><input type="radio" value="female" name="sex"
                                                          > <i></i>
                                                女</label>
                                        </c:if>
                                        <c:if test="${userdetail.sex == 'male' }">
                                        	<label><input type="radio" value="privacy" name="sex"
                                                          />
                                                <i></i> 保密</label>
                                            <label><input type="radio" value="male" name="sex"
                                                         checked > <i></i>
                                                男</label>
                                            <label><input type="radio" value="female" name="sex"
                                                          > <i></i>
                                                女</label>
                                        </c:if>
                                        <c:if test="${userdetail.sex == 'female' }">
                                        	<label><input type="radio" value="privacy" name="sex"
                                                          />
                                                <i></i> 保密</label>
                                            <label><input type="radio" value="male" name="sex"
                                                          > <i></i>
                                                男</label>
                                            <label><input type="radio" value="female" name="sex"
                                                         checked > <i></i>
                                                女</label>
                                        </c:if>
                                            
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">个人说明：</label>
                                        <div class="col-sm-8">
                                                    <textarea id="intro" name="intro" id="intro" class="form-control"
                                                              type="text" data-type="require"
                                                              cols="5">${userdetail.intro }</textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-8 col-sm-offset-2">
                                            <input type="submit" class="btn btn-primary block full-width m-b"
                                                   onclick="infoCheck()" value="修改">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div id="tab-2" class="tab-pane">
                            <div class="panel-body">
                                <form class="form-horizontal m-t jeesns_form"
                                      action="/Aesopsns/user/editotherinfo" method="post">
                                    <input name="id" class="form-control" type="hidden" dataType=""
                                           value="696">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">生日：</label>
                                        <div class="col-sm-8">
                                            <input id="birthday" name="birthday" type="text" class="form-control"
                                                   value="${userdetail.birthday }" onClick="WdatePicker()"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">QQ：</label>
                                        <div class="col-sm-8">
                                            <input id="qq" name="qq" class="form-control" type="text"
                                                   dataType="" value="${userdetail.qq }">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">微信：</label>
                                        <div class="col-sm-8">
                                            <input id="wechat" name="wechat" class="form-control" type="text"
                                                   dataType="" value="${userdetail.wechat }">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">联系电话：</label>
                                        <div class="col-sm-8">
                                            <input id="cellphone" name="cellphone" class="form-control"
                                                   type="text" dataType="" value="${userdetail.cellphone }">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">个人网站：</label>
                                        <div class="col-sm-8">
                                            <input id="personal_web" name="personal_web" class="form-control" type="text"
                                                   dataType="" value="${userdetail.personal_web }">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-8 col-sm-offset-2">
                                            <input type="submit"
                                                   class="btn btn-primary block full-width m-b jeesns-submit"
                                                   onclick="otherInfoCheck()" value="修改">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</div>
</div>
<div id="popup"></div>
<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/footer.jspf"%>
</div><script type="text/javascript">
    $('#birthday').datetimepicker();
</script>
</body>
</html>