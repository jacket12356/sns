<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>动态 - AESOPSNS - Powered By AESOPSNS</title>
    <meta name="keywords" content="jeesns,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
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
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.form.js"></script>
    <script src="/Aesopsns/res/common/js/jeesns.js"></script>
    <script src="/Aesopsns/res/common/js/extendPagination.js"></script>
    <script src="/Aesopsns/res/modules/mem.js"></script>
    <script src="/Aesopsns/res/plugins/js-emoji/emoji.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.timeago.js"></script>
</head>
<body class="gray-bg">

<!-- 静态引用header -->
<%@ include file="/WEB-INF/webpages/front/jspf/header.jspf"%>

<div class="container">
    <div class="main-content">
        <div class="row">
            <div class="col-md-12 white-bg m-b-10">
                <div class="items">
                <c:forEach items="${currentpagelist }" var="updating">
                 <div class="comment">
                        <a href="/Aesopsns/user/others/${updating.updater }" class="avatar" target="_blank">
                            <c:if test="${anotheruserdetail.icon == null }">
                        	<img src="/Aesopsns/res/common/images/default-avatar.png" class="icon-camera-retro icon-2x"/>
	                        </c:if>
	                        <c:if test="${anotheruserdetail.icon != null }">
	                        	<img src="/Aesopsns/res/common/uploads/${updating.icon}" class="icon-camera-retro icon-2x"/>
	                        </c:if>
                        </a>
                        <div class="content">
                            <div class="pull-right text-muted timeago" datetime="${updating.updatetime }"></div>
                            <div>
                                <a href="/Aesopsns/user/others/${updating.updater }" target="_blank">
                                    <strong><a href="/Aesopsns/user/others/${updating.updater }">${updating.updater }</a> </strong>于 ${updating.updatetime } 发布了<c:if test="${updating.type == 1 }">文章</c:if><c:if test="${updating.type == 2 }">群组帖子</c:if><c:if test="${updating.type == 3 }">微博</c:if>：<br/>
                                </a>
                            </div>
                            <div class="text emoji-render-content">
                            <c:if test="${updating.type == 1 }">
                            	<a href="/Aesopsns/article/detail/${updating.detailid }"
                                       target="_blank">${updating.title }</a>
                            </c:if>
                            <c:if test="${updating.type == 2 }">
                            	<a href="/Aesopsns/group/postdetail/${updating.detailid }"
                                       target="_blank">${updating.title }</a>
                            </c:if>
                            <c:if test="${updating.type == 3 }">
                            	<p>${updating.weibocontent }</p>
                                <a href="/Aesopsns/weibo/detail/${updating.detailid }" target="_blank">查看</a>
                            </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                   
                </div>
                <ul class="pager pagination pagination-sm no-margin pull-right"
                    url="/Aesopsns/updating/list"
                    currentPage="${updatingpage.currentPage }"
                    pageCount="${updatingpage.pageCount }">
                </ul>
            </div>
        </div>
    </div>
</div>

		<!-- 静态引用footer -->
		<%@ include file="/WEB-INF/webpages/front/jspf/footer.jspf"%>
		
<script type="text/javascript">
    $(function () {
        $(".pagination").jeesns_page("jeesnsPageForm");
    });
</script>
</body>
</html>