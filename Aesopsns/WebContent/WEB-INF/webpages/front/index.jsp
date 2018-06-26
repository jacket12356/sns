<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AESOPSNS - 又一个AESOPSNS社区 - Powered By AESOPSNS</title>
    <meta name="keywords" content="AESOPSNS,sns,java"/>
    <meta name="description" content="AESOPSNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优势，开创国内JAVA版开源SNS先河。"/>
    <meta name="author" content="AESOPSNS"/>
    <link rel="shortcut icon" href="/Aesopsns/favicon.ico">
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
</head>
<body class="gray-bg">
<!-- 静态引用header -->
<%@ include file="/WEB-INF/webpages/front/jspf/header.jspf"%>

<div class="container">
    <div id="banner" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#banner" data-slide-to="0" class="active"></li>
            <li data-target="#banner" data-slide-to="1"></li>
            <li data-target="#banner" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="item active">
                <img alt="First slide" src="res/front/images/banner1.png">
                <div class="carousel-caption">
                    <h3></h3>
                    <p></p>
                </div>
            </div>
            <div class="item">
                <img alt="Second slide" src="res/front/images/banner2.png">
                <div class="carousel-caption">
                    <h3></h3>
                    <p></p>
                </div>
            </div>
            <div class="item">
                <img alt="Third slide" src="res/front/images/banner3.png">
                <div class="carousel-caption">
                    <h3></h3>
                    <p></p>
                </div>
            </div>
        </div>
    </div>

    <div class="main-content m-t-10">
        <div class="row">
            <div class="col-md-12">
                <div class="panel group-topic-list no-border">
                    <div class="panel-heading">
                        推荐阅读
                        <span class="pull-right">
                            <a class="btn btn-primary m-t-n4" href="/article/list">阅读更多</a>
                        </span>
                    </div>
                    <div class="panel-body">
                        <div class="items">
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9945">
                                                    <img src="//upload-images.jianshu.io/upload_images/4259662-c2dc6d761dab2414.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/700" alt="你还在用传统的 JDBC 持久化访问吗" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9945">
                                                你还在用传统的 JDBC 持久化访问...
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9945" class="text-muted"><i class="icon-comments"></i> 454</a> &nbsp; <span class="text-muted">2018-01-04 17:12</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9944">
                                                    <img src="/upload/images/20171225/8843872d-dde0-4879-b828-b1c5eee2dde1.png" alt="Java NIO和IO的主要区别" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9944">
                                                Java NIO和IO的主要区别
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9944" class="text-muted"><i class="icon-comments"></i> 349</a> &nbsp; <span class="text-muted">2017-12-25 13:09</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9942">
                                                    <img src="https://user-gold-cdn.xitu.io/2017/10/11/45cab323f72a20e94ace74464fe8f54b?imageView2/0/w/1280/h/960/format/webp/ignore-error/1" alt="ArrayList 底层数组扩容原理" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9942">
                                                ArrayList 底层数组扩容原理
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9942" class="text-muted"><i class="icon-comments"></i> 315</a> &nbsp; <span class="text-muted">2017-12-19 15:01</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9439">
                                                    <img src="http://resources.jeesns.cn/upload/images/201711/1510208480467.png" alt="【我读《Big Data》】序言部分--拥抱“大数据时代”" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9439">
                                                【我读《Big Data》】序言部分...
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9439" class="text-muted"><i class="icon-comments"></i> 283</a> &nbsp; <span class="text-muted">2017-11-09 14:19</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9438">
                                                    <img src="http://resources.jeesns.cn/upload/images/201711/1510207925967.png" alt="JavaScript四舍五入的那些坑" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9438">
                                                JavaScript四舍五入的那些坑
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9438" class="text-muted"><i class="icon-comments"></i> 276</a> &nbsp; <span class="text-muted">2017-11-09 14:09</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9437">
                                                    <img src="http://resources.jeesns.cn/upload/images/201711/1510207798421.jpg" alt="马云提出了新零售，但实践得最好的却是家装巨头土巴兔" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9437">
                                                马云提出了新零售，但实践得最好的却是...
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9437" class="text-muted"><i class="icon-comments"></i> 480</a> &nbsp; <span class="text-muted">2017-11-09 14:07</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9436">
                                                    <img src="http://resources.jeesns.cn/upload/images/201711/1510207259014.jpg" alt="原来，最适合女生的工作居然是全能UID设计师！" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9436">
                                                原来，最适合女生的工作居然是全能UI...
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9436" class="text-muted"><i class="icon-comments"></i> 286</a> &nbsp; <span class="text-muted">2017-11-09 13:58</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9435">
                                                    <img src="http://resources.jeesns.cn/upload/images/201711/1510207232936.jpg" alt="parseInt() 的第二个参数" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9435">
                                                parseInt() 的第二个参数
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9435" class="text-muted"><i class="icon-comments"></i> 250</a> &nbsp; <span class="text-muted">2017-11-09 13:58</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9433">
                                                    <img src="http://resources.jeesns.cn/upload/images/201711/1510206439983.png" alt="赚钱很难？那是你还没找到方法！一个帖子引流精准粉90000+" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9433">
                                                赚钱很难？那是你还没找到方法！一个帖...
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9433" class="text-muted"><i class="icon-comments"></i> 361</a> &nbsp; <span class="text-muted">2017-11-09 13:45</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9432">
                                                    <img src="http://resources.jeesns.cn/upload/images/201711/1510206413202.png" alt="现金贷与消费升级背后，趣店如何成就88亿美元市值？" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9432">
                                                现金贷与消费升级背后，趣店如何成就8...
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9432" class="text-muted"><i class="icon-comments"></i> 195</a> &nbsp; <span class="text-muted">2017-11-09 13:44</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9430">
                                                    <img src="http://resources.jeesns.cn/upload/images/201711/1510205749577.png" alt="美图的图片生意，电商化是唯一出路？" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9430">
                                                美图的图片生意，电商化是唯一出路？
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9430" class="text-muted"><i class="icon-comments"></i> 235</a> &nbsp; <span class="text-muted">2017-11-09 13:33</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9427">
                                                    <img src="http://resources.jeesns.cn/upload/images/201711/1510203835124.gif" alt="css3 字母人动画" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9427">
                                                css3 字母人动画
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9427" class="text-muted"><i class="icon-comments"></i> 273</a> &nbsp; <span class="text-muted">2017-11-09 13:01</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9425">
                                                    <img src="http://resources.jeesns.cn/upload/images/201711/1510203125749.jpg" alt="公益教育正在为共享教育打开一扇大门？" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9425">
                                                公益教育正在为共享教育打开一扇大门？
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9425" class="text-muted"><i class="icon-comments"></i> 199</a> &nbsp; <span class="text-muted">2017-11-09 12:49</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9424">
                                                    <img src="http://resources.jeesns.cn/upload/images/201711/1510203099889.jpg" alt="腾讯小米网易大战吃鸡游戏 未占先机的腾讯无奈只能落败！" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9424">
                                                腾讯小米网易大战吃鸡游戏 未占先机的...
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9424" class="text-muted"><i class="icon-comments"></i> 212</a> &nbsp; <span class="text-muted">2017-11-09 12:49</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9423">
                                                    <img src="http://resources.jeesns.cn/upload/images/201711/1510203072405.png" alt="未来10年，这三大行业将出现大批富翁，你入对行了吗？" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9423">
                                                未来10年，这三大行业将出现大批富翁...
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9423" class="text-muted"><i class="icon-comments"></i> 202</a> &nbsp; <span class="text-muted">2017-11-09 12:49</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="item index-article">
                                        <div class="item-content">
                                            <div class="media">
                                                <a href="/article/detail/9422">
                                                    <img src="http://resources.jeesns.cn/upload/images/201711/1510203045296.jpg" alt="《纪念碑谷2》将成系列绝唱！开发商不愿再开发续作" height="150px" width="100%">
                                                </a>
                                            </div>
                                            <h4><a href="/article/detail/9422">
                                                《纪念碑谷2》将成系列绝唱！开发商不...
                                            </a></h4>
                                        </div>
                                        <div class="item-footer">
                                            <a href="/article/detail/9422" class="text-muted"><i class="icon-comments"></i> 186</a> &nbsp; <span class="text-muted">2017-11-09 12:48</span>
                                        </div>
                                    </div>
                                </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-12">
                <div class="panel group-topic-list no-border">
                    <div class="panel-heading">
                        最新帖子
                        <span class="pull-right">
                            <a class="btn btn-primary m-t-n4" href="/group/">阅读更多</a>
                        </span>
                    </div>
                    <div class="panel-body">
                        <div class="items">
                            <div class="col-md-4">
                                <div class="article-hot-list">
                                    <ul>
                                            <li><i class="main-text-color"></i> <a href="/group/topic/504">
                                                哈哈
                                            </a></li>
                                            <li><i class="main-text-color"></i> <a href="/group/topic/503">
                                                对对对
                                            </a></li>
                                            <li><i class="main-text-color"></i> <a href="/group/topic/502">
                                                121212
                                            </a></li>
                                            <li><i class="main-text-color"></i> <a href="/group/topic/501">
                                                sadas
                                            </a></li>
                                            <li><i class="main-text-color"></i> <a href="/group/topic/500">
                                                测试看看
                                            </a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="items">
                                        <div class="col-md-4">
                                            <div class="item index-article">
                                                <div class="item-content">
                                                    <div class="media">
                                                        <a href="/group/topic/501">
                                                            <img src="/upload/images/20180125/5aa5afbf-8fae-42d5-b776-6bdf74a72218.jpg" alt="sadas" height="150px" width="100%">
                                                        </a>
                                                    </div>
                                                    <h4><a href="/group/topic/501">sadas</a></h4>
                                                </div>
                                                <div class="item-footer">
                                                    <a href="/group/topic/501" class="text-muted"><i class="icon-comments"></i> 112</a> &nbsp; <span class="text-muted">2018-01-25 13:23</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="item index-article">
                                                <div class="item-content">
                                                    <div class="media">
                                                        <a href="/group/topic/500">
                                                            <img src="/upload/images/20180113/47fedf10-2a1c-4d48-ba3e-049080e2720f.png" alt="测试看看" height="150px" width="100%">
                                                        </a>
                                                    </div>
                                                    <h4><a href="/group/topic/500">测试看看</a></h4>
                                                </div>
                                                <div class="item-footer">
                                                    <a href="/group/topic/500" class="text-muted"><i class="icon-comments"></i> 143</a> &nbsp; <span class="text-muted">2018-01-13 19:52</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="item index-article">
                                                <div class="item-content">
                                                    <div class="media">
                                                        <a href="/group/topic/491">
                                                            <img src="https://static.oschina.net/uploads/space/2017/0814/123133_FP3x_1177077.png" alt="Eclipse导入JEESNS1.2.0项目和部署教程" height="150px" width="100%">
                                                        </a>
                                                    </div>
                                                    <h4><a href="/group/topic/491">Eclipse导入JEESNS1.2.0项目和部署教程</a></h4>
                                                </div>
                                                <div class="item-footer">
                                                    <a href="/group/topic/491" class="text-muted"><i class="icon-comments"></i> 1629</a> &nbsp; <span class="text-muted">2017-08-14 12:40</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="item index-article">
                                                <div class="item-content">
                                                    <div class="media">
                                                        <a href="/group/topic/487">
                                                            <img src="/upload/images/20170719/thumb_290f33e3-8ba0-4b0c-8760-bdd773a696f2.jpg" alt="毕竟相爱一场，不要谁心里带着伤" height="150px" width="100%">
                                                        </a>
                                                    </div>
                                                    <h4><a href="/group/topic/487">毕竟相爱一场，不要谁心里带着伤</a></h4>
                                                </div>
                                                <div class="item-footer">
                                                    <a href="/group/topic/487" class="text-muted"><i class="icon-comments"></i> 1471</a> &nbsp; <span class="text-muted">2017-07-19 13:16</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="item index-article">
                                                <div class="item-content">
                                                    <div class="media">
                                                        <a href="/group/topic/486">
                                                            <img src="http://www.jeesns.cn/upload/images/20170314/1489476273532009007.png" alt="JEESNS V1.0.2 发布，JAVA 开源 SNS 社区系统" height="150px" width="100%">
                                                        </a>
                                                    </div>
                                                    <h4><a href="/group/topic/486">JEESNS V1.0.2 发布，JAVA 开源 SNS 社区系统</a></h4>
                                                </div>
                                                <div class="item-footer">
                                                    <a href="/group/topic/486" class="text-muted"><i class="icon-comments"></i> 2050</a> &nbsp; <span class="text-muted">2017-04-17 12:22</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="item index-article">
                                                <div class="item-content">
                                                    <div class="media">
                                                        <a href="/group/topic/483">
                                                            <img src="http://www.jeesns.cn/upload/images/20170314/1489476273532009007.png" alt="JEESNS V1.0.1 发布，JAVA 开源 SNS 社区系统" height="150px" width="100%">
                                                        </a>
                                                    </div>
                                                    <h4><a href="/group/topic/483">JEESNS V1.0.1 发布，JAVA 开源 SNS 社区系统</a></h4>
                                                </div>
                                                <div class="item-footer">
                                                    <a href="/group/topic/483" class="text-muted"><i class="icon-comments"></i> 903</a> &nbsp; <span class="text-muted">2017-04-10 13:20</span>
                                                </div>
                                            </div>
                                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="panel group-topic-list no-border">
                    <div class="panel-heading">
                        推荐群组
                        <span class="pull-right">
                            <a class="btn btn-primary m-t-n4" href="/group/">查看更多</a>
                        </span>
                    </div>
                    <div class="panel-body">
                        <div class="items">
                            <div class="col-md-12 group-list">
                                    <div class="col-md-3">
                                        <div class="group-detail">
                                            <div class="group-logo">
                                                <a href="/group/detail/11">
                                                    <img alt="image" class="img-rounded" src="/upload/images/20170306/14887779297105.png" width="100px" height="100px">
                                                </a>
                                            </div>
                                            <div class="group-info">
                                                <h4><strong><a href="/group/detail/11">js</a></strong></h4>
                                                <p class="text-muted">
                                                    js的工作园地
                                                </p>
                                                <small class="text-muted">1篇文章 · 19人关注</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="group-detail">
                                            <div class="group-logo">
                                                <a href="/group/detail/10">
                                                    <img alt="image" class="img-rounded" src="res/common/images/nopic.png" width="100px" height="100px">
                                                </a>
                                            </div>
                                            <div class="group-info">
                                                <h4><strong><a href="/group/detail/10">Node.js</a></strong></h4>
                                                <p class="text-muted">
                                                    node
                                                </p>
                                                <small class="text-muted">1篇文章 · 3人关注</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="group-detail">
                                            <div class="group-logo">
                                                <a href="/group/detail/6">
                                                    <img alt="image" class="img-rounded" src="/upload/images/20170208/14865394731375.jpg" width="100px" height="100px">
                                                </a>
                                            </div>
                                            <div class="group-info">
                                                <h4><strong><a href="/group/detail/6">Python</a></strong></h4>
                                                <p class="text-muted">
                                                    
                                                </p>
                                                <small class="text-muted">1篇文章 · 37人关注</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="group-detail">
                                            <div class="group-logo">
                                                <a href="/group/detail/5">
                                                    <img alt="image" class="img-rounded" src="/upload/images/20170208/14865396015802.jpg" width="100px" height="100px">
                                                </a>
                                            </div>
                                            <div class="group-info">
                                                <h4><strong><a href="/group/detail/5">WEB前端</a></strong></h4>
                                                <p class="text-muted">
                                                    
                                                </p>
                                                <small class="text-muted">1篇文章 · 24人关注</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="group-detail">
                                            <div class="group-logo">
                                                <a href="/group/detail/4">
                                                    <img alt="image" class="img-rounded" src="/upload/images/20170208/14865394185124.jpg" width="100px" height="100px">
                                                </a>
                                            </div>
                                            <div class="group-info">
                                                <h4><strong><a href="/group/detail/4">iOS</a></strong></h4>
                                                <p class="text-muted">
                                                    
                                                </p>
                                                <small class="text-muted">1篇文章 · 9人关注</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="group-detail">
                                            <div class="group-logo">
                                                <a href="/group/detail/3">
                                                    <img alt="image" class="img-rounded" src="/upload/images/20170208/14865393897362.jpg" width="100px" height="100px">
                                                </a>
                                            </div>
                                            <div class="group-info">
                                                <h4><strong><a href="/group/detail/3">Android</a></strong></h4>
                                                <p class="text-muted">
                                                    
                                                </p>
                                                <small class="text-muted">1篇文章 · 11人关注</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="group-detail">
                                            <div class="group-logo">
                                                <a href="/group/detail/2">
                                                    <img alt="image" class="img-rounded" src="/upload/images/20170208/14865393048883.png" width="100px" height="100px">
                                                </a>
                                            </div>
                                            <div class="group-info">
                                                <h4><strong><a href="/group/detail/2">JAVA</a></strong></h4>
                                                <p class="text-muted">
                                                    
                                                </p>
                                                <small class="text-muted">1篇文章 · 21人关注</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="group-detail">
                                            <div class="group-logo">
                                                <a href="/group/detail/1">
                                                    <img alt="image" class="img-rounded" src="/upload/images/20170207/14864365554203.png" width="100px" height="100px">
                                                </a>
                                            </div>
                                            <div class="group-info">
                                                <h4><strong><a href="/group/detail/1">JEESNS讨论组</a></strong></h4>
                                                <p class="text-muted">
                                                    JEESNS是一款基于JAVA企业级平台研发的社交管理系统，依托企业级JAVA的高效、安全、稳定等优...
                                                </p>
                                                <small class="text-muted">1篇文章 · 30人关注</small>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="panel group-topic-list no-border">
                    <div class="panel-heading">
                        友情链接
                        <span class="pull-right">
                            <a class="btn btn-primary m-t-n4" href="/link">查看更多</a>
                        </span>
                    </div>
                    <div class="panel-body friend-link">
                        <ul>
                            <li><a href="http://www.czcto.com" target="_blank">ACFUN</a></li>
                            <li><a href="http://www.vwangluo.com" target="_blank">虎嗅</a></li>
                            <li><a href="http://www.lxinet.com" target="_blank">游民星空</a></li>
                            <li><a href="http://www.919dns.com" target="_blank">Github</a></li>
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
    });
</script>
</body>
</html>