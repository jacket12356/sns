var group = {
    commentList : function (groupTopicId,pageNo) {
        $.ajax({
            url : base+"/group/commentList/"+groupTopicId,
            type : "get",
            dataType: "json",
            success : function (data) {
            	var html = "";
                for (var i = 0; i < data.length; i++) {
                    html += "<div class=\"comment\">" +
                        "<a href=\"" +  "/Aesopsns/user/others/" + data[i].member.name + "\" class=\"avatar\">" +
                        "<img src=\"" +  "/Aesopsns/res/common/uploads/" + data[i].member.icon + "\" class=\"icon-4x\"></a><div class=\"content\">" +
                        "<div class=\"pull-right text-muted\">" + data[i].createdtime + "</div><div>" +
                        "<a href=\"" +  "/Aesopsns/user/others/" + data[i].member.name + "\"><strong>" + data[i].member.name + "</strong></a></div>" +
                        "<div class=\"text\">";
                    var weiboComment = data[i].weiboComment;
                    if (weiboComment != null){
                        html += "<pre><code><p>引用“<a href='"+basePath+"/user/others/"+weiboComment.member.name+"'>"+weiboComment.member.name+"</a>”的评论</p>"+weiboComment.content+"</code></pre>";
                    }
                    html += data[i].content + "<div class='pull-right'><a href='javascript:weibo.commentReply("+data[i].id+")'>回复</a></div></div>" +
                        "<form class=\"form-horizontal jeesns_form\" action=\""+basePath+"/group/comment/"+groupTopicId+"\" method=\"post\" id='comment-form-"+data[i].id+"' style='display: none;'>" +
                        "<div class=\"form-group\"><input type='hidden' name='postCommentId' value='"+data[i].id+"'/>" +
                        "<textarea name=\"content\" class=\"form-control weibo-comment-content\" rows=\"2\" id=\""+data[i].id+"\" maxlength=\""+200+"\"></textarea></div>" +
                        "<div class=\"form-group comment-user\"><span class=\"mg-r-5 weibo-words-"+data[i].id+"\">0/"+200+"</span>" +
                        "<input type=\"submit\" value=\"回复\" class=\"pull-right btn btn-primary mg-t-10 jeesns-submit\"></div></form></div></div>";
                }
                //pageNo = json.page.pageNo;
                //if (json.page.totalPage <= pageNo) {
                //分页就先不弄了
                    $("#moreComment").hide();
                //} else {
                   // $("#moreComment").show();
                //}
                $("#commentList").append(html);
                //$('.jeesns_form').unbind();
                //jeesns.submitForm();
            }
        });
    },
    commentReply: function (id) {
        $('#comment-form-'+id).toggle();
        $('#'+id).focus();
    },
    favor : function (_this,base) {
        var topicId = _this.attr("topic-id");
        $.ajax({
            url: base + "/group/topic/favor/" + topicId,
            type: "get",
            dataType: "json",
            timeout: 5000,
            success: function (res) {
                if (res.code < 0) {
                    jeesnsDialog.errorTips(res.message);
                } else {
                    if (res.code == 0) {
                        _this.html("<i class='icon-heart'></i> 喜欢 | " + res.data);
                        _this.removeClass("btn-article-unfavor")
                    } else {
                        _this.html("<i class='icon-heart-empty'></i> 喜欢 | " + res.data);
                        _this.addClass("btn-article-unfavor");
                    }
                }
            }
        });
    },
    commentReply: function (id) {
        $('#comment-form-'+id).toggle();
        $('#'+id).focus();
    }
}
var weibo = {
	    commentList : function (groupTopicId,pageNo) {
	        $.ajax({
	            url : base+"/group/commentList/"+groupTopicId,
	            type : "get",
	            dataType: "json",
	            success : function (data) {
	            	var html = "";
	                for (var i = 0; i < data.length; i++) {
	                    html += "<div class=\"comment\">" +
	                        "<a href=\"" +  "/Aesopsns/user/others/" + data[i].member.name + "\" class=\"avatar\">" +
	                        "<img src=\"" +  "/Aesopsns/res/common/uploads/" + data[i].member.icon + "\" class=\"icon-4x\"></a><div class=\"content\">" +
	                        "<div class=\"pull-right text-muted\">" + data[i].createdtime + "</div><div>" +
	                        "<a href=\"" +  "/Aesopsns/user/others/" + data[i].member.name + "\"><strong>" + data[i].member.name + "</strong></a></div>" +
	                        "<div class=\"text\">";
	                    var weiboComment = data[i].weiboComment;
	                    if (weiboComment != null){
	                        html += "<pre><code><p>引用“<a href='"+basePath+"/user/others/"+weiboComment.member.name+"'>"+weiboComment.member.name+"</a>”的评论</p>"+weiboComment.content+"</code></pre>";
	                    }
	                    html += data[i].content + "<div class='pull-right'><a href='javascript:weibo.commentReply("+data[i].id+")'>回复</a></div></div>" +
	                        "<form class=\"form-horizontal jeesns_form\" action=\""+basePath+"/group/comment/"+groupTopicId+"\" method=\"post\" id='comment-form-"+data[i].id+"' style='display: none;'>" +
	                        "<div class=\"form-group\"><input type='hidden' name='postCommentId' value='"+data[i].id+"'/>" +
	                        "<textarea name=\"content\" class=\"form-control weibo-comment-content\" rows=\"2\" id=\""+data[i].id+"\" maxlength=\""+200+"\"></textarea></div>" +
	                        "<div class=\"form-group comment-user\"><span class=\"mg-r-5 weibo-words-"+data[i].id+"\">0/"+200+"</span>" +
	                        "<input type=\"submit\" value=\"回复\" class=\"pull-right btn btn-primary mg-t-10 jeesns-submit\"></div></form></div></div>";
	                }
	                //pageNo = json.page.pageNo;
	                //if (json.page.totalPage <= pageNo) {
	                //分页就先不弄了
	                    $("#moreComment").hide();
	                //} else {
	                   // $("#moreComment").show();
	                //}
	                $("#commentList").append(html);
	                //$('.jeesns_form').unbind();
	                //jeesns.submitForm();
	            }
	        });
	    },
	    commentReply: function (id) {
	        $('#comment-form-'+id).toggle();
	        $('#'+id).focus();
	    },
	    favor : function (_this,base) {
	        var topicId = _this.attr("topic-id");
	        $.ajax({
	            url: base + "/group/topic/favor/" + topicId,
	            type: "get",
	            dataType: "json",
	            timeout: 5000,
	            success: function (res) {
	                if (res.code < 0) {
	                    jeesnsDialog.errorTips(res.message);
	                } else {
	                    if (res.code == 0) {
	                        _this.html("<i class='icon-heart'></i> 喜欢 | " + res.data);
	                        _this.removeClass("btn-article-unfavor")
	                    } else {
	                        _this.html("<i class='icon-heart-empty'></i> 喜欢 | " + res.data);
	                        _this.addClass("btn-article-unfavor");
	                    }
	                }
	            }
	        });
	    },
	    commentReply: function (id) {
	        $('#comment-form-'+id).toggle();
	        $('#'+id).focus();
	    }
	}
