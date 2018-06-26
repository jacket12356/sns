package com.aesopsns.entity.user;

//转json用
public class PrivateMessageBean {
	private String mail;				//用户邮箱，做关联用
	private String sender;				//用户名
	private String target;				//用户联系对象名
	private String message;				//消息文本
	private String time;				//消息接收时刻
	//下面这个icon是为了方便在chatframe中动态生成对话框的，必须填写绝对路径
	private String icon;
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
}
