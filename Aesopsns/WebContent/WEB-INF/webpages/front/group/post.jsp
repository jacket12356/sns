<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <title>发帖 - JEESNS讨论组 - JEESNS - Powered By JEESNS</title>
    <link href="/Aesopsns/res/common/css/zui.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/front/css/app.css" rel="stylesheet">
    <link href="/Aesopsns/res/plugins/webuploader/webuploader.css" rel="stylesheet">
    <link href="/Aesopsns/res/plugins/layer/skin/layer.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="/Aesopsns/res/common/js/html5shiv.js"></script>
    <script src="/Aesopsns/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="/Aesopsns/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.form.js"></script>
    <script src="/Aesopsns/res/common/js/zui.min.js"></script>
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/Aesopsns/res/front/js/jeesns.js"></script>
    <script src="/Aesopsns/res/plugins/webuploader/webuploader.min.js"></script>
    <script src="/Aesopsns/res/plugins/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
        var basePath = "/Aesopsns";
        var uploadServer = "/Aesopsns/group/uploadimage";
        $(function () {
            CKEDITOR.replace('content');
        });
    </script>
    <script src="/Aesopsns/res/plugins/webuploader/upload.js"></script>
</head>
<body class="gray-bg">
		<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/header.jspf"%>
		
<div class="container">
    <div class="main-content">
        <div class="row">
            <div class="col-md-12 article-detail">
                <form class="form-horizontal jeesns_form" role="form" action="/Aesopsns/group/posting" method="post" onsubmit="ckUpdate();">
                    <input type="hidden" name="groupid" value="${groupid }">
                    <div class="form-group">
                        <label class="col-sm-1 control-label">标题</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="title" name="title" placeholder="标题" data-type="require">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">帖子分类</label>
                        <div class="col-sm-3">
                            <select class="form-control" name="typeId">
                                <option value="" selected>不选择分类</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">缩略图</label>
                        <div class="col-sm-10">
                            <div id="uploader" class="wu-example">
                                <!--用来存放文件信息-->
                                <input type="hidden" id="thumbnail" name="thumbnail">
                                <div id="preview" class="uploader-list"></div>
                                <div id="imagesList" class="uploader-list"></div>
                                <div class="btns">
                                    <div id="picker">选择文件</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">描述</label>
                        <div class="col-sm-8">
                            <textarea class="form-control" rows="3" name="description" alt="描述"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">内容</label>
                        <div class="col-sm-10">
                            <textarea class="ckeditor" cols="80" id="content" name="content" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-1 col-sm-10">
                            <button type="submit" class="btn btn-info jeesns-submit">保存</button>
                            <a href="/article/list" class="btn btn-default jeesns-submit">取消</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
		<!-- 静态引用footer -->
		<%@ include file="/WEB-INF/webpages/front/jspf/footer.jspf"%>
		
		</body>
</html>