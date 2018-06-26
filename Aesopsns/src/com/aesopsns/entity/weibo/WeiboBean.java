package com.aesopsns.entity.weibo;

import com.aesopsns.entity.user.User;

//为方便前台数据展示，特将weibo与user封装到一起
public class WeiboBean {
	private Weibo w;
	private User u;
	//weibo中的pictures得分开呢
	private String[] images;
	public Weibo getW() {
		return w;
	}
	public void setW(Weibo w) {
		this.w = w;
	}
	public User getU() {
		return u;
	}
	public void setU(User u) {
		this.u = u;
	}
	public String[] getImages() {
		return images;
	}
	public void setImages(String[] images) {
		this.images = images;
	}
}
