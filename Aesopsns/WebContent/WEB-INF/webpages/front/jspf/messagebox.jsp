<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 这个iframe好有意思啊！ -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发送私信 - JEESNS - Powered By JEESNS</title>
    <meta name="keywords" content="jeesns,sns,java"/>
    <meta name="description" content="JEESNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="JEESNS"/>
    <link href="/Aesopsns/res/common/css/bootstrap.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/font-awesome.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/jeesns.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/jeesns-skin.css" rel="stylesheet">
    <link href="/Aesopsns/res/plugins/emoji/css/emoji.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="/Aesopsns/res/common/js/html5shiv.min.js"></script>
    <script src="/Aesopsns/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="/Aesopsns/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="/Aesopsns/res/common/js/bootstrap.min.js"></script>
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.form.js"></script>
    <script src="/Aesopsns/res/common/js/jeesns.js"></script>
    <script src="/Aesopsns/res/modules/weibo.js"></script>
    <script src="/Aesopsns/res/plugins/emoji/js/underscore-min.js"></script>
    <script src="/Aesopsns/res/plugins/emoji/js/emojis.js"></script>
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="container">
        <div class="row">
            <div class="ibox">
                <div class="ibox-content">
                    <div class="form-group">
                        <div class="col-sm-12">
                            发送私信给：${contactmember }
                            <a href="">聊天记录</a><!-- 这个链接是要转到对应的私信界面呢，以后再说 -->
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea rows="5" class="form-control col-sm-12" id="content"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12" class="form-control">
                            <button type="button" class="btn btn-primary block full-width sendMessage">发送</button>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $(".sendMessage").on("click", function () {
            var content = $("#content").val();
            if (content == "") {
                jeesnsDialog.errorTips("请输入私信内容");
                return;
            }
            $.ajax({
                url: "/Aesopsns/user/sendmessage",  //对了，消息不能发给自己
                type: "post",
                data: {
                    messagetarget:"${contactmember }",
                    content: content
                },
                cache: false,
                dataType: "json",
                timeout: 5000,
                beforeSend: function () {
                    index = jeesnsDialog.loading();
                },
                error: function () {
                    jeesnsDialog.close(index);
                    jeesnsDialog.errorTips("请求失败")
                },
                success: function (res) {
                    jeesnsDialog.close(index);
                    jeesnsDialog.successTips("发送成功！");
                    setTimeout(function () {
                        jeesnsDialog.closeAll();
                    },3000);
                }
            });
        })
    })
</script>
</body>
</html>