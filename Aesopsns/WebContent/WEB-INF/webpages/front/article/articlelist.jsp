<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>文章列表 - AESOPSNS - Powered By AESOPSNS</title>
    <meta name="keywords" content="jeesns,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
    <link href="/Aesopsns/res/common/css/zui.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/front/css/app.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="/Aesopsns/res/common/js/html5shiv.min.js"></script>
    <script src="/Aesopsns/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="/Aesopsns/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="/Aesopsns/res/common/js/zui.min.js"></script>
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.form.js"></script>
    <script src="/Aesopsns/res/common/js/jeesns.js"></script>
    <script src="/Aesopsns/res/common/js/extendPagination.js"></script>
    <style type="text/css">  
        .search  
        {  
            margin-bottom: 20px;
            
        }  
        #auto_div  
        {  
            display: none;  
            width: 327px;  
            border: 1px #74c0f9 solid;  
            background: #FFF;  
            position: absolute;  
            top: 31px;  
            left: 0;  
            color: #323232;  
        }  
    </style>
</head>
<body class="gray-bg">
		<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/header.jspf"%>
<div class="container">
    <div class="main-content">
        <div class="row">
            <div class="col-md-8">
                <div class="items">
                  <!--   <div class="item article-list shadow">
                        <div class="item-content">
                            <div class="text">
                                <a href="/article/list?cid=8"><div class="pull-right label label-success">Mysql</div></a>
                                <h3><a href="/article/detail/30574">MySql常用操作SQL语句汇总</a></h3>
                                <p>
                                    <span class="text-muted"><i class="icon-comments"></i> 60 &nbsp; <i class="icon-time"></i> 2017-09-16 16:15</span>
                                </p>
                            </div>
                        </div>

                    </div>
                    <div class="item article-list shadow">
                        <div class="item-content">
                            <div class="text">
                                <a href="/article/list?cid=8"><div class="pull-right label label-success">Mysql</div></a>
                                <h3><a href="/article/detail/30573">MySQL 实现双向复制的方法指南</a></h3>
                                <p>
                                    <span class="text-muted"><i class="icon-comments"></i> 41 &nbsp; <i class="icon-time"></i> 2017-09-16 16:15</span>
                                </p>
                            </div>
                        </div>
                    </div> -->
                    <c:forEach items="${currentpagelist }" var="article">
                    	<div class="item article-list shadow">
	                        <div class="item-content">
	                        	<c:if test="${article.image != null }">
		                        	<div class="media pull-left">
	                                    <a href="/Aesopsns/article/detail/${article.id }">
	                                        <img src="/Aesopsns/res/common/uploads/articleimage/${article.image }" alt="${article.title }" height="80px" width="120px">
	                                    </a>
	                                </div>
	                        	</c:if>
	                            <div class="text">
	                                <a href="/Aesopsns/article/list?catename=${article.tag }"><div class="pull-right label label-success">${article.tag }</div></a>
	                                <h3><a href="/Aesopsns/article/detail/${article.id }">${article.title }</a></h3>
	                                <p>
	                                	<!-- 这个需要显示改文章的评论数，先改成阅览数吧，等加了 -->
	                                    <span class="text-muted"><i class="icon-comments"></i> ${article.readcount } &nbsp; <i class="icon-time"></i> ${article.publishtime }</span>
	                                </p>
	                            </div>
	                        </div>
                    	</div>
                    </c:forEach>
                    <!-- 这个分页做的好棒！ -->
                    <ul class="pager pagination pagination-sm no-margin pull-right"
                        url="/Aesopsns/article/list?keys=ww"			  
                        currentPage="${articlepage.currentPage }"
                        pageCount="${articlepage.pageCount }">
                    </ul>
                </div>
            </div>
            
            <div class="col-md-4 float-left">
           		<!-- 文章搜索功能 -->
                <form action="/article/list" method="get">
                    <div class="input-group search">
                        <input type="text" id="search_text" class="form-control" name="key" placeholder="如果想使用全文检索，请加前缀：'full-text:'"/>
                        <span class="input-group-btn">
                            <button class="btn btn-success" type="submit"><i class="icon-search"></i></button>
                        </span>
                        <div id="auto_div"> </div>
                    </div>
                </form>
                
                
                <div class="panel">
                    <div class="panel-heading">
                        文章栏目
                        <span class="pull-right">
                            <a class="btn btn-primary m-t-n4" href="/Aesopsns/article/publish">发布文章</a>
                        </span>
                    </div>
                    <div class="panel-body">
                        <a href="/Aesopsns/article/list" class="btn btn-primary">全部</a>
                      <!--   <a href="/article/list?cid=10" class="btn btn-primary">Linux</a>
                        <a href="/Aesopsns/article/list?cid=9" class="btn btn-primary">Oracle</a>
                        <a href="/article/list?cid=8" class="btn btn-primary">Mysql</a> -->
                        <c:forEach items="${articlecates }" var="cate">
                        	<a href="/Aesopsns/article/list?catename=${cate.catename }" class="btn btn-primary">${cate.catename }</a>
                        </c:forEach>
                    </div>
                </div>
                <div class="panel">
                    <div class="panel-heading">
                        热门文章
                    </div>
                    <div class="panel-body article-hot-list">
                        <ul>
                                <li><i class="icon-hand-right main-text-color"></i> <a href="/article/detail/9946">Thymeleaf模板表达式</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
		<!-- 静态引用footer -->
		<%@ include file="/WEB-INF/webpages/front/jspf/footer.jspf"%>
		
		
		<script type="text/javascript">  
        //测试用的数据，这里可以用AJAX获取服务器数据  
        var test_list = [];  
        <c:forEach items="${titlelist}" var="title">
        	test_list.push("${title}");
        </c:forEach>
        var old_value = "";  
        var highlightindex = -1;   //高亮  
        //自动完成  
        function AutoComplete(auto, search, mylist) {  
            if ($("#" + search).val() != old_value || old_value == "") {  
                var autoNode = $("#" + auto);   //缓存对象（弹出框）  
                var carlist = new Array();  
                var n = 0;  
                old_value = $("#" + search).val();  
                for (i in mylist) {  
                    if (mylist[i].indexOf(old_value) >= 0) {  
                        carlist[n++] = mylist[i];  
                    }  
                }  
                if (carlist.length == 0) {  
                    autoNode.hide();  
                    return;  
                }  
                autoNode.empty();  //清空上次的记录  
                for (i in carlist) {  
                    var wordNode = carlist[i];   //弹出框里的每一条内容  
                    var newDivNode = $("<div>").attr("id", i);    //设置每个节点的id值  
                    newDivNode.attr("style", "font:14px/25px arial;height:25px;padding:0 8px;cursor: pointer;");  
                    newDivNode.html(wordNode).appendTo(autoNode);  //追加到弹出框  
                    //鼠标移入高亮，移开不高亮  
                    newDivNode.mouseover(function () {  
                        if (highlightindex != -1) {        //原来高亮的节点要取消高亮（是-1就不需要了）  
                            autoNode.children("div").eq(highlightindex).css("background-color", "white");  
                        }  
                        //记录新的高亮节点索引  
                        highlightindex = $(this).attr("id");  
                        $(this).css("background-color", "#ebebeb");  
                    });  
                    newDivNode.mouseout(function () {  
                        $(this).css("background-color", "white");  
                    });  
                    //鼠标点击文字上屏  
                    newDivNode.click(function () {  
                        //取出高亮节点的文本内容  
                        var comText = autoNode.hide().children("div").eq(highlightindex).text();  
                        highlightindex = -1;  
                        //文本框中的内容变成高亮节点的内容  
                        $("#" + search).val(comText);  
                    })  
                    if (carlist.length > 0) {    //如果返回值有内容就显示出来  
                        autoNode.show();  
                    } else {               //服务器端无内容返回 那么隐藏弹出框  
                        autoNode.hide();  
                        //弹出框隐藏的同时，高亮节点索引值也变成-1  
                        highlightindex = -1;  
                    }  
                }  
            }  
            //点击页面隐藏自动补全提示框  
            document.onclick = function (e) {  
                var e = e ? e : window.event;  
                var tar = e.srcElement || e.target;  
                if (tar.id != search) {  
                    if ($("#" + auto).is(":visible")) {  
                        $("#" + auto).css("display", "none")  
                    }  
                }  
            }  
        }  
        $(function () {  
            old_value = $("#search_text").val();  
            $("#search_text").focus(function () {  
                if ($("#search_text").val() == "") {  
                    AutoComplete("auto_div", "search_text", test_list);  
                }  
            });  
            $("#search_text").keyup(function () {  
                AutoComplete("auto_div", "search_text", test_list);  
            });  
        });  
    </script>  
		
<script type="text/javascript">
    $(function () {
        $(".pagination").jeesns_page("jeesnsPageForm");
    });
</script>
</body>
</html>