<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>积分明细 - AESOPSNS - Powered By AESOPSNS</title>
    <meta name="keywords" content="AESOPSNS,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
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

</head>
<body class="gray-bg">
<div id="wrapper">
    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
        
        <!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/user_header.jspf"%>
		
        </div>
<div class="wrapper wrapper-content">
<div class="container">
    <div class="row">
        <div class="ibox">
            <div class="ibox-content float-left">
                <div class="col-sm-2">
                    <div class="float-e-margins">
                        <div class="feed-activity-list">
                            <a href="/Aesopsns/user/uploadicon">
                                <div class="feed-element">
                                    <div class="media-body">
                                        修改头像
                                    </div>
                                </div>
                            </a>
                            <a href="/Aesopsns/user/editinfo">
                                <div class="feed-element">
                                    <div class="media-body">
                                        修改信息
                                    </div>
                                </div>
                            </a>
                            <a href="/Aesopsns/user/password">
                                <div class="feed-element">
                                    <div class="media-body">
                                        修改密码
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>    <div class="col-sm-10">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>积分明细</h5>
            </div>
            <div class="ibox-content">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>变动积分</th>
                        <th>备注</th>
                        <th>时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${currentuser.cdSet}" var="cd">
                    <tr>
                        <td>${cd.id }</td>
                        <td>${cd.alteration }</td>
                        <td>${cd.comment }</td>
                        <td>${cd.time }</td>
                    </tr>
                    <!-- <tr>
                        <td>1604</td>
                        <td>100</td>
                        <td>注册奖励</td>
                        <td>2018-03-30 19:22:45</td> -->
                    </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="box-footer clearfix">
                    <ul class="pagination pagination-sm no-margin pull-right"
                        url="/member/scoreDetail/list"
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
</div><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

		<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/footer.jspf"%>
		
		<script type="text/javascript">
    $(function () {
        $(".pagination").jeesns_page("jeesnsPageForm");
    });
</script>
</body>
</html>