<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="format-detection" content="telephone=no">
    <title>${picture.username }的图片 - AESOPSNS - Powered By AESOPSNS</title>
    <meta name="keywords" content="jeesns,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
    <link href="/Aesopsns/res/common/css/zui.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/front/css/app.css" rel="stylesheet">
    <style>
        html, body {margin: 0px;height: 100%;}
    </style>
    <script>
        var basePath = "/Aesopsns";
        var pageNo = 1;
        var pictureId = ${picture.id};
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
    <script src="/Aesopsns/res/front/js/jeesns.js"></script>
    <script src="/Aesopsns/res/front/js/picture.js"></script>
</head>

<body>
<div class="picture-detail">
    <div class="show-picture">
        <div class="pic">
            <img src="/Aesopsns/res/common/uploads/albumimage/${picture.image }">
        </div>
    </div>
    <div class="show-info">
        <div class="member-info">
            <div class="avatar">
                <a href="/Aesopsns/user/others/${picture.username }" target="_blank">
                   <!--  <img alt="image" class="img-circle mg-l-30" src="/upload/avatar/201804/fd41d0bd-6497-46a5-aa8b-86e39efe2ef6.jpg"/> -->
                    <c:if test="${icon == null }">
                    	<img src="/Aesopsns/res/common/images/default-avatar.png" alt="image" class="img-circle mg-l-30"/>
                    </c:if>
                    <c:if test="${icon != null }">
                    	<img src="/Aesopsns/res/common/uploads/${icon}" alt="image" class="img-circle mg-l-30"/>
                    </c:if>
                </a>
            </div>
            <div class="name">
                <strong><a href="/Aesopsns/user/others/${picture.username }" target="_blank">${picture.username }</a></strong>
                <p>上传于${picture.createdtime }</p>
            </div>
        </div>
        <div class="description emoji-render-content"></div>
        <div class="right">
            <a class="text-primary picture-favor" data-id="${picture.id }">
                <i class="icon icon-thumbs-up"></i> ${picture.upvotes }
            </a>
        </div>
        <form class="form-horizontal m-t" id="comment_form"
              action="/Aesopsns/album/picturecomment/${picture.id }" method="post">
            <textarea cols="5" class="form-control area emoji-render-input" name="content" id="content"></textarea>
            <div class="row emoji-container" id="emoji">
                <span class="pull-right p-r-10">
                    <input type="submit" value="评论" class="btn btn-primary">
                </span>
            </div>
        </form>
        <div class="comment-list"></div>
        <div class="more-comment"></div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        picture.commentList();
    })
</script>
</body>
</html>