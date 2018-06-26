<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>jack12356主页 - AESOPSNS - Powered By AESOPSNS</title>
    <meta name="keywords" content="AESOPSNS,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
    <link href="/Aesopsns/res/common/css/bootstrap.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/Aesopsns/res/common/css/jeesns.css">
    <link rel="stylesheet" href="/Aesopsns/res/common/css/jeesns-skin.css">
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
    <script src="/Aesopsns/res/plugins/emoji/js/emojis.js"></script>
</head>

<body class="gray-bg">
<script>
//如果当前个人页面是本人的，就把私聊标签去掉
var curu = "${currentuser.name}";
var other = "${anotheruser.name}";
if(curu == other){
	$("#privatemessage").hide();
}
function focuss(){
	$.ajax({
		type : 'get',
		url : '/Aesopsns/user/follow',
		data: 'userr=user',
		//回调函数
		beforeSend: function () {
            index = jeesnsDialog.loading();
        },
		success : function(res){
			if(res.code < 0) {
				jeesnsDialog.errorTips(res.msg);
			}else{
				jeesnsDialog.closeAll();
				jeesnsDialog.successTips(res.msg);
				if(res.code == 0){
					$("#following").html("已关注");
				}else{
					$("#following").html("关注");
				}
			}
		}
	});
}
</script>
<div id="wrapper">
    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
        
        <!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/user_header.jspf"%>
		
        </div>
<div class="wrapper wrapper-content">
    <div class="member-banner" style="background-image: url(/Aesopsns/res/common/images/member_banner.png);">
        <div class="attempts"></div>
        <div class="container">
            <div class="container content">
                <div class="left">
                    <div class="avatar">
                        <!-- <img src="/Aesopsns/res/common/images/default-avatar.png" class="img-circle" width="80px" height="80px"/> -->
                        <c:if test="${anotheruserdetail.icon == null }">
                        	<img src="/Aesopsns/res/common/images/default-avatar.png" class="img-circle" width="80px" height="80px"/>
                        </c:if>
                        <c:if test="${anotheruserdetail.icon != null }">
                        	<img src="/Aesopsns/res/common/uploads/${anotheruserdetail.icon}" class="img-circle" width="80px" height="80px"/>
                        </c:if>
                    </div>
                    <div class="info">
                        <div class="name">
                        ${anotheruser.name }
                            <span class="sex">
                            <!-- <i class="fa fa-venus"></i> -->
                             <c:if test="${anotheruserdetail.sex == 'privacy'}">
                            <i class="fa fa-intersex"></i>
                            </c:if>
                            <c:if test="${anotheruserdetail.sex == 'male'}">
                            <i class="fa fa-mars"></i>
                            </c:if>
                            <c:if test="${anotheruserdetail.sex == 'female'}">
                            <i class="fa fa-venus"></i>
                            </c:if>
                            </span>
                        </div>
                        <p>cellphone: ${anotheruserdetail.cellphone }</p>
                        <p>introduction: ${anotheruserdetail.intro }</p>
                        <p class="operator">
                           <span onclick="focuss()"> <a class="label label-primary" href="javascript:void(0);">
                                <i class="fa fa-heart-o"></i> 
                                <c:if test="${isfollowed == true }">
                                <span id="following"">已关注</span>
                                </c:if>
                                <c:if test="${isfollowed == false }">
                                <span id="following">关注</span>
                                </c:if>
                            </a></span>
                            <a class="label label-primary" id="privatemessage" href="/Aesopsns/user/sendmessagebox?mail=${anotheruser.mail}" target="_jeesnsOpen" title="私信" height="285px">
                                <i class="fa fa-comments"></i> 私信
                            </a>
                        </p>
                    </div>
                </div>
                <div class="right">
                    <div class="follows">
                        <span>关注</span>
                        <a href="/u/696/home/follows">${anotheruserdetail.focus }</a>
                    </div>
                    <div class="fans">
                        <span>粉丝</span>
                        <a href="/u/696/home/fans">${anotheruserdetail.fans }</a>
                    </div>
                    <div class="score">
                        <span>积分</span>
                        <a href="/Aesopsns/user/creditdetail">${anotheruserdetail.credit }</a>
                    </div>
                    <div class="login-info">
                        加入时间:${anotheruserdetail.join_time }
                        最近登录:${anotheruserdetail.recent_login }

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
                                <a href="/Aesopsns/user/others/${anotheruser.name}">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            动态
                                        </div>
                                    </div>
                                </a>
                                <a href="/picture/album/696">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            相册
                                        </div>
                                    </div>
                                </a>
                                <a href="/Aesopsns/user/others/${anotheruser.name}/fans">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            粉丝
                                        </div>
                                    </div>
                                </a>
                                <a href="/Aesopsns/user/others/${anotheruser.name}/follows">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            关注
                                        </div>
                                    </div>
                                </a>
                                <a href="/Aesopsns/user/others/${anotheruser.name}?type=1">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            文章
                                        </div>
                                    </div>
                                </a>
                                <a href="/Aesopsns/user/others/${anotheruser.name}?type=2">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            群帖
                                        </div>
                                    </div>
                                </a>
                                <a href="/Aesopsns/user/others/${anotheruser.name}?type=3">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            微博
                                        </div>
                                    </div>
                                </a>
                                <a href="/u/696/home/group">
                                    <div class="feed-element">
                                        <div class="media-body">
                                            关注群组
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-10">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>粉丝</h5>
                            </div>
                            <div>
                           <!--  <div class="feed-element">
                                            <a href="/u/1" class="pull-left">
                                                <img alt="image" class="img-circle" src="/res/common/images/default-avatar.png">
                                            </a>
                                            <div class="media-body ">
                                                <h4><strong><a href="/u/1">admin</a></strong></h4>
                                                <p></p>
                                                <small class="text-muted">0关注 · 21粉丝</small>
                                            </div>
                            </div> -->
                            <c:forEach items="${fanslist }" var="follow">
                            	<div class="feed-element">
                                            <a href="/Aesopsns/user/others/${follow.user.name }" class="pull-left">
                                                <c:if test="${follow.ud.icon == null }">
                                                <img alt="image" class="img-circle" src="/Aesopsns/res/common/images/default-avatar.png"/>
						                        </c:if>
						                        <c:if test="${follow.ud.icon != null }">
						                        <img alt="image" class="img-circle" src="/Aesopsns/res/common/uploads/${follow.ud.icon}"/>
						                        </c:if>
                                            </a>
                                            <div class="media-body ">
                                                <h4><strong><a href="/Aesopsns/user/others/${follow.user.name }">${follow.user.name }</a></strong></h4>
                                                <p></p>
                                                <small class="text-muted">${follow.ud.focus }关注 · ${follow.ud.fans }粉丝</small>
                                            </div>
                            	</div>
                            </c:forEach>
                                <div class="feed-activity-list">
                                    <div class="box-footer clearfix">
                                        <ul class="pagination pagination-sm no-margin pull-right"
                                            url="/u/696"
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
</div>

		<!-- 静态引用footer -->
		<%@ include file="/WEB-INF/webpages/front/jspf/footer.jspf"%>
		
		<script type="text/javascript">
   /* $(function () {
        $(".pagination").jeesns_page("jeesnsPageForm");
        mem.isFollowed(696, "");
        $(".member-follows").click(function () {
            mem.follows($(this), "")
        });

    });*/
</script>
</body>
</html>