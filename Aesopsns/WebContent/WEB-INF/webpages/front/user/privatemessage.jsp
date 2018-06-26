<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的私信 - AESOPSNS - Powered By AESOPSNS</title>
    <meta name="keywords" content="AESOPSNS,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
    <link href="/Aesopsns/res/common/css/bootstrap.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/font-awesome.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/jeesns.css" rel="stylesheet">
    <link href="/Aesopsns/res/common/css/jeesns-skin.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="/Aesopsns/res/common/js/html5shiv.min.js"></script>
    <script src="/Aesopsns/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="/Aesopsns/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="/Aesopsns/res/common/js/bootstrap.min.js"></script>
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.form.js"></script>
    <script src="/Aesopsns/res/common/js/jeesns.js"></script>
    
</head>
<body class="gray-bg">
<script>
var mail = "${currentuser.mail}";
var memberName = "";             //这个很重要，它存储了用户所查看聊天记录所属聊天对象的名字
$(document).ready(function () {
    listContactMembers();
    $(".sendMessage").on("click", function () {
        if(memberName == ""){
            jeesnsDialog.errorTips("请先选择发送的对象");
            return;
        }
        var content = $("#content").val();
        if (content == "") {
            jeesnsDialog.errorTips("请输入私信内容");
            return;
        }
        $.ajax({
            url: "/Aesopsns/user/sendmessage",
            type: "post",
            data: {
                messagetarget: memberName,
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
            success: function (pm) {
            	var html = "";
            	var lr = "";
            	if(pm.mail == mail)	lr = "right";
            	else	lr = "left";
                jeesnsDialog.close(index);
                jeesnsDialog.successTips("信息发送成功！");
                
                html += "<div class=\"chat-message "+lr+"\">";
                html += "<a href=\"/Aesopsns/user/others/"+pm.sender+"\" target='_blank'><img class=\"message-avatar\" src=\"" + pm.icon +"\"></a>";
                html += "<div class=\"message\">";
                html += "<a href=\"/Aesopsns/user/others/"+pm.sender+"\" class='message-author' target='_blank'>"+pm.sender+"</a>";
                html += "<span class=\"message-date\"> "+pm.time+" </span>";
                html += "<span class=\"message-content\">";
                html += pm.message;
                html += "</span></div></div>";
                
                $(".chat-discussion-content").append(html);
                $("#content").val("");
            }
        });
    });
});
function listContactMembers(){
	$.ajax({
        url: "/Aesopsns/user/listcontactmember",
        type: "get",
        data : 'mail='+mail,
        error: function () {
            jeesnsDialog.errorTips("联系人获取失败，请刷新重试")
        },
        success: function (list) {
        	var html = "";
        	//我靠，已经给转成json串了，不用再转了
        	//var list = JSON.parse(data);
            for (var i=0;i<list.length;i++){
                html += "<div class=\"chat-user\">";
                html += "<img class=\"chat-avatar\" src=\"" + list[i].icon +"\">";
                html += "<div class=\"chat-user-name\">";
                html += "<a href=\"javascript:void(0)\" onclick=\"getMessageRecords('"+list[i].target+"')\" class=\"message-user-name\">"+list[i].target+"</a>";
                html += "</div></div>";
            }
            $("#users-list").html(html);
            if($("#users-list")[0].scrollHeight < 520){
                $(".contacts-load-more-a").css("display","none");
            }else {
                $(".contacts-load-more-a").css("display","inline");
            }
		
        }
    });
}
function getMessageRecords(member_name) {
	memberName = member_name;
	$("#user-name").text(memberName);	//当用户点击一个联系人时窗口会显示聊天对象的名字	
    messageRecords();					//打印聊天记录
}
//一调用这个方法就在框内打印聊天记录
function messageRecords(){
	$.ajax({
        url: "/Aesopsns/user/getmessagerecords",
        type: "get",
        data: {
        	//查一段聊天记录所需的两个参数
            usermail : mail,			//当前用户邮箱
            membername : memberName		//聊天对象的名字          
        },
        cache: false,
        dataType: "json",
        timeout: 5000,
        error: function () {
            jeesnsDialog.errorTips("私信记录获取失败，请刷新重试")
        },
        success: function (list) {
           var html = "";
           var lr = "";
           if(list.length == 0){		//说实话，这段判等逻辑根本没用，别人没跟你说话，那他怎么可能会出现在你的联系人名单里呢？
               $(".no-message").show();
           }else {
               $(".no-message").hide();
           }
           
           //在chatframe中打印对话框
           for (var i = 0; i < list.length; i++) {
           	   if(list[i].mail == mail)	lr = "right";
           	   else	lr = "left";
        	   
        	   html += "<div class=\"chat-message "+lr+"\">";
               html += "<a href=\"/Aesopsns/user/others/"+list[i].sender+"\" target='_blank'><img class=\"message-avatar\" src=\"" + list[i].icon +"\"></a>";
               html += "<div class=\"message\">";
               html += "<a href=\"/Aesopsns/user/others/"+list[i].sender+"\" class='message-author' target='_blank'>"+list[i].sender+"</a>";
               html += "<span class=\"message-date\"> "+list[i].time+" </span>";
               html += "<span class=\"message-content\">";
               html += list[i].message;
               html += "</span></div></div>";                   
           }
           
           $(".chat-discussion-content").html(html);
           
           //获取旧的div高度
           var oldHeight = $(".chat-discussion")[0].scrollHeight;
           //重新获取用html
           $(".message-load-more-a").html("已全部加载");
           $(".message-load-more-a").css("display","none");
           //if(autoScroll == 1){
           //    $(".chat-discussion").scrollTop($(".chat-discussion")[0].scrollHeight);
           //}else {
               //旧的div高度高于420，说明有滚动过，可能获取到了第二页的数据，将滚动条保持在原来的位置
             //  if(oldHeight > 420){
             //      $(".chat-discussion").scrollTop($(".chat-discussion")[0].scrollHeight - oldHeight);
             //  }
          // }
        }
    });
}
//接收server发过来的联系对象消息
function receive(){
	$.ajax({
		url:"http://localhost:8080/login/4",
		success:function(result){
	      console.log(result);
	      var ws = new WebSocket("http://localhost:8080/Aesopsns/myHandler");
	      ws.onopen = function () {
	        console.log("onpen");
	        //ws.send("{}");
	      }
	      ws.onclose = function () {
	        console.log("onclose");
	      }

	      ws.onmessage = function (msg) {
	    	  var pm = JSON.parse(msg);
	    	  if($("#user-name").text() == pm.sender){
	    		  var html = "";
	          	  var lr = "";
	          	  if(pm.mail == mail)	lr = "right";
	          	  else	lr = "left";
	              
	              html += "<div class=\"chat-message "+lr+"\">";
	              html += "<a href=\"/Aesopsns/user/others/"+pm.sender+"\" target='_blank'><img class=\"message-avatar\" src=\"" + pm.icon +"\"></a>";
	              html += "<div class=\"message\">";
	              html += "<a href=\"/Aesopsns/user/others/"+pm.sender+"\" class='message-author' target='_blank'>"+pm.sender+"</a>";
	              html += "<span class=\"message-date\"> "+pm.time+" </span>";
	              html += "<span class=\"message-content\">";
	              html += pm.message;
	              html += "</span></div></div>";
	              
	              $(".chat-discussion-content").append(html);
	              $("#content").val("");
	    	  }
	      }
	    }
	});
}
$(function(){
	var ws = new WebSocket("ws://" + window.location.host + "/Aesopsns/myHandler");
    ws.onopen = function () {
      console.log("onpen");
      //ws.send("{}");
    }
    ws.onclose = function () {
      console.log("onclose");
    }

    ws.onmessage = function (msg) {
      console.log(msg);
      var pm = JSON.parse(msg.data);
	  if($("#user-name").text() == pm.sender){
		  var html = "";
      	  var lr = "";
      	  if(pm.mail == mail)	lr = "right";
      	  else	lr = "left";
          
          html += "<div class=\"chat-message "+lr+"\">";
          html += "<a href=\"/Aesopsns/user/others/"+pm.sender+"\" target='_blank'><img class=\"message-avatar\" src=\"" + pm.icon +"\"></a>";
          html += "<div class=\"message\">";
          html += "<a href=\"/Aesopsns/user/others/"+pm.sender+"\" class='message-author' target='_blank'>"+pm.sender+"</a>";
          html += "<span class=\"message-date\"> "+pm.time+" </span>";
          html += "<span class=\"message-content\">";
          html += pm.message;
          html += "</span></div></div>";
          
          $(".chat-discussion-content").append(html);
          $("#content").val("");
	  }
    }
});
</script>
<div id="wrapper">
    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
        
        <!-- 静态引用header 怎么搞的，用户页面的头部竟然和其它页面的头部不一样 -->
		<%@ include file="/WEB-INF/webpages/front/jspf/user_header.jspf"%>
		
        </div>
<div class="wrapper wrapper-content  animated fadeInRight">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox chat-view">
                    <div class="ibox-title">
                        <small class="pull-right text-muted" id="user-name"></small>
                        私信
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="chat-users">
                                    <div class="users-list" id="users-list">

                                    </div>
                                   <!--  <div class="users-list" id="users-list">
                                    	<div class="chat-user">
                                    		<img class="chat-avatar" src="/res/common/images/default-avatar.png">
                                    		<div class="chat-user-name">
                                    			<a href="javascript:void(0)" onclick="getMessageRecords(706,'jack123561')" class="message-user-name" data="706">jack123561</a>
                                    		</div>
                                    	</div>
                                    </div> -->
                                    
                                    <div class="load-more">
                                        <a href="javascript:void(0)" class="contacts-load-more-a" onclick="contactsLoadMore()" style="display: none;">加载更多...</a>
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-9 ">
                                <div class="chat-discussion">
                                    <div class="chat-load-more">
                                        <a href="javascript:void(0)" class="message-load-more-a" onclick="messageLoadMore()" style="display: none;">加载更多...</a>
                                    </div>
                                    <div class="chat-discussion-content">
										<!-- <div class="chat-message left">
											<a href="/u/706" target="_blank">
											<img class="message-avatar" src="/res/common/images/default-avatar.png"></a>
											<div class="message">
												<a href="/u/706" class="message-author" target="_blank">jack123561</a>
												<span class="message-date"> 2018/4/8 下午9:16  </span>
												<span class="message-content">fuck fuck </span>
											</div>
										</div> -->
										
							        <!-- end of the chatframe -->
                                    </div>
                                    <div class="no-message"> 暂无聊天记录</div>
                                </div>
                                <div class="send-message-area">
                                    <textarea class="form-control message-input" name="content" id="content"></textarea>
                                    <button class="btn btn-info pull-right sendMessage">发送</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
		<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/footer.jspf"%>
		</body>
</html>