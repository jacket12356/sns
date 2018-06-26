<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>AESOPSNS后台管理首页 - ${SITE_NAME} - AESOPSNS后台管理系统 - Powered By AESOPSNS</title>
    <meta name="keywords" content="${SITE_KEYS}"/>
    <meta name="description" content="${SITE_DESCRIPTION}"/>
    <meta name="author" content="AESOPSNS"/>
    <link href="/Aesopsns/res/common/css/bootstrap.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/font-awesome.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/manage/css/AdminLTE.css" rel="stylesheet">
    <link href="/Aesopsns/res/manage/css/skins/_all-skins.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="/Aesopsns/res/common/js/html5shiv.min.js"></script>
    <script src="/Aesopsns/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="/Aesopsns/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="/Aesopsns/res/common/js/bootstrap.min.js"></script>
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/Aesopsns/res/manage/js/app.js"></script>
    <script src="/Aesopsns/res/common/js/jeesns.js"></script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

<!-- 静态引用header -->
<%@ include file="/WEB-INF/webpages/manage/jspf/header.jspf"%>

    <div class="content-wrapper">
        <section class="content">
            <div class="box-body">
                <div class="row">
                    <div class="alert alert-info alert-dismissible">
                        感谢您使用AESOPSNS，AESOPSNS正在不断完善中，可以向我们提出宝贵的建议或意见，AESOPSNS的成长需要大家的支持。
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-body">
                            <p>
                                感谢您使用AESOPSNS，AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，
                                依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。
                                数据库使用MYSQL，全部源代码开放，官方网址：
                                <a href="http://www.jeesns.cn" target="_blank">www.jeesns.cn</a>。
                            </p>
                            <p>
                                <a class="btn btn-success"
                                   href="http://wpa.qq.com/msgrd?v=3&uin=582866070&site=qq&menu=yes" target="_blank">
                                    <i class="fa fa-qq"> </i> 联系我
                                </a>
                                <a class="btn btn-white btn-bitbucket" href="http://www.jeesns.cn" target="_blank">
                                    <i class="fa fa-home"></i> 访问官网
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-body">
                            <p>
                                技术支持：<a href="http://www.lxinet.com">AESOPSNS</a><br/>
                                产品交流：<a href="http://www.jeesns.cn">AESOPSNS社区（www.jeesns.cn）</a><br/>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-8">
                    <div class="box box-primary">
                        <div class="box-body">
                            <div class="col-sm-6">
                                <p>JAVA版本:${javaVersion}</p>
                                <p>MYSQL版本:${mysqlVersion}</p>
                                <p>WEB服务器:${webVersion}</p>
                                <p>CPU个数:${cpu}</p>
                                <p>虚拟机内存总量:${totalMemory}</p>
                                <p>虚拟机空闲内存量:${freeMemory}</p>
                                <p>虚拟机使用的最大内存量:${maxMemory}</p>
                            </div>
                            <div class="col-sm-6">
                                <p>客户端IP:${clientIP}</p>
                                <p>服务器IP:${serverIP}</p>
                                <p>操作系统:${osName}</p>
                                <p>用户主目录:${userHome}</p>
                                <p>工作目录:${userDir}</p>
                                <p>系统目录:${webRootPath}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="box box-primary">
                        <div class="box-body">
                            <p>系统支持:${systemName}</p>
                            <p>当前版本:${systemVersion}</p>
                            <p>当前版本更新时间:${systemUpdateTime}</p>
                            <p>最新版本:<span class="lastSystemVersion"></span> &nbsp;&nbsp;
                                <a href="http://www.jeesns.cn" target="_blank">官网查看</a></p>
                            <p>最新版本更新时间:<span class="lastSystemUpdateTime"></span></p>
                            <p>&nbsp;</p>
                            <p>&nbsp;</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                </div>
                <div class="col-md-4">
                </div>
                <div class="col-md-4">
            </div>
        </section>
    </div>
    
<!-- 静态引用footer -->
<%@ include file="/WEB-INF/webpages/manage/jspf/footer.jspf"%>
</div>
<script>
    $(document).ready(function () {
        $.getJSON("http://www.jeesns.cn/newVersion?callback=?", function(result){
            $(".lastSystemVersion").html(result.LAST_SYSTEM_VERSION);
            $(".lastSystemUpdateTime").html(result.LAST_SYSTEM_UPDATE_TIME);
        });
    });
</script>
</body>
</html>