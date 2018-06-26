<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>   
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心 - AESOPSNS - Powered By AESOPSNS</title>
    <meta name="keywords" content="AESOPSNS,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
    <link href="/Aesopsns/res/common/css/bootstrap.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/font-awesome.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/jeesns.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/jeesns-skin.css" rel="stylesheet">
    <link href="/Aesopsns/res/plugins/emoji/css/emoji.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="/Aesopsns/res/common/js/html5shiv.min.js"></script>
    <script src="/Aesopsns/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="/Aesopsns/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="/Aesopsns/res/common/js/bootstrap.min.js"></script>
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.form.js"></script>
    <script src="/Aesopsns/res/common/js/jeesns.js"></script>
    <script src="/Aesopsns/res/modules/weibo.js"></script>
    <script src="/Aesopsns/res/plugins/emoji/js/underscore-min.js"></script>
    <script src="/Aesopsns/res/plugins/emoji/js/editor.js"></script>
    <script src="/Aesopsns/res/plugins/emoji/js/emojis.js"></script>
    <script src="/Aesopsns/res/common/js/extendPagination.js"></script>
</head>

<body class="gray-bg">
<div id="wrapper">
    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
        
        <!-- 静态引用header 怎么搞的，用户页面的头部竟然和其它页面的头部不一样 -->
		<%@ include file="/WEB-INF/webpages/front/jspf/user_header.jspf"%>
        </div>
        
<div class="wrapper wrapper-content">
    <div class="member-banner" style="background-image: url(/Aesopsns/res/common/images/member_banner.png);">
        <div class="attempts"></div>
        <div class="container">
            <div class="container content">
                <div class="left">
                    <div class="avatar">
                      <!--   <img src="/Aesopsns/res/common/images/default-avatar.png" class="img-circle" width="80px" height="80px"/> -->
                      <c:if test="${userdetail.icon == null }">
                        	<img src="/Aesopsns/res/common/images/default-avatar.png" class="img-circle" width="80px" height="80px"/>
                        </c:if>
                        <c:if test="${userdetail.icon != null }">
                        	<img src="/Aesopsns/res/common/uploads/${userdetail.icon}" class="img-circle" width="80px" height="80px"/>
                        </c:if>
                    </div>
                    <div class="info">
                        <div class="name">
                        ${currentuser.name }
                            <span class="sex">
                            <c:if test="${userdetail.sex == 'privacy'}">
                            <i class="fa fa-intersex"></i>
                            </c:if>
                            <c:if test="${userdetail.sex == 'male'}">
                            <i class="fa fa-mars"></i>
                            </c:if>
                            <c:if test="${userdetail.sex == 'female'}">
                            <i class="fa fa-venus"></i>
                            </c:if>
                            </span>
                        </div>
                        <p>cellphone: ${userdetail.cellphone }</p>
                        <p>introduction: ${userdetail.intro }</p>
                        <p class="operator">
                            <a class="btn btn-info btn-outline member-follows" href="/Aesopsns/user/editinfo">
                                <i class="fa fa-edit"></i> 编辑个人资料
                            </a>
                        </p>
                    </div>
                </div>
                <div class="right">
                    <div class="follows">
                        <span>关注</span>
                        <a href="/u/696/home/follows">${userdetail.focus }</a>
                    </div>
                    <div class="fans">
                        <span>粉丝</span>
                        <a href="/u/696/home/fans">${userdetail.fans }</a>
                    </div>
                    <div class="follows">
                        <span>积分</span>
                        <a href="/Aesopsns/user/creditdetail">${userdetail.credit }</a>
                    </div>
                    <div class="login-info">
                        加入时间:${userdetail.join_time }
                        最近登录:${userdetail.recent_login }

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="ibox">
                <div class="ibox-content float-left">
                    <div class="col-sm-2">
                        <div class="float-e-margins">
                            <div class="feed-activity-list">
                            <!-- 个人页面才有私信啊 -->
                                <a href="/Aesopsns/user/privatemessage">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            私信
                                        </div>
                                    </div>
                                </a>
                                <a href="/Aesopsns/user/personal">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            动态
                                        </div>
                                    </div>
                                </a>
                                <a href="/Aesopsns/album/list/username">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            相册
                                        </div>
                                    </div>
                                </a>
                                <a href="/Aesopsns/user/others/${currentuser.name}/fans">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            粉丝
                                        </div>
                                    </div>
                                </a>
                                <a href="/Aesopsns/user/others/${currentuser.name}/follows">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            关注
                                        </div>
                                    </div>
                                </a>
                                <a href="/Aesopsns/user/personal?type=1">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            文章
                                        </div>
                                    </div>
                                </a>
                                <a href="/Aesopsns/user/personal?type=2">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            群帖
                                        </div>
                                    </div>
                                </a>
                                <a href="/Aesopsns/user/personal?type=3">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            微博
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-10">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>${title }</h5>
                            </div>
                            <div>
                                <div class="feed-activity-list">
                                <c:forEach items="${updatings }" var="updating">
                                <div class="feed-element">
                                     <a href="/Aesopsns/user/others/${updating.updater }" class="pull-left">
                                         <c:if test="${anotheruserdetail.icon == null }">
			                        	<img src="/Aesopsns/res/common/images/default-avatar.png"  class="img-circle"/>
				                        </c:if>
				                        <c:if test="${anotheruserdetail.icon != null }">
				                        	<img src="/Aesopsns/res/common/uploads/${updating.icon}" class="img-circle"/>
				                        </c:if>
                                     </a>
                                     <div class="media-body ">
                                         <small class="pull-right text-navy"> ${updating.updatetime } </small>
                                         <a href="/Aesopsns/user/others/${updating.updater }"><strong>${updating.updater }</strong></a>发布了<c:if test="${updating.type == 1 }">文章</c:if><c:if test="${updating.type == 2 }">群组帖子</c:if><c:if test="${updating.type == 3 }">微博</c:if>：<br/>
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
                                         <br>
                                         <div class="actions">
                                         </div>
                                     </div>
                                 </div>
                                 </c:forEach>
                                    <div class="box-footer clearfix">
                                        <ul class="pagination pagination-sm no-margin pull-right"
                                            url="/member/"
                                            currentPage="1"
                                            pageCount="1">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
       
    </div>
</div> <br/><br/><br/>
<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/footer.jspf"%>
<script type="text/javascript">
    $(function () {
        $(".pagination").jeesns_page("jeesnsPageForm");
    });
</script>
</body>
</html>