<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="format-detection" content="telephone=no">
    <title>图库 - JEESNS - Powered By JEESNS</title>
    <meta name="keywords" content="jeesns,sns,java"/>
    <meta name="description" content="JEESNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="JEESNS"/>
    <link href="/Aesopsns/res/common/css/zui.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/front/css/app.css" rel="stylesheet">
    <script>
        var basePath = "/Aesopsns";
    </script>
    <!--[if lt IE 9]>
    <script src="/Aesopsns/res/common/js/html5shiv.min.js"></script>
    <script src="/Aesopsns/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="/Aesopsns/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="/Aesopsns/res/common/js/bootstrap.min.js"></script>
    <script src="/Aesopsns/res/common/js/zui.min.js"></script>
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.form.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.masonry.min.js"></script>
    <script src="/Aesopsns/res/common/js/jqeasing.js"></script>
    <script src="/Aesopsns/res/front/js/jeesns.js"></script>
    <script src="/Aesopsns/res/front/js/picture.js"></script>
</head>

<body class="gray-bg">

		<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/header.jspf"%>
		
<div class="picture-content">
    <div class="waterfull clearfloat" id="waterfull">
        <ul id="pictures">
                <!-- <li class="item">
                    <a href="/picture/detail/235" class="picture" target="_jeesnsOpen" title="" height="90%" width="90%">
                        <img src="/upload/images/20180423/small_06a434f4-5964-46ac-ad9f-0f49d311ce90.PNG">
                    </a>
                    <p class="description"></p>
                    <div class="qianm clearfloat">
                        <span class="sp1">
                            <a href="/u/696" target="_blank">jack12356</a>
                            <b>
                            <a class="text-primary picture-favor" data-id="235"><i
                                    class="icon icon-thumbs-o-up"></i> 0</a>
                            </b>
                        </span>
                        <span class="sp2">2018-04-23 08:23:28</span>
                    </div>
                </li> -->
                <c:forEach items="${aplist }" var="ap">
                	<li class="item">
                    <a href="/Aesopsns/album/picturedetail/${ap.id }" class="picture" target="_jeesnsOpen" title="" height="90%" width="90%">
                        <img src="/Aesopsns/res/common/uploads/albumimage/${ap.image }">
                    </a>
                    <p class="description"></p>
                    <div class="qianm clearfloat">
                        <span class="sp1">
                            <a href="/Aesopsns/user/others/${ap.username }" target="_blank">${ap.username }</a>
                            <b>
                            <a class="text-primary picture-favor" data-id="235"><i
                                    class="icon icon-thumbs-o-up"></i> ${ap.upvotes }</a>
                            </b>
                        </span>
                        <span class="sp2">${ap.createdtime }</span>
                    </div>
                </li>
                </c:forEach>
        </ul>
    </div>
    <div id="imloading" class="picture-load">
        加载中.....
    </div>
</div>
		<!-- 静态引用footer -->
		<%@ include file="/WEB-INF/webpages/front/jspf/footer.jspf"%>
		
<script type="text/javascript">
    $(function(){
        picture.waterfull();
    })
</script>
</body>
</html>