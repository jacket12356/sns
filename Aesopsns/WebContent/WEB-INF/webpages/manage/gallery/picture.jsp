<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>图片管理 - ${SITE_NAME} - JEESNS后台管理系统 - Powered By JEESNS</title>
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
            <h1>图片管理</h1>
            <ol class="breadcrumb">
                <li><a href="${managePath}/index"><i class="fa fa-dashboard"></i> 主页</a></li>
                <li class="active">图片管理</li>
            </ol>
        </section>
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box box-primary">
                        <div class="box-header">

                        </div>
                        <div class="box-body no-padding">
                            <ul class="mailbox-attachments clearfix">
                            <c:forEach items="${pictures }" var="picture">
                                    <li>
                                        <span class="mailbox-attachment-icon has-img">
                                            <img src="/Aesopsns/res/common/uploads/albumimage/${picture.image }" style="max-width: 100%;height: 160px;">
                                        </span>
                                        <div class="mailbox-attachment-info">
                                            <a href="/Aesopsns/album/picturedetail/${picture.id }" target="_blank">${picture.username}</a>
                                                <a class="text-primary picture-favor" data-id="${picture.id}"><i
                                                        class="fa fa-thumbs-o-up"></i> ${picture.upvotes}</a>
                                            <p><span class="sp2">${picture.createdtime}</span></p>
                                            <span class="mailbox-attachment-size">
                                                 <a class="marg-l-5" target="_jeesnsLink" href="${managePath}/picture/delete/${picture.id}" confirm="确定要删除图片吗？">
                                                    <span class="label label-danger"><i class="fa fa-trash red"></i></span>
                                                </a>
                                            </span>
                                        </div>
                                    </li>
                            </c:forEach>
                            </ul>
                        </div>
                        <div class="box-footer">
                            <ul class="pagination pagination-sm no-margin pull-right"
                                url="${managePath}/picture/list"
                                currentPage="${model.page.pageNo}"
                                pageCount="${model.page.totalPage}">
                            </ul>
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

