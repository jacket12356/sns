<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>群组 - JEESNS - Powered By JEESNS</title>
    <meta name="keywords" content="jeesns,sns,java"/>
    <meta name="description" content="JEESNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="JEESNS"/>
    <link href="/Aesopsns/res/common/css/zui.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/front/css/app.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="/Aesopsns/res/common/js/html5shiv.min.js"></script>
    <script src="/Aesopsns/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="/Aesopsns/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="/Aesopsns/res/common/js/zui.min.js"></script>
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.form.js"></script>
    <script src="/Aesopsns/res/common/js/jeesns.js"></script>
    <script src="/Aesopsns/res/common/js/extendPagination.js"></script>
</head>
<body class="gray-bg">

		<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/header.jspf"%>
		
<div class="container">
    <div class="main-content">
        <div class="row white-bg group-list">
            <div class="panel-heading" style="margin-bottom: 30px">
                群组
                <span class="pull-right">
                    <a class="btn btn-primary m-t-n4" href="/Aesopsns/group/toaddgroup">申请</a>
                </span>
            </div>
            <!-- <div class="col-md-3">
                <div class="group-detail">
                    <div class="group-logo">
                        <a href="/group/detail/33">
                            <img class="img-rounded" src="/Aesopsns/res/common/images/nopic.png" width="100px" height="100px">
                        </a>
                    </div>
                    <div class="group-info">
                        <h4><strong><a href="/group/detail/33">程序人生</a></strong></h4>
                        <p class="text-muted" title="">
                                
                        </p>
                        <small class="text-muted">1篇文章 · 1人关注</small>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="group-detail">
                    <div class="group-logo">
                        <a href="/group/detail/11">
                            <img class="img-rounded" src="/upload/images/20170306/14887779297105.png" width="100px" height="100px">
                        </a>
                    </div>
                    <div class="group-info">
                        <h4><strong><a href="/group/detail/11">js</a></strong></h4>
                        <p class="text-muted" title="js的工作园地">
                                js的工作园地
                        </p>
                        <small class="text-muted">1篇文章 · 24人关注</small>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="group-detail">
                    <div class="group-logo">
                        <a href="/group/detail/6">
                            <img class="img-rounded" src="/upload/images/20170208/14865394731375.jpg" width="100px" height="100px">
                        </a>
                    </div>
                    <div class="group-info">
                        <h4><strong><a href="/group/detail/6">Python</a></strong></h4>
                        <p class="text-muted" title="">
                                
                        </p>
                        <small class="text-muted">1篇文章 · 38人关注</small>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="group-detail">
                    <div class="group-logo">
                        <a href="/group/detail/5">
                            <img class="img-rounded" src="/upload/images/20170208/14865396015802.jpg" width="100px" height="100px">
                        </a>
                    </div>
                    <div class="group-info">
                        <h4><strong><a href="/group/detail/5">WEB前端</a></strong></h4>
                        <p class="text-muted" title="">
                                
                        </p>
                        <small class="text-muted">1篇文章 · 25人关注</small>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="group-detail">
                    <div class="group-logo">
                        <a href="/group/detail/4">
                            <img class="img-rounded" src="/upload/images/20170208/14865394185124.jpg" width="100px" height="100px">
                        </a>
                    </div>
                    <div class="group-info">
                        <h4><strong><a href="/group/detail/4">iOS</a></strong></h4>
                        <p class="text-muted" title="">
                                
                        </p>
                        <small class="text-muted">1篇文章 · 9人关注</small>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="group-detail">
                    <div class="group-logo">
                        <a href="/group/detail/3">
                            <img class="img-rounded" src="/upload/images/20170208/14865393897362.jpg" width="100px" height="100px">
                        </a>
                    </div>
                    <div class="group-info">
                        <h4><strong><a href="/group/detail/3">Android</a></strong></h4>
                        <p class="text-muted" title="">
                                
                        </p>
                        <small class="text-muted">1篇文章 · 12人关注</small>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="group-detail">
                    <div class="group-logo">
                        <a href="/group/detail/2">
                            <img class="img-rounded" src="/upload/images/20170208/14865393048883.png" width="100px" height="100px">
                        </a>
                    </div>
                    <div class="group-info">
                        <h4><strong><a href="/group/detail/2">JAVA</a></strong></h4>
                        <p class="text-muted" title="">
                                
                        </p>
                        <small class="text-muted">1篇文章 · 23人关注</small>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="group-detail">
                    <div class="group-logo">
                        <a href="/group/detail/1">
                            <img class="img-rounded" src="/upload/images/20170207/14864365554203.png" width="100px" height="100px">
                        </a>
                    </div>
                    <div class="group-info">
                        <h4><strong><a href="/group/detail/1">JEESNS讨论组</a></strong></h4>
                        <p class="text-muted" title="JEESNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。数据库使用MYSQL，全部源代码开放。">
                                JEESNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优...
                        </p>
                        <small class="text-muted">1篇文章 · 32人关注</small>
                    </div>
                </div>
            </div> -->
            
            <c:forEach items="${groups }" var="group">
            	<div class="col-md-3">
                <div class="group-detail">
                    <div class="group-logo">
                        <a href="/Aesopsns/group/detail/${group.id }">
                            <img class="img-rounded" src="/Aesopsns/res/common/uploads/groupimage/${group.face }" width="100px" height="100px">
                        </a>
                    </div>
                    <div class="group-info">
                        <h4><strong><a href="/Aesopsns/group/detail/${group.id }">${group.name }</a></strong></h4>
                        <p class="text-muted" title="${group.intro }">
                                ${group.intro }
                        </p>
                        <small class="text-muted">${group.articlenum }篇文章 · ${group.focus }人关注</small>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
        <ul class="pager pagination pagination-sm no-margin pull-right"
            url="/group/index"
            currentPage="1"
            pageCount="1">
        </ul>
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