package com.aesopsns.entity.user;

//展示某种数据的页面元素里还要展示一些相关的附加元素，在这个项目中这种问题我已经碰到很多次了
//有的时候我会配hibernate关系，但这会产生很多overhead
//有的时候我也会像下面这样封装一下
public class FollowBean {
	private Follow follow;
	//follower or befollowed
	private User user;
	private User_detail ud;
	public Follow getFollow() {
		return follow;
	}
	public void setFollow(Follow follow) {
		this.follow = follow;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public User_detail getUd() {
		return ud;
	}
	public void setUd(User_detail ud) {
		this.ud = ud;
	}
}
