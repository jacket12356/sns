package com.aesopsns.entity.user;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

//User和User_detail之间是一对一的关系
@Entity
@Table(name="user_detail")
public class User_detail {
	//
	private String mail;
	private String sex;				//male, female, privacy(null)
	private String intro;			//个人简介
	private String birthday;		//生日（yyyy-mm-dd）
	private String qq;
	private String wechat;
	private String cellphone;
	private String personal_web; 	//个人网站
	private String icon;			//头像（存放路径）
	private String join_time;		//加入时间
	private int focus;				//关注数（这个在写以后的版块时才会用到吧）
	private int fans;				//粉丝数（同上）
	private int credit;				//积分（对应一个积分机制，目前还不知道积分可以用来干什么）
	private String recent_login;	//最近登入时间
	//使用到了hibernate的一对一机制
	private User user;
	
	@OneToOne(cascade=CascadeType.ALL)
	@PrimaryKeyJoinColumn(name="mail")
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getRecent_login() {
		return recent_login;
	}
	public void setRecent_login(String recent_login) {
		this.recent_login = recent_login;
	}
	public String getJoin_time() {
		return join_time;
	}
	public void setJoin_time(String join_time) {
		this.join_time = join_time;
	}
	@Id
	public String getMail() {
		return this.mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getWechat() {
		return wechat;
	}
	public void setWechat(String wechat) {
		this.wechat = wechat;
	}
	public String getCellphone() {
		return cellphone;
	}
	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	public String getPersonal_web() {
		return personal_web;
	}
	public void setPersonal_web(String personal_web) {
		this.personal_web = personal_web;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public int getFocus() {
		return focus;
	}
	public void setFocus(int focus) {
		this.focus = focus;
	}
	public int getFans() {
		return fans;
	}
	public void setFans(int fans) {
		this.fans = fans;
	}
	public int getCredit() {
		return credit;
	}
	public void setCredit(int credit) {
		this.credit = credit;
	}
}
