<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>发布文章 - JEESNS - Powered By JEESNS</title>
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
    <link rel="stylesheet" href="/Aesopsns/res/front/css/style.css" />
    <link rel="stylesheet" href="/Aesopsns/res/front/css/editormd.css" />
    <script type="text/javascript">
        var basePath = "";
        var uploadServer = "/uploadImage";
        $(function () {
            CKEDITOR.replace('content');
        });
    </script>
    <script src="/Aesopsns/res/plugins/webuploader/upload.js"></script>
</head>
<body class="gray-bg">

		<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/user_header.jspf"%>
		
<div class="container">
    <div class="main-content">
        <div class="row">
            <div class="col-md-12 article-detail">
                <form class="form-horizontal jeesns_form" role="form" action="/article/save" method="post" onsubmit="ckUpdate();">
                    <div class="form-group">
                        <label class="col-sm-1 control-label">标签</label>
                        <div class="col-sm-3">
                            <select class="form-control" name="cateId" data-type="selected" alt="标签">
                                <option value="" selected>=请选择标签=</option>
                                <option value="10">Linux</option>
                                <option value="9">Oracle</option>
                                <option value="8">Mysql</option>
                                <option value="7">SQL Server</option>
                                <option value="6">WEB前端</option>
                                <option value="5">Python</option>
                                <option value="4">iOS</option>
                                <option value="3">Android</option>
                                <option value="2">JAVA</option>
                                <option value="1">程序人生</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">标题</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="title" name="title" placeholder="标题" data-type="require">
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
                    <!-- <div class="form-group">
                        <label class="col-sm-1 control-label">内容</label>
                        <div class="col-sm-10">
                            <textarea class="ckeditor" cols="80" id="content" name="content" rows="10"></textarea>
                        </div>
                    </div> -->
                    <div id="layout">
			            <div class="editormd" id="test-editormd">
							<textarea class="editormd-markdown-textarea" name="test-editormd-markdown-doc"></textarea>
							<!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
							<textarea class="editormd-html-textarea" name="text"></textarea>
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
                    height  : 640,
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

















<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>发布文章 - JEESNS - Powered By JEESNS</title>
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
    <link rel="stylesheet" href="/Aesopsns/res/front/css/editormd.css" />
    <script type="text/javascript">
        var basePath = "";
        var uploadServer = "/uploadImage";
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
                <form class="form-horizontal jeesns_form" role="form" action="/article/save" method="post" onsubmit="ckUpdate();">
                    <div class="form-group">
                        <label class="col-sm-1 control-label">栏目</label>
                        <div class="col-sm-3">
                            <select class="form-control" name="cateId" data-type="selected" alt="栏目">
                                <option value="" selected>=请选择栏目=</option>
                                <option value="10">Linux</option>
                                <option value="9">Oracle</option>
                                <option value="8">Mysql</option>
                                <option value="7">SQL Server</option>
                                <option value="6">WEB前端</option>
                                <option value="5">Python</option>
                                <option value="4">iOS</option>
                                <option value="3">Android</option>
                                <option value="2">JAVA</option>
                                <option value="1">程序人生</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">标题</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="title" name="title" placeholder="标题" data-type="require">
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
                        <!-- <label class="col-sm-1 control-label">内容</label> -->
                        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;内容</h4>
                        <div id="layout">
				            <div class="editormd" id="test-editormd">
								<textarea class="editormd-markdown-textarea" name="test-editormd-markdown-doc"></textarea>
								<!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
								<textarea class="editormd-html-textarea" name="text"></textarea>
							</div>
       					</div>
                    </div>
                    <div class="form-group" style="margin-left:931px;">
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
		<%@ include file="/WEB-INF/webpages/front/jspf/footer.jspf"%></body>
</html>














