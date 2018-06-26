<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${articledetail.title } - ${articledetail.tag } - AESOPSNS - Powered By AESOPSNS</title>
    <meta name="keywords" content="jeesns,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
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
</head>
<body class="gray-bg">

		<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/header.jspf"%>
		
<div class="container">
    <div class="main-content">
        <div class="row">
            <div class="col-md-8">
                <article class="article article-detail">
                    <header>
                        <h1 class="text-center">${articledetail.title }</h1>
                        <span class="dl-inline">
                            <dt></dt>
                            <dd>
                                <a href="/article/list?cid=6">
                                    <span class="label label-warning"><i
                                            class="icon icon-list-ul"></i> ${articledetail.tag }</span>
                                </a>
                                <span class="label label-danger"><i
                                        class="icon-eye-open"></i> ${articledetail.readcount }</span>
                                <i class="icon icon-time"></i> ${articledetail.publishtime }
                            </dd>
                            <dt></dt>
                            <dd class="pull-right">
                            </dd>
                        </span>
                    </header>
                    <section class="content">
					${content }
                    </section>
                    <div class="text-center">
                        <a class="btn btn-danger btn-article-favor article-favor" id="upvote" href="javascript:void(0)" article-id="30593">
                            <i class="icon-heart"></i> 喜欢 | ${articledetail.upvotes }
                        </a>
                </article>
                <!-- 文章评论 -->
                <div class="comments panel">
                    <div class="panel-heading">文章评论</div>
                    <header>
                        <div class="reply-form">
                            <form class="form-horizontal jeesns_form" action="/Aesopsns/article/comment/${articledetail.id }"
                                  method="post">
                                <div class="form-group">
                                    <textarea name="content" class="form-control new-comment-text" rows="2"
                                              placeholder="撰写评论..."></textarea>
                                </div>
                                <div class="form-group comment-user">
                                    <input type="submit" value="评论"
                                           class="pull-right btn btn-primary mg-t-10 jeesns-submit">
                                </div>
                            </form>
                        </div>
                    </header>
                    <section class="comments-list" id="commentList">
						<!-- <div class="comment">
							<a href="/u/696" class="avatar"><img src="/upload/avatar/201804/fd41d0bd-6497-46a5-aa8b-86e39efe2ef6.jpg" class="icon-4x"></a>
							<div class="content">
								<div class="pull-right text-muted">2018-04-20 04:26:12</div>
								<div>
									<a href="/u/696"><strong>jack12356</strong></a>
								</div>
								<div class="text">路过</div>
							</div>
						</div> -->
						<c:forEach items="${aclist }" var="commentt">
							<div class="comment">
							<a href="/Aesopsns/user/others/${commentt.username }" class="avatar">
								<!-- <img src="/upload/avatar/201804/fd41d0bd-6497-46a5-aa8b-86e39efe2ef6.jpg" class="icon-4x"> -->
								<c:if test="${publisher.icon == null }">
	                        	<img src="/Aesopsns/res/common/images/default-avatar.png" class="icon-4x"/>
		                        </c:if>
		                        <c:if test="${publisher.icon != null }">
		                        	<img src="/Aesopsns/res/common/uploads/${publisher.icon}" class="icon-4x"/>
		                        </c:if>
							</a>
							<div class="content">
								<div class="pull-right text-muted">${commentt.time }</div>
								<div>
									<a href="/Aesopsns/user/others/${commentt.username }"><strong>${commentt.username }</strong></a>
								</div>
								<div class="text">${commentt.content }</div>
							</div>
							</div>
						</c:forEach>
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
                            <a href="/Aesopsns/user/others/${articledetail.publisher }" target="_blank">
                                
                                <c:if test="${commentt.user.icon == null }">
	                        	<img alt="image" class="img-circle mg-l-30" src="/Aesopsns/res/common/images/default-avatar.png"/>
		                        </c:if>
		                        <c:if test="${commentt.user.icon != null }">
		                        <img alt="image" class="img-circle mg-l-30" src="/Aesopsns/res/common/uploads/${commentt.user.icon}"/>
		                        </c:if>
                            </a>
                                
                        </div>
                        <div class="name">
                            <a href="/Aesopsns/user/others/${articledetail.publisher }"
                               target="_blank">${articledetail.publisher }</a>
                        </div>
                        <div class="info">
                            <p>
                                <a href="/Aesopsns/user/others/${articledetail.publisher }/fans">
                                    关注</a> /
                                <a href="/Aesopsns/user/others/${articledetail.publisher }/fans">
                                    粉丝</a>
                            </p>
                            <p>
                            
                            </p>
                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="panel-heading">
                        文章栏目
                    </div>
                    <div class="panel-body">
                        <a href="/Aesopsns/article/list" class="btn btn-primary">全部</a>
                      <!--   <a href="/article/list?cid=10" class="btn btn-primary">Linux</a>
                        <a href="/Aesopsns/article/list?cid=9" class="btn btn-primary">Oracle</a>
                        <a href="/article/list?cid=8" class="btn btn-primary">Mysql</a> -->
                        <c:forEach items="${articlecates }" var="cate">
                        	<a href="/Aesopsns/article/list?catename=${cate.catename }" class="btn btn-primary">${cate.catename }</a>
                        </c:forEach>
                    </div>
                </div>
                <div class="panel">
                    <div class="panel-heading">
                        最新文章
                    </div>
                    <div class="panel-body article-hot-list">
                        <ul>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/30595">Spring 中获取 request 的几种方法，及其线程安全性分析</a></li>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/30594">Transaction在Controller层的探索</a></li>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/30593">详解react-router如何实现按需加载</a></li>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/30592">MySQL中一些优化straight_join技巧</a></li>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/30590">sql 修改表的所有者</a></li>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/30589">MySQL下PID文件丢失的相关错误的解决方法</a></li>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/30588">在Hadoop集群环境中为MySQL安装配置Sqoop的教程</a></li>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/30587">通过SQL语句直接把表导出为XML格式</a></li>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/30586">Mysql创建通用设备管理信息系统数据库</a></li>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/30585">MySQL入门教程（五）之表的创建、修改和删除</a></li>
                        </ul>
                    </div>
                </div>
                <div class="panel">
                    <div class="panel-heading">
                        热门文章
                    </div>
                    <div class="panel-body article-hot-list">
                        <ul>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/30595">Spring 中获取 request 的几种方法，及其线程安全性分析</a></li>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/30594">Transaction在Controller层的探索</a></li>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/9946">Thymeleaf模板表达式</a></li>
                        </ul>
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
        var _this = $("#upvote");
        //cms.commentList(articleId, pageNo);
        $("#moreComment").click(function () {
            pageNo++;
            cms.commentList(articleId, pageNo);
        });
        $(".article-favor").click(function () {
            $.ajax({
                url: "/Aesopsns/article/upvote/${articledetail.id}",
                type: "get",
                dataType: "json",
                timeout: 5000,
                success: function (res) {
                	if (res.code < 0) {
                        jeesnsDialog.errorTips(res.msg);
                    } else {
                        if (res.code == 0) {
                            _this.html("<i class='icon-heart'></i> 喜欢 | " + res.data);
                            _this.removeClass("btn-article-unfavor")
                        } else {
                            _this.html("<i class='icon-heart-empty'></i> 喜欢 | " + res.data);
                            _this.addClass("btn-article-unfavor");
                        }
                    }
                }
            });
        });
    });
</script>
</body>
</html>