<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>上传图片 - JEESNS - Powered By JEESNS</title>
    <meta name="keywords" content="jeesns,sns,java"/>
    <meta name="description" content="JEESNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="JEESNS"/>
    <link href="/Aesopsns/res/common/css/zui.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/front/css/app.css" rel="stylesheet">
    <link href="/Aesopsns/res/plugins/webuploader/webuploader.css" rel="stylesheet">
    <script type="text/javascript">
        var basePath = "/Aesopsns";
        var albumId = "${album.id}";
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
    <script src="/Aesopsns/res/plugins/webuploader/webuploader.min.js"></script>
    <script src="/Aesopsns/res/plugins/webuploader/pictureUpload.js"></script>
</head>
<body class="gray-bg">
<div class="container">
    <div id="picUploader">
        <div class="queueList">
            <div id="dndArea" class="placeholder">
                <div id="filePicker" class="webuploader-container">
                    <div class="webuploader-pick">选择图片</div>
                    <div id="rt_rt_1bah3ovvi6on19tej9785o1tam1"
                         style="width: 168px; height: 44px; overflow: hidden; bottom: auto; right: auto;">
                        <input type="file" name="file" class="webuploader-element-invisible"
                               multiple="multiple" accept="image/*">
                        <label style="opacity: 0; width: 100%; height: 100%; display: block; cursor: pointer; background: rgb(255, 255, 255);"></label>
                    </div>
                </div>
                <p>或将照片拖到这里，最多可选30张</p>
            </div>
            <ul class="filelist"></ul>
        </div>
        <div class="statusBar" style="display:none;">
            <div class="progress" style="display: none;">
                <span class="text">0%</span>
                <span class="percentage" style="width: 0%;"></span>
            </div>
            <div class="info">共0张（0B），已上传0张</div>
            <div class="btns">
                <div id="filePicker2" class="webuploader-container">
                    <div class="webuploader-pick">继续添加</div>
                    <div id="rt_rt_1bah3ovvs1r4u1i88td912et1d006"
                         style="position: absolute; top: 0px; left: 0px; width: 1px; height: 1px; overflow: hidden;">
                        <input type="file" name="file" class="webuploader-element-invisible"
                               multiple="multiple" accept="image/*"><label
                            style="opacity: 0; width: 100%; height: 100%; display: block; cursor: pointer; background: rgb(255, 255, 255);"></label>
                    </div>
                </div>
                <div class="uploadBtn state-pedding">开始上传</div>
            </div>
        </div>
    </div>
</div>
</body>
</html>