package com.aesopsns.entity.user;

//跟PrivateMessageBean是一个套路呢
public class ContactMemberBean {
	private String mail;				//用户邮箱
	private String target;				//联系对象的名字
	private String icon;
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
}
