<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>图片 - JEESNS - Powered By JEESNS</title>
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
    <script src="/Aesopsns/res/front/js/jeesns.js"></script>
    <script src="/Aesopsns/res/common/js/extendPagination.js"></script>
    <script>
        var basePath = "";
    </script>
</head>
<body class="gray-bg">

		<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/header.jspf"%>
		
<div class="container">
    <div class="main-content">
        <div class="row">
            <div class="col-md-9 white-bg">
                <div class="panel-heading">
                    <a href="/member/picture/album">${album.username }的相册</a> > ${album.namess }
                    <span class="pull-right">
                        <a class="btn btn-primary m-t-n4" href="/Aesopsns/album/touploadpic?albumid=${album.id }" target="_jeesnsOpen" height="400px" width="1200px">上传图片</a>
                    </span>
                </div>
                <!-- 这里是相册照片列表 -->
                <div class="cards">
                    <!-- <div class="col-md-4 col-sm-6 col-lg-3">
                        <div class="card">
                            <a href="/picture/detail/236" class="picture" target="_jeesnsOpen" title="" height="90%" width="90%">
                                <img src="/upload/images/20180423/small_20c995c3-94ca-4156-b01d-ce218c27f6dd.PNG">
                            </a>
                            <div class="card-actions m-t-10">
                                <div class="text-danger"><i class="icon-heart-empty"></i> 1 人喜欢</div>
                            </div>
                        </div>
                    </div> -->
                    <c:forEach items="${aplist }" var="picture">
                    <div class="col-md-4 col-sm-6 col-lg-3">
                        <div class="card">
                            <a href="/Aesopsns/album/picturedetail/${picture.id }" class="picture" target="_jeesnsOpen" title="" height="90%" width="90%">
                                <img src="/Aesopsns/res/common/uploads/albumimage/${picture.image }">
                            </a>
                            <div class="card-actions m-t-10">
                                <div class="text-danger"><i class="icon-heart-empty"></i> ${picture.upvotes } 人喜欢</div>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
                <ul class="pager pagination pagination-sm no-margin pull-right"
                    url="/member/picture/list/696-580"
                    currentPage="1"
                    pageCount="1">
                </ul>
            </div>
            <div class="col-md-3">
                <div class="panel">
                    <div class="panel-body weibo-author">
                        <div class="avatar">
                            <a href="/Aesopsns/user/others/${album.username }" target="_blank">
                                <c:if test="${albumud.icon == null }">
		                        	<img src="/Aesopsns/res/common/images/default-avatar.png" alt="image" class="img-circle mg-l-30"/>
		                        </c:if>
		                        <c:if test="${albumud.icon != null }">
		                        	<img src="/Aesopsns/res/common/uploads/${albumud.icon}" alt="image" class="img-circle mg-l-30"/>
		                        </c:if>
                                </a>
                        </div>
                        <div class="name">
                            <a href="/Aesopsns/user/others/${album.username }"
                               target="_blank">${album.username }</a>
                        </div>
                        <div class="info">
                            <p>
                                <a href="/u/696/home/follows">${albumud.focus }
                                    关注</a> /
                                <a href="/u/696/home/fans">${albumud.fans }
                                    粉丝</a>
                            </p>
                            <p>
                            ${albumud.intro }
                            </p>
                            <p><strong>${album.username }(${album.num })</strong></p>
                            <div class="card"><img src="/Aesopsns/res/common/uploads/albumimage/${album.faces }"></div>
                        </div>
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