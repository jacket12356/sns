<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新建相册 - JEESNS - Powered By JEESNS</title>
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
</head>
<body>
<div class="container">
    <form class="form-horizontal jeesns_form" role="form" action="/Aesopsns/album/save" method="post">
        <div class="form-group">
            <label class="col-sm-1 control-label">相册名称</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="title" name="name" placeholder="相册名称" data-type="require">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-1 control-label">相册描述</label>
            <div class="col-sm-8">
                <textarea class="form-control" rows="3" name="intro" alt="相册描述" data-type="require"></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-1 control-label">设置权限</label>谁可以看到这个相册？
            <div class="col-sm-8">
                <div class="radio">
                    <label>
                        <input type="radio" name="right" value="0" checked> 所有人
                    </label>
                    <label>
                        <input type="radio" name="right" value="1"> 相互关注的人
                    </label>
                    <label>
                        <input type="radio" name="right" value="2"> 仅自己
                    </label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-1 col-sm-10">
                <button type="submit" class="btn btn-info jeesns-submit">保存</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>