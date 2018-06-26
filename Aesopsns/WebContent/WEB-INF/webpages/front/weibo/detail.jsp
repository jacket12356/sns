<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${weibodetail.w.publisher }微博 - AESOPSNS - Powered By AESOPSNS</title>
    <meta name="keywords" content="jeesns,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
    <link href="/Aesopsns/res/common/css/zui.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/front/css/app.css" rel="stylesheet">
    <link href="/Aesopsns/res/plugins/gallery/css/blueimp-gallery.min.css" rel="stylesheet">
    <script>
        var basePath = "";
        var weiboId = ${weibodetail.w.id };
        var weiboPostMaxcontent = 140;
    </script>
    <!--[if lt IE 9]>
    <script src="/Aesopsns/res/common/js/html5shiv.min.js"></script>
    <script src="/Aesopsns/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="/Aesopsns/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="/Aesopsns/res/common/js/zui.min.js"></script>
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.form.js"></script>
    <script src="/Aesopsns/res/common/js/aesopsns.js"></script>
    <script src="/Aesopsns/res/plugins/js-emoji/emoji.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.timeago.js"></script>
    <script src="/Aesopsns/res/plugins/gallery/js/jquery.blueimp-gallery.min.js"></script>
    <script src="/Aesopsns/res/front/js/weibo.js"></script>
</head>
<body class="gray-bg">

		<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/header.jspf"%>
		
<div class="container">
    <div class="main-content">
        <div class="row">
            <div class="col-md-8">
                <article class="article weibo-detail">
                    <section class="content">
                        <div class="avatar">
                            <c:if test="${weibodetail.u.icon == null }">
	                        	<img src="/Aesopsns/res/common/images/default-avatar.png" class="img-circle mg-l-30"/>
	                        </c:if>
	                        <c:if test="${weibodetail.u.icon != null }">
	                        	<img src="/Aesopsns/res/common/uploads/${weibodetail.u.icon}" class="img-circle mg-l-30"/>
	                     	</c:if>
                        </div>
                        <div class="name">
                        ${weibodetail.u.name }
                        </div>
                        <div class="emoji-render-content">${weibodetail.w.content }</div>
                        <div class="lightBoxGallery">
                            <c:if test="${weibodetail.w.pictures != '' }">
                            <c:forEach items="${weibodetail.images }" var="image">
                                   <a href="/Aesopsns/res/common/uploads/weiboimage/${image }" title="${weibodetail.u.name }" data-gallery="">
                                      <img src="/Aesopsns/res/common/uploads/weiboimage/${image }" width="160px" height="160px"/>
                                   </a>
                            </c:forEach>
                            </c:if>
                            <div id="blueimp-gallery" class="blueimp-gallery">
                                <div class="slides"></div>
                                <h3 class="title"></h3>
                                <a class="prev">‹</a>
                                <a class="next">›</a>
                                <a class="close">×</a>
                                <a class="play-pause"></a>
                                <ol class="indicator"></ol>
                            </div>
                        </div>
                    </section>
                    <hr>
                    <div class="info">
                        <div class="left timeago" datetime="${weibodetail.w.publishtime }"></div>
                        <div class="right">
                            <a class="text-primary weibo-favor" weibo-id="${weibodetail.w.id }"><i
                                    class="icon icon-thumbs-o-up"></i> ${weibodetail.w.upvotes }</a>
                        </div>
                    </div>
                </article>
                <div class="comments panel">
                    <div class="panel-heading">评论(${weibodetail.w.comments })</div>
                    <header>
                        <div class="reply-form">
                            <form class="form-horizontal jeesns_form" action="/Aesopsns/weibo/comment/${weibodetail.w.id }" method="post">
                                <div class="form-group">
                                    <textarea name="content" class="form-control new-comment-text" rows="2" id="weibo-content" maxlength="140"></textarea>
                                </div>
                                <div class="form-group comment-user">
                                    <span id="weibo-words" class="mg-r-5">0/140</span>
                                    <input type="submit" value="评论" class="pull-right btn btn-primary mg-t-10 jeesns-submit">
                                </div>
                            </form>
                        </div>
                    </header>
                    <section class="comments-list" id="commentList">

                    </section>
                    <button class="btn btn-primary btn-block m" id="moreComment" style="display: none"><i
                            class="fa fa-arrow-down"></i> 加载更多
                    </button>
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel">
                    <div class="panel-body weibo-author">
                        <div class="avatar">
                            <img alt="image" class="img-circle mg-l-30" src="/Aesopsns/res/common/images/default-avatar.png"/>
                        </div>
                        <div class="name">
                            ${weibodetail.u.name }
                        </div>
                        <div class="info">
                            <p>
                                <a href="/Aesopsns/user/others/${weibodetail.u.name }/follows"> 关注</a> /
                                <a href="/Aesopsns/user/others/${weibodetail.u.name }/fans"> 粉丝</a>
                            </p>
                            <p>
                            
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
		<!-- 静态引用footer -->
		<%@ include file="/WEB-INF/webpages/front/jspf/footer.jspf"%>
		
		<script>
    $(document).ready(function () {
        var pageNo = 1;
        weibo.commentList(weiboId, pageNo);
        $("#moreComment").click(function () {
            pageNo++;
            weibo.commentList(weiboId, pageNo);
        });
        $(".weibo-favor").click(function () {
            weibo.favor($(this), "")
        });
    });
</script>
</body>
</html>