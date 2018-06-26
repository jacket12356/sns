<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>微博中心 - AESOPSNS - Powered By AESOPSNS</title>
    <meta name="keywords" content="jeesns,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
    <link href="/Aesopsns/res/common/css/zui.min.css" rel="stylesheet">
    <link href="/Aesopsns/res/front/css/app.css" rel="stylesheet">
    <link href="/Aesopsns/res/plugins/emoji/css/emoji.css" rel="stylesheet">
    <link href="/Aesopsns/res/plugins/webuploader/webuploader.css" rel="stylesheet">
    <link href="/Aesopsns/res/plugins/gallery/css/blueimp-gallery.min.css" rel="stylesheet">
    <script type="text/javascript">
        var basePath = "";
        var uploadServer = "/uploadImage";
    </script>
    <!--[if lt IE 9]>
    <script src="/Aesopsns/res/common/js/html5shiv.min.js"></script>
    <script src="/Aesopsns/res/common/js/respond.min.js"></script>
    <![endif]-->
    <script src="/Aesopsns/res/common/js/jquery-2.1.1.min.js"></script>
    <script src="/Aesopsns/res/common/js/zui.min.js"></script>
    <script src="/Aesopsns/res/plugins/layer/layer.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.form.js"></script>
    <script src="/Aesopsns/res/common/js/aesopsns.js"></script>
    <script src="/Aesopsns/res/common/js/extendPagination.js"></script>
    <script src="/Aesopsns/res/front/js/weibo.js"></script>
    <script src="/Aesopsns/res/plugins/emoji/js/underscore-min.js"></script>
    <script src="/Aesopsns/res/plugins/emoji/js/editor.js"></script>
    <script src="/Aesopsns/res/plugins/emoji/js/emojis.js"></script>
    <script src="/Aesopsns/res/plugins/js-emoji/emoji.js"></script>
    <script src="/Aesopsns/res/common/js/jquery.timeago.js"></script>
    <script src="/Aesopsns/res/plugins/webuploader/webuploader.min.js"></script>
    <script src="/Aesopsns/res/plugins/gallery/js/jquery.blueimp-gallery.min.js"></script>
    <script src="/Aesopsns/res/plugins/webuploader/weiboUpload.js"></script>
</head>
<body class="gray-bg">
<script>
</script>

		<!-- 静态引用header -->
		<%@ include file="/WEB-INF/webpages/front/jspf/header.jspf"%>
		
<div class="container">
    <div class="main-content">
        <div class="row">
            <div class="col-md-8 white-bg m-b-10">
                <div class="items weibo-post-area">
                    <form class="form-horizontal m-t aesopform" action="/Aesopsns/weibo/publish" method="post">
                        <p>
                            <textarea cols="5" class="form-control area emoji-render-input" name="content" id="weibo-content"
                                      maxlength="140"></textarea>
                            <input type="hidden" name="pictures" id="weibo-pictures">
                        </p>
                        <div class="row emoji-container" id="emoji">
                        	<!--  -->
                            <i class="icon-smile emoji-tbtn"></i>
                            <span class="pull-right p-r-10">
                                 <span id="weibo-words" class="mg-r-5">0/140</span>
                                <input type="submit" value="发布" class="btn btn-primary">
                            </span>
                            <a href="javascript:void(0)" class="weibo-picture"><i class="icon-picture"></i></a>
                        </div>
                    </form>
                    <!-- 图片上传模块 -->
                    <div class="weibo-picture-area" style="display: none;">
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
                                    <p>选好后，请点击“开始上传”，最多可选9张</p>
                                </div>
                                <ul class="filelist" id="myfilelist"></ul>
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
                </div>
                <hr>
                <div class="items" id="data-list">
                    <!-- <div class="comment">
                        <a href="/u/689" class="avatar" target="_blank">
                            <img src="/upload/avatar/201804/96c8f30a-b981-4939-8451-068d0092126d.jpg" class="icon-camera-retro icon-2x">
                        </a>
                        <div class="content">
                            <div class="pull-right text-muted timeago" datetime="2018-04-18 17:44:31"></div>
                            <div>
                                <a href="/u/689" target="_blank">
                                    <strong>sssssd</strong>
                                </a>
                            </div>
                            <div class="text">
                                <div class="emoji-render-content">:sleepy::sleepy:</div>
                                <div class="lightBoxGallery">
                                    <div id="blueimp-gallery" class="blueimp-gallery">
                                        <div class="slides"></div>
                                        <h3 class="title"></h3>
                                        <a class="prev">‹</a>
                                        <a class="next">›</a>
                                        <a class="close">×</a>
                                        <a class="play-pause"></a>
                                        <ol class="indicator"></ol>
                                    </div>
                                </div>
                            </div>
                            <div class="actions">
                                (
                                <a class="text-primary weibo-favor" weibo-id="1340" href="javascript:void(0);">
                                    <i class="icon-thumbs-o-up"></i> 0</a>
                                <a href="/weibo/detail/1340"><i class="icon-chat"></i> 0</a>
                                <a href="/weibo/detail/1340">查看详情</a>
                            </div>
                        </div>
                    </div>
                    <div class="comment">
                        <a href="/u/728" class="avatar" target="_blank">
                            <img src="/Aesopsns/res/common/images/default-avatar.png" class="icon-camera-retro icon-2x">
                        </a>
                        <div class="content">
                            <div class="pull-right text-muted timeago" datetime="2018-04-18 14:20:20"></div>
                            <div>
                                <a href="/u/728" target="_blank">
                                    <strong>怪器卡卡_phantom</strong>
                                </a>
                            </div>
                            <div class="text">
                                <div class="emoji-render-content">352KB</div>
                                <div class="lightBoxGallery">
                                        <a href="/upload/images/20180418/55f68251-cd4f-447e-8e87-84c58e585434.jpg" title="怪器卡卡_phantom"
                                           data-gallery=""><img src="/upload/images/20180418/thumb_55f68251-cd4f-447e-8e87-84c58e585434.jpg"/></a>
                                    <div id="blueimp-gallery" class="blueimp-gallery">
                                        <div class="slides"></div>
                                        <h3 class="title"></h3>
                                        <a class="prev">‹</a>
                                        <a class="next">›</a>
                                        <a class="close">×</a>
                                        <a class="play-pause"></a>
                                        <ol class="indicator"></ol>
                                    </div>
                                </div>
                            </div>
                            <div class="actions">
                                (
                                <a class="text-primary weibo-favor" weibo-id="1339" href="javascript:void(0);">
                                    <i class="icon-thumbs-o-up"></i> 1</a>
                                <a href="/weibo/detail/1339"><i class="icon-chat"></i> 0</a>
                                <a href="/weibo/detail/1339">查看详情</a>
                            </div>
                        </div>
                    </div> -->
                    <c:forEach items="${currentpagelist }" var="wb">
	                    <div class="comment">
	                        <a href="/Aesopsns/user/others/${wb.u.name }" class="avatar" target="_blank">
	                            <c:if test="${wb.u.icon == null }">
		                        	<img src="/Aesopsns/res/common/images/default-avatar.png" class="icon-camera-retro icon-2x"/>
		                        </c:if>
		                        <c:if test="${wb.u.icon != null }">
		                        	<img src="/Aesopsns/res/common/uploads/${wb.u.icon}" class="icon-camera-retro icon-2x"/>
                       			</c:if>
	                        </a>
	                        <div class="content">
	                            <div class="pull-right text-muted timeago" datetime="${wb.w.publishtime }"></div>
	                            <div>
	                                <a href="/Aesopsns/user/others/${wb.u.name }" target="_blank">
	                                    <strong>${wb.u.name }</strong>
	                                </a>
	                            </div>
	                            <div class="text">
	                                <div class="emoji-render-content">${wb.w.content }</div>
	                                <div class="lightBoxGallery">
	                                <c:if test="${wb.w.pictures != '' }">
	                                <c:forEach items="${wb.images }" var="image">
                                        <a href="/Aesopsns/res/common/uploads/weiboimage/${image }" title="${wb.u.name }" data-gallery="">
                                           <img src="/Aesopsns/res/common/uploads/weiboimage/${image }" width="160px" height="160px"/>
                                        </a>
	                                </c:forEach>
	                                </c:if>
	                                    <div id="blueimp-gallery" class="blueimp-gallery">
	                                        <div class="slides"></div>
	                                        <h3 class="title"></h3>
	                                        <a class="prev">‹</a>
	                                        <a class="next">›</a>
	                                        <a class="close">×</a>
	                                        <a class="play-pause"></a>
	                                        <ol class="indicator"></ol>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="actions">
	                                <a class="text-primary weibo-favor" weibo-id="1339" href="javascript:void(0);">
	                                    <i class="icon-thumbs-o-up"></i> ${wb.w.upvotes }</a>
	                                <a href="/Aesopsns/weibo/detail/${wb.w.id }"><i class="icon-chat"></i> ${wb.w.comments }</a>
	                                <a href="/Aesopsns/weibo/detail/${wb.w.id }">查看详情</a>
	                            </div>
	                        </div>
	                    </div>
                    </c:forEach>
                </div>
                <!-- 这个是微博的分页 -->
                <ul class="pager pagination pagination-sm no-margin pull-right"
                    url="/Aesopsns/weibo/list"
                    currentPage="${weibopage.currentPage }"
                    pageCount="${weibopage.pageCount }">
                </ul>
            </div>
            <div class="col-md-4 float-left">
                <div class="panel">
                    <div class="panel-heading">
                        热门微博
                    </div>
                    <div class="panel-body article-hot-list">
                        <ul>
                                <div class="comment">
                                    <a href="/u/692" class="avatar" target="_blank">
                                        <img src="/Aesopsns/res/common/images/default-avatar.png"
                                             class="icon-camera-retro icon-2x">
                                    </a>
                                    <div class="content">
                                        <div class="pull-right text-muted timeago" datetime="2018-03-30 13:14:10"></div>
                                        <div>
                                            <a href="/u/692" target="_blank">
                                                <strong>qazxswabc</strong>
                                            </a>
                                        </div>
                                        <div class="text">
                                            <div class="emoji-render-content">Bdhdhjdjdjjdjjfjdjj</div>
                                        </div>
                                        <div class="actions">
                                            (
                                            <a class="text-primary weibo-favor" weibo-id="1330">
                                                <i class="icon-thumbs-o-up"></i> 1</a>
                                            <a href="/weibo/detail/1330"><i class="icon-chat"></i> 0</a>
                                            <a href="/weibo/detail/1330">查看详情</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="comment">
                                    <a href="/u/58" class="avatar" target="_blank">
                                        <img src="/Aesopsns/res/common/images/default-avatar.png"
                                             class="icon-camera-retro icon-2x">
                                    </a>
                                    <div class="content">
                                        <div class="pull-right text-muted timeago" datetime="2018-04-03 15:38:42"></div>
                                        <div>
                                            <a href="/u/58" target="_blank">
                                                <strong>123456</strong>
                                            </a>
                                        </div>
                                        <div class="text">
                                            <div class="emoji-render-content">111</div>
                                        </div>
                                        <div class="actions">
                                            (
                                            <a class="text-primary weibo-favor" weibo-id="1331">
                                                <i class="icon-thumbs-o-up"></i> 1</a>
                                            <a href="/weibo/detail/1331"><i class="icon-chat"></i> 0</a>
                                            <a href="/weibo/detail/1331">查看详情</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="comment">
                                    <a href="/u/58" class="avatar" target="_blank">
                                        <img src="/Aesopsns/res/common/images/default-avatar.png"
                                             class="icon-camera-retro icon-2x">
                                    </a>
                                    <div class="content">
                                        <div class="pull-right text-muted timeago" datetime="2018-04-03 15:58:30"></div>
                                        <div>
                                            <a href="/u/58" target="_blank">
                                                <strong>123456</strong>
                                            </a>
                                        </div>
                                        <div class="text">
                                            <div class="emoji-render-content">1212</div>
                                        </div>
                                        <div class="actions">
                                            (
                                            <a class="text-primary weibo-favor" weibo-id="1332">
                                                <i class="icon-thumbs-o-up"></i> 1</a>
                                            <a href="/weibo/detail/1332"><i class="icon-chat"></i> 3</a>
                                            <a href="/weibo/detail/1332">查看详情</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="comment">
                                    <a href="/u/689" class="avatar" target="_blank">
                                        <img src="/Aesopsns/res/common/images/default-avatar.png"
                                             class="icon-camera-retro icon-2x">
                                    </a>
                                    <div class="content">
                                        <div class="pull-right text-muted timeago" datetime="2018-04-08 23:07:18"></div>
                                        <div>
                                            <a href="/u/689" target="_blank">
                                                <strong>sssssd</strong>
                                            </a>
                                        </div>
                                        <div class="text">
                                            <div class="emoji-render-content">大大大是发放的发货单号</div>
                                        </div>
                                        <div class="actions">
                                            (
                                            <a class="text-primary weibo-favor" weibo-id="1335">
                                                <i class="icon-thumbs-o-up"></i> 1</a>
                                            <a href="/weibo/detail/1335"><i class="icon-chat"></i> 0</a>
                                            <a href="/weibo/detail/1335">查看详情</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="comment">
                                    <a href="/u/728" class="avatar" target="_blank">
                                        <img src="/Aesopsns/res/common/images/default-avatar.png"
                                             class="icon-camera-retro icon-2x">
                                    </a>
                                    <div class="content">
                                        <div class="pull-right text-muted timeago" datetime="2018-04-18 14:20:20"></div>
                                        <div>
                                            <a href="/u/728" target="_blank">
                                                <strong>怪器卡卡_phantom</strong>
                                            </a>
                                        </div>
                                        <div class="text">
                                            <div class="emoji-render-content">352KB</div>
                                        </div>
                                        <div class="actions">
                                            (
                                            <a class="text-primary weibo-favor" weibo-id="1339">
                                                <i class="icon-thumbs-o-up"></i> 1</a>
                                            <a href="/weibo/detail/1339"><i class="icon-chat"></i> 0</a>
                                            <a href="/weibo/detail/1339">查看详情</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="comment">
                                    <a href="/u/691" class="avatar" target="_blank">
                                        <img src="/Aesopsns/res/common/images/default-avatar.png"
                                             class="icon-camera-retro icon-2x">
                                    </a>
                                    <div class="content">
                                        <div class="pull-right text-muted timeago" datetime="2018-03-29 12:53:50"></div>
                                        <div>
                                            <a href="/u/691" target="_blank">
                                                <strong>andy521</strong>
                                            </a>
                                        </div>
                                        <div class="text">
                                            <div class="emoji-render-content">hh测试</div>
                                        </div>
                                        <div class="actions">
                                            (
                                            <a class="text-primary weibo-favor" weibo-id="1328">
                                                <i class="icon-thumbs-o-up"></i> 0</a>
                                            <a href="/weibo/detail/1328"><i class="icon-chat"></i> 0</a>
                                            <a href="/weibo/detail/1328">查看详情</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="comment">
                                    <a href="/u/691" class="avatar" target="_blank">
                                        <img src="/Aesopsns/res/common/images/default-avatar.png"
                                             class="icon-camera-retro icon-2x">
                                    </a>
                                    <div class="content">
                                        <div class="pull-right text-muted timeago" datetime="2018-03-30 09:44:35"></div>
                                        <div>
                                            <a href="/u/691" target="_blank">
                                                <strong>andy521</strong>
                                            </a>
                                        </div>
                                        <div class="text">
                                            <div class="emoji-render-content">:stuck_out_tongue_winking_eye:ewfdsdf</div>
                                        </div>
                                        <div class="actions">
                                            (
                                            <a class="text-primary weibo-favor" weibo-id="1329">
                                                <i class="icon-thumbs-o-up"></i> 0</a>
                                            <a href="/weibo/detail/1329"><i class="icon-chat"></i> 0</a>
                                            <a href="/weibo/detail/1329">查看详情</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="comment">
                                    <a href="/u/689" class="avatar" target="_blank">
                                        <img src="/Aesopsns/res/common/images/default-avatar.png"
                                             class="icon-camera-retro icon-2x">
                                    </a>
                                    <div class="content">
                                        <div class="pull-right text-muted timeago" datetime="2018-04-03 17:49:42"></div>
                                        <div>
                                            <a href="/u/689" target="_blank">
                                                <strong>sssssd</strong>
                                            </a>
                                        </div>
                                        <div class="text">
                                            <div class="emoji-render-content">测试sss</div>
                                        </div>
                                        <div class="actions">
                                            (
                                            <a class="text-primary weibo-favor" weibo-id="1333">
                                                <i class="icon-thumbs-o-up"></i> 0</a>
                                            <a href="/weibo/detail/1333"><i class="icon-chat"></i> 0</a>
                                            <a href="/weibo/detail/1333">查看详情</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="comment">
                                    <a href="/u/689" class="avatar" target="_blank">
                                        <img src="/Aesopsns/res/common/images/default-avatar.png"
                                             class="icon-camera-retro icon-2x">
                                    </a>
                                    <div class="content">
                                        <div class="pull-right text-muted timeago" datetime="2018-04-08 23:07:13"></div>
                                        <div>
                                            <a href="/u/689" target="_blank">
                                                <strong>sssssd</strong>
                                            </a>
                                        </div>
                                        <div class="text">
                                            <div class="emoji-render-content">阿打算打打打发</div>
                                        </div>
                                        <div class="actions">
                                            (
                                            <a class="text-primary weibo-favor" weibo-id="1334">
                                                <i class="icon-thumbs-o-up"></i> 0</a>
                                            <a href="/weibo/detail/1334"><i class="icon-chat"></i> 0</a>
                                            <a href="/weibo/detail/1334">查看详情</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="comment">
                                    <a href="/u/700" class="avatar" target="_blank">
                                        <img src="/Aesopsns/res/common/images/default-avatar.png"
                                             class="icon-camera-retro icon-2x">
                                    </a>
                                    <div class="content">
                                        <div class="pull-right text-muted timeago" datetime="2018-04-11 11:58:22"></div>
                                        <div>
                                            <a href="/u/700" target="_blank">
                                                <strong>979955176</strong>
                                            </a>
                                        </div>
                                        <div class="text">
                                            <div class="emoji-render-content">大佬你好，我没学习过框架。你的源码下载再来之后我不知道怎么才能在我电脑上跑起来。大佬可以帮下忙吗？
</div>
                                        </div>
                                        <div class="actions">
                                            (
                                            <a class="text-primary weibo-favor" weibo-id="1336">
                                                <i class="icon-thumbs-o-up"></i> 0</a>
                                            <a href="/weibo/detail/1336"><i class="icon-chat"></i> 2</a>
                                            <a href="/weibo/detail/1336">查看详情</a>
                                        </div>
                                    </div>
                                </div>
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
    $(function () {
        $(".pagination").jeesns_page("jeesnsPageForm");
        $(".weibo-favor").click(function () {
            weibo.favor($(this), "")
        });
        $('#emoji').emoji({
            insertAfter: function (item) {
                $('#weibo-content').insertContent(':' + item.name + ':')
            }
        }, "");
        $(".weibo-picture").click(function () {
            var weiboPictureArea = $(".weibo-picture-area");
            if (weiboPictureArea.is(':hidden')) {
                weiboPictureArea.show();
                $.getScript("/Aesopsns/res/plugins/webuploader/weiboUpload.js");
            } else {
                weiboPictureArea.hide();
            }
        });
    });
</script>
</body>
</html>