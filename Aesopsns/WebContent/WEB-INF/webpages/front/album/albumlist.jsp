<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>相册 - JEESNS - Powered By JEESNS</title>
    <meta name="keywords" content="jeesns,sns,java"/>
    <meta name="description" content="JEESNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="JEESNS"/>
    <link href="/Aesopsns/res/common/css/zui.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/front/css/app.css" rel="stylesheet">
    <script type="text/javascript">
        var basePath = "";
    </script>
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
    <!-- 下面的是为右键菜单准备的 -->
    <script src="/Aesopsns/res/common/js/jquery.contextmenu.r2.js"></script>
    <script type="text/javascript">
	$(document).ready(function() {
	
		$('.demo1').contextMenu('myMenu1',{
			bindings:{
				'open': function(t){
					alert('Trigger was '+t.id+'\nAction was Open');
				},
				'email': function(t){
					alert('Trigger was '+t.id+'\nAction was Email');
				},
				'save': function(t){
					alert('Trigger was '+t.id+'\nAction was Save');
				},
				'delete': function(t){
					alert('Trigger was '+t.id+'\nAction was Delete');
				}
			}
		});
	
	});
	</script>
	
	<script>
	function deleteAlbum(id){
		$.ajax({
    		type : 'post',
    		url : '/Aesopsns/album/delete',
    		data : 'albumid='+id,
    		success : function(albumid){
    			var album = "album" + id;
   				$("#" + album).remove();
    		}
    	});
	}
	</script>


    
</head>
<body class="gray-bg">
<!-- 这是右键菜单主体 -->
<div class="contextMenu" id="myMenu1">
	<ul>
		<li id="delete"><img src="/Aesopsns/res/common/images/cross.png" /> Delete</li>
	</ul>
</div>


		<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/header.jspf"%>
		
<div class="member-banner" style="background-image: url(/Aesopsns/res/common/images/member_banner.png);">
    <div class="attempts"></div>
    <div class="container">
        <div class="container content">
            <div class="left">
                <div class="avatar">
                    <div class="avatar">
                        <!-- <img src="/Aesopsns/res/common/images/default-avatar.png" class="img-circle" width="80px" height="80px"/> -->
                        <c:if test="${usersdetail.icon == null }">
                        	<img src="/Aesopsns/res/common/images/default-avatar.png" class="img-circle" width="80px" height="80px"/>
                        </c:if>
                        <c:if test="${usersdetail.icon != null }">
                        	<img src="/Aesopsns/res/common/uploads/${usersdetail.icon}" class="img-circle" width="80px" height="80px"/>
                        </c:if>
                    </div>
                </div>
                <div class="info">
                    <div class="name">
                    ${user.name }
                    </div>
                    <p>${usersdetail.cellphone }</p>
                        <p>${usersdetail.intro }</p>
                    <p class="operator">
                        <!-- 个人管理，user 不为空 -->
                       	<c:if test="${mode == 1 }">
                       	<a class="btn btn-info btn-outline member-follows" href="/Aesopsns/user/personal">
                           	<i class="fa fa-home"></i> 个人中心
                       	</a>
                       	</c:if>
                       	<!-- 查看其他人，otheruser -->
                       	<c:if test="${mode == 2 }">
                           <span onclick="focuss()"> <a class="label label-primary" href="javascript:void(0);">
                               <i class="fa fa-heart-o"></i> 
                               <c:if test="${isfollowed == true }">
                               		<span id="following">已关注</span>
                               </c:if>
                               <c:if test="${isfollowed == false }">
                               		<span id="following">关注</span>
                               </c:if>
                           </a></span> 
                       </c:if>
                    </p>
                </div>
            </div>
            <div class="right">
                    <div class="follows">
                        <span>关注</span>
                        <a href="/u/696/home/follows">${usersdetail.focus }</a>
                    </div>
                    <div class="fans">
                        <span>粉丝</span>
                        <a href="/u/696/home/fans">${usersdetail.fans }</a>
                    </div>
                    <div class="score">
                        <span>积分</span>
                        <a href="/Aesopsns/user/creditdetail">${usersdetail.credit }</a>
                    </div>
                    <div class="login-info">
                        加入时间:${usersdetail.join_time }
                        最近登录:${usersdetail.recent_login }

                    </div>
                </div>
        </div>
    </div>
</div>

<!-- 相册主体，其它我都是从others那取的 -->
    <div class="container white-bg">
    <div class="main-content">
        <div class="row">
            <div class="no-border">
                <div class="panel-heading">
                    	相册列表
                    <span class="pull-right">
                        <a class="btn btn-primary m-t-n4" href="/Aesopsns/album/add" target="_jeesnsOpen" height="360px">新建相册</a>
                    </span>
                </div>
                <div class="panel-body">
                    <div class="cards cards-borderless">
                       <!-- 
                        <div class="col-md-3 col-sm-6 col-lg-2">
                            <a class="card" href="/member/picture/list/696-578">
                                <img src="/upload/images/20180422/small_fa6b68b5-6657-4202-bd24-787418496f83.PNG">
                                <div class="card-heading"><strong>微博配图</strong></div>
                                <div class="card-actions">
                                    <div class="pull-right text-danger"><i class="icon-heart-empty"></i> 0 人喜欢</div>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-3 col-sm-6 col-lg-2">
                            <a class="card" href="/member/picture/list/696-574">
                                <img src="/res/common/images/empty_album.png">
                                    <div class="caption">air</div>
                                <div class="card-heading"><strong>la</strong></div>
                                <div class="card-actions">
                                    <div class="pull-right text-danger"><i class="icon-heart-empty"></i> 0 人喜欢</div>
                                </div>
                            </a>
                        </div> -->
                        <c:forEach items="${albumlist }" var="album">
                        	<div class="col-md-3 col-sm-6 col-lg-2 demo1" id="album${album.id }">
                            <a class="card" href="/Aesopsns/album/detail/${album.id }">
                            <c:if test="${album.faces == null }">
                            	<img src="/Aesopsns/res/common/images/empty_album.png"/>
	                        </c:if>
	                        <c:if test="${album.faces != null }">
	                        	<!-- 这里待会要调一下尺寸 -->
	                        	<img src="/Aesopsns/res/common/uploads/albumimage/${album.faces }"/>
	                        </c:if>
                                    <div class="caption">${album.intro }</div>
                                		<div class="card-heading"><strong>${album.namess }</strong></div>
                            </a><a href="javascript:void();" class="card" >
                                		<div class="card-actions">
                                    <div class="pull-left text-danger" onclick="deleteAlbum(${album.id })">删除</div>
                                    <div class="pull-right text-danger"><i class="icon-heart-empty"></i> ${album.upvotes } 人喜欢</div>
                                </div></a>
                            
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

</body>
</html>