<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>发布文章 - AESOPSNS - Powered By AESOPSNS</title>
    <link href="/Aesopsns/res/common/css/zui.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/front/css/app.css" rel="stylesheet">
    <link href="/Aesopsns/res/plugins/layer/skin/layer.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="/Aesopsns/res/common/js/html5shiv.js"></script>
    <script src="/Aesopsns/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="/Aesopsns/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.form.js"></script>
    <script src="/Aesopsns/res/common/js/zui.min.js"></script>
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/res/front/js/jeesns.js"></script>
    <script src="/res/plugins/webuploader/upload.js"></script>
    <link rel="stylesheet" href="/Aesopsns/res/front/css/editormd.css" />
</head>
<body class="gray-bg">

		<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/header.jspf"%>
		
<div class="container">
    <div class="main-content">
        <div class="row">
            <div class="col-md-12 article-detail">
                <form class="form-horizontal jeesns_form" action="/Aesopsns/article/save" method="post"  enctype="multipart/form-data">
                    <div class="form-group">
                        <label class="col-sm-1 control-label">栏目</label>
                        <div class="col-sm-3">
                            <select class="form-control" name="cateId" data-type="selected" alt="栏目">
                                <option value="" selected>=请选择栏目=</option>
                                <!-- <option value="10">Linux</option>
                                <option value="9">Oracle</option>
                                <option value="8">Mysql</option>
                                <option value="7">SQL Server</option>
                                <option value="6">WEB前端</option>-->
                                <c:forEach items="${articlecates }" var="cate">
                                	<option value="${cate.cateid }">${cate.catename }</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">标题</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="title" name="title" placeholder="标题">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">缩略图</label>
                        <div class="col-sm-8">
                            <input type="file" name="upload" id="upload"/>
                                		<!--	用来存放文件信息
                                <input type="hidden" id="thumbnail" name="thumbnail">
                                <div id="preview" class="uploader-list"></div>
                                <div id="imagesList" class="uploader-list"></div>
                                <div class="btns">
                                    <div id="picker">选择文件</div>
                                </div>-->
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">描述</label>
                        <div class="col-sm-8">
                            <textarea class="form-control" rows="3" name="description" alt="描述"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <!-- <label class="col-sm-1 control-label">内容</label> -->
                        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;内容</h4>
                        <div id="layout">
				            <div class="editormd" id="test-editormd">
								<textarea class="editormd-markdown-textarea ckeditor" name="test-editormd-markdown-doc"></textarea>
								<!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
								<textarea id="content" class="editormd-html-textarea ckeditor" name="articlecontent"></textarea>
							</div>
       					</div>
                    </div>
                    <div class="form-group" style="margin-left:931px;" id="deletebtnwhenfullscreen">
                        <div class="col-sm-offset-1 col-sm-10">
                            <button type="submit" class="btn btn-info jeesns-submit">保存</button>
                            <a href="/Aesopsns/article/list" class="btn btn-default jeesns-submit">取消</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="/Aesopsns/res/front/js/jquery.min.js"></script>
<script src="/Aesopsns/res/front/js/editormd.js"></script>
<script type="text/javascript">
var testEditor;

    $(function() {
    	/* testEditor = editormd("test-editormd", {
            width   : "90%",
            height  : 640,
            syncScrolling : "single",
            path    : "../lib/"
        });*/
        
        
        // or
        testEditor = editormd({
            id      : "test-editormd",
            width   : "90%",
            height  : 850,
            codeFold : true,
            //syncScrolling : false,
            saveHTMLToTextarea : true,    // 保存 HTML 到 Textarea
            searchReplace : true,
            htmlDecode : "style,script,iframe|on*",            // 开启 HTML 标签解析，为了安全性，默认不开启    
            emoji : true,
            taskList : true, 

            path    : "../lib/"
        });
        
    });
</script>

		<!-- 静态引用footer -->
		<%@ include file="/WEB-INF/webpages/front/jspf/footer.jspf"%>
</div>
</div>
</div>
</body>
</html>