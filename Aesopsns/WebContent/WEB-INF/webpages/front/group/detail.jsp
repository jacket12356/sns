<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JEESNS讨论组 - 群组 - JEESNS - Powered By JEESNS</title>
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
        <div class="row">
            <div class="col-md-8">
                <div class="group white-bg">
                    <div class="group-logo">
                        <img alt="${group.name }" src="/Aesopsns/res/common/uploads/groupimage/${group.face }" width="80px" height="80px"/>
                    </div>
                    <div class="group-detail">
                        <p>
                            <span>
                                <strong>${group.name }</strong>
                            </span>
                            <!-- 群组关注功能，关注群组之后才能在该群组发帖 -->
                            <c:if test="${isfollowed }">
                            	<span class="text-right">
                                    <a title="取消关注" href="/Aesopsns/group/follow/${group.id }"
                                       target="_jeesnsLink"><i class="icon-minus"></i> 取消关注</a>
                           		</span>
                            </c:if>
                            <c:if test="${isfollowed == false}">
                            	<span class="text-right">
                                    <a title="添加关注" href="/Aesopsns/group/follow/${group.id }" target="_jeesnsLink"><i
                                            class="icon-plus"></i> 关注</a>
                            	</span>
                            </c:if>
                        </p>
                        <p>${group.articlenum }帖子 · ${group.focus }关注</p>
                        <p><a href="/Aesopsns/user/others/${group.creator }">${group.creator }</a>
                            创建于${group.createdtime }</p>
                    </div>
                    <div class="group-introduce">
                    ${group.intro }
                    </div>
                </div>
                <div class="panel group-topic-list no-border">
                    <div class="panel-heading">
                        全部
                        <span class="pull-right">
                            <a class="btn btn-primary m-t-n4" href="/Aesopsns/group/topost/1" target="_jeesnsLink">发帖</a>
                        </span>
                    </div>
                    <div class="panel-body">
                        <div class="items">
                        <!-- 这里是帖子列表 -->
                           <!--   <div class="item">
                                <div class="item-content">
                                    <div class="media pull-left">
                                        <img src="/Aesopsns/res/common/images/default-avatar.png" class="img-circle"
                                             alt="admin" width="50px" height="50px">
                                    </div>
                                    <div class="text">
                                        <p>
                                        <h4>
                                            <a href="/group/topic/492">JEESNS V1.2.0-RC3 发布，Java 开源 SNS 社区系统</a>
                                            // 这个是帖子标签，是帖子排序的依据 
                                            <span class="label label-badge label-success">超级置顶</span>
                                            <span class="label label-badge label-danger">精华</span>
                                            <span class="label label-badge label-primary">置顶</span>
                                        </h4>
                                        </p>
                                        <p>
                                            <a href="/group/topic/492" class="text-muted"><i
                                                    class="icon-eye-open"></i> 541</a> &nbsp;
                                            <span class="text-muted">2017-10-16 14:30</span>
                                        </p>
                                    </div>
                                </div>
                            </div> -->
                            <c:forEach items="${postlist }" var="post">
                            	<div class="item">
                                <div class="item-content">
                                    <div class="media pull-left">
                                        <c:if test="${post.icon != null }">
                                        <img src="/Aesopsns${post.icon }" class="img-circle"
                                             alt="admin" width="50px" height="50px">
                                        </c:if>
                                        <c:if test="${post.icon == null }">
                                        <img src="/Aesopsns/res/common/images/default-avatar.png" class="img-circle"
                                             alt="admin" width="50px" height="50px">
                                        </c:if>
                                    </div>
                                    <div class="text">
                                        <p>
                                        <h4>
                                            <a href="/Aesopsns/group/postdetail/${post.id }">${post.title }</a>
                                            <!-- 这个是帖子标签，是帖子排序的依据
                                            <span class="label label-badge label-success">超级置顶</span>
                                            <span class="label label-badge label-danger">精华</span>
                                            <span class="label label-badge label-primary">置顶</span>  --> 
                                        </h4>
                                        </p>
                                        <p>
                                            <a href="/Aesopsns/group/postdetail/${post.id }" class="text-muted"><i
                                                    class="icon-eye-open"></i> ${post.readcount }</a> &nbsp;
                                            <span class="text-muted">${post.publishtime }</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                        </div>
                    </div>
                    <ul class="pager pagination pagination-sm no-margin pull-right"
                        url="/Aesopsns/group/detail/${group.id }"
                        currentPage="${postpage.currentPage }"
                        pageCount="${postpage.totalCount }">
                    </ul>
                </div>
            </div>
            <div class="col-md-4 float-left">
                <div class="panel group-detail-fans">
                    <div class="panel-heading">
                        粉丝(${group.focus })
                    </div>
                    <div class="panel-body list">
                        <!-- <div class="fan">
                            <div class="avatar">
                                <a href="/u/696" target="_blank">
                                    <img class="img-circle" src="/upload/avatar/201804/fd41d0bd-6497-46a5-aa8b-86e39efe2ef6.jpg" width="50px"
                                         height="50px"/>
                                </a>
                            </div>
                            <div class="name">
                                <a href="/u/696" target="_blank">
                                    jack12356
                                </a>
                            </div>
                        </div> -->
                        <c:forEach items="${gflist }" var="gf">
                        <div class="fan">
                            <div class="avatar">
                                <a href="/Aesopsns/user/others/${gf.follower }" target="_blank">
                                    <c:if test="${gf.followericon == null }">
			                        	<img src="/Aesopsns/res/common/images/default-avatar.png" class="img-circle" width="50px"
                                         height="50px"/>
			                        </c:if>
			                        <c:if test="${gf.followericon != null }">
			                        	<img src="/Aesopsns/res/common/uploads/${gf.followericon}" class="img-circle" width="50px"
                                         height="50px"/>
			                        </c:if>
                                </a>
                            </div>
                            <div class="name">
                                <a href="/Aesopsns/user/others/${gf.follower }" target="_blank">
                                    ${gf.follower }
                                </a>
                            </div>
                        </div>
                        </c:forEach>
                    </div>
                </div>
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