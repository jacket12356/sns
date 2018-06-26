<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh">
    <head>
        <meta charset="utf-8" />
        <title>Simple example - Editor.md examples</title>
        <link rel="stylesheet" href="/Aesopsns/res/front/css/style.css" />
        <link rel="stylesheet" href="/Aesopsns/res/front/css/editormd.css" />
        <link rel="shortcut icon" href="https://pandao.github.io/editor.md/favicon.ico" type="image/x-icon" />
    </head>
    <body>
        <div id="layout">
            <header>
                <h1>Simple example</h1>
            </header>
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
    </body>
</html>