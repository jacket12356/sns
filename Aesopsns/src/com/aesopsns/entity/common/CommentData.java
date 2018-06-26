package com.aesopsns.entity.common;

//第三层封装（应该说是第二层，但是涉及到了两次数据封装嘛），这是真正传到前台的Bean
public class CommentData {
	//评论本体
	private int id;
	private String createdtime;
	private String content;
	//评论人
	private Member member;
	//被引用的评论
	private CommentBean weiboComment;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCreatedtime() {
		return createdtime;
	}
	public void setCreatedtime(String createdtime) {
		this.createdtime = createdtime;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public CommentBean getWeiboComment() {
		return weiboComment;
	}
	public void setWeiboComment(CommentBean weiboComment) {
		this.weiboComment = weiboComment;
	}
}
