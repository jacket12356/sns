<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>会员管理 - ${SITE_NAME} - JEESNS后台管理系统 - Powered By JEESNS</title>
    <meta name="keywords" content="${SITE_KEYS}"/>
    <meta name="description" content="${SITE_DESCRIPTION}"/>
    <meta name="author" content="JEESNS"/>
    <link href="${basePath}/res/common/css/bootstrap.min.css" rel="stylesheet">
    <link href="${basePath}/res/common/css/font-awesome.min.css" rel="stylesheet">
    <link href="${basePath}/res/manage/css/AdminLTE.css" rel="stylesheet">
    <link href="${basePath}/res/manage/css/skins/_all-skins.css" rel="stylesheet">
    <link href="${basePath}/res/plugins/webuploader/webuploader.css" rel="stylesheet">
    <link href="${basePath}/res/plugins/layer/skin/layer.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="${basePath}/res/common/js/html5shiv.js"></script>
    <script src="${basePath}/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="${basePath}/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="${basePath}/res/common/js/jquery.form.js"></script>
    <script src="${basePath}/res/common/js/bootstrap.min.js"></script>
    <script src="${basePath}/res/manage/js/app.js"></script>
    <script src="${basePath}/res/plugins/layer/layer.js"></script>
    <script src="${basePath}/res/common/js/jeesns.js"></script>
    <script src="${basePath}/res/common/js/extendPagination.js"></script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
<!-- 静态引用header -->
<%@ include file="/WEB-INF/webpages/manage/jspf/header.jspf"%>
    <div class="content-wrapper">
        <section class="content-header">
            <h1>会员管理(${usercount})</h1>
            <ol class="breadcrumb">
                <li><a href="${managePath}/manage/index"><i class="fa fa-dashboard"></i> 主页</a></li>
                <li class="active">会员管理</li>
            </ol>
        </section>
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box box-primary">
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>用户名</th>
                                    <th>邮箱</th>
                                    <th>密码</th>
                                    <th>注册时间</th>
                                    <th>最近登陆</th>
                                    <th width="150px">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${userlist }" var="member">
                                <tr>
                                    <td>${member.name }</td>
                                    <td>${member.email}</td>
                                    <td>${member.password}</td>
                                    <td>${member.jointime}</td>
                                    <td>${member.recentlogin}</td>
                                    <td>
                                        <a href="${managePath}/member/changepwd/${member.name}" target="_jeesnsOpen"
                                           title="修改密码" width="400px" height="300px">
                                            <span class="label label-info">修改密码</span>
                                        </a>
                                        <a class="marg-l-5" target="_jeesnsLink"
                                           href="${managePath}/member/delete/${member.name}" confirm="确定要删除会员吗？">
                                            <span class="label label-danger"><i class="fa fa-trash red"></i></span>
                                        </a>
                                    </td>
                                </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
<!-- 静态引用footer -->
<%@ include file="/WEB-INF/webpages/manage/jspf/footer.jspf"%>
</div>
<script type="text/javascript">
    $(function () {
        $(".pagination").jeesns_page("jeesnsPageForm");
    });
</script>
</body>
</html>