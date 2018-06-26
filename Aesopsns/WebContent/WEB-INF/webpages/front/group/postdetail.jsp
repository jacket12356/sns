<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${post.title }</title>
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
    <script>
        var basePath = "/Aesopsns";
        var base = "/Aesopsns";
        var groupPath = "/Aesopsns/group/detail/${post.groupid}";
        var groupTopicId = ${post.id};
    </script>
    <script src="/Aesopsns/res/front/js/group.js"></script>
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
                        <h1 class="text-center">
                        ${post.title }
                        <!-- 标签 -->
                        <!-- 
                            <span class="label label-badge label-primary">置顶</span>
                            <span class="label label-badge label-danger">精华</span> -->
                        </h1>
                        <dl class="dl-inline">
                            <dt></dt>
                            <dd>${post.publishtime }</dd>
                            <span class="label label-danger"><i class="icon-eye-open"></i> ${post.readcount }</span>
                            <dt></dt>
                            <dd class="pull-right">
                            </dd>
                        </dl>
                    </header>
                    <section class="content">
                    <p>${post.title }</p>

${content }
                    </section>
                </article>
                <div class="comments panel">
                    <div class="panel-heading">帖子评论</div>
                    <header>
                        <div class="reply-form">
                            <form class="form-horizontal"
                                  action="/Aesopsns/group/comment/${post.id }" method="post">
                                <div class="form-group">
                                    <textarea name="content" class="form-control new-comment-text" rows="2" placeholder="撰写评论..."></textarea>
                                </div>
                                <div class="form-group comment-user">
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
                <div class="group white-bg">
                    <div class="group-logo">
                        <img alt="${group.name }" src="/Aesopsns/res/common/uploads/groupimage/${group.face }" width="80px"
                             height="80px"/>
                    </div>
                    <div class="group-detail">
                        <p>
                            <span>
                                <strong>
                                <a href="/Aesopsns/group/detail/${group.id }">
                                    ${group.name }
                                </a>
                                </strong>
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
                    </div>
                    <div class="group-introduce">
                    
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel">
                    <div class="panel-body weibo-author">
                        <div class="avatar">
                            <a href="/Aesopsns/user/others/${publisher.name }" target="_blank">
                        <c:if test="${publisher.icon == null }">
                        	<img src="/Aesopsns/res/common/images/default-avatar.png" alt="image" class="img-circle mg-l-30" />
                        </c:if>
                        <c:if test="${publisher.icon != null }">
                        	<img src="/Aesopsns/res/common/uploads/${publisher.icon}" class="img-circle" alt="image" class="img-circle mg-l-30"/>
                        </c:if></a>
                        </div>
                        <div class="name">
                            <a href="/Aesopsns/user/others/${publisher.name }"
                               target="_blank">${publisher.name }</a>
                        </div>
                        <div class="info">
                            <p>
                            
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel">
                    <div class="panel-heading">
                        最新文章
                    </div>
                    <div class="panel-body article-hot-list">
                        <ul>
                                <li><i class="icon-hand-right main-text-color"></i> <a
                                        href="/article/detail/30596">Java日志框架：logback详解</a></li>
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
                                        href="/article/detail/30596">Java日志框架：logback详解</a></li>
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
        group.commentList(groupTopicId, pageNo);
        $("#moreComment").click(function () {
            pageNo++;
            group.commentList(articleId, pageNo);
        });
        $(".topic-favor").click(function () {
            group.favor($(this), "")
        });
    });
</script>
</body>
</html>