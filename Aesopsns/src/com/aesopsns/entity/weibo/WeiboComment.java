package com.aesopsns.entity.weibo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

//评论数据在持久层的表现形式
@Entity
@Table(name="weibocomments")
public class WeiboComment {
	private int id;
	private int weiboid;		//表明这是哪条微博的评论
	private String createdtime;
	private String content;
	private String username;	//谁发的微博，可以用这个参数查出user
	private int cited;		//表示该评论是否被引用 1 true
	private int citedcommemtid; //被引用的评论是哪一条
	
	@Id
	@GeneratedValue(generator = "my_gen")
	@GenericGenerator(name = "my_gen", strategy = "increment")  
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getWeiboid() {
		return weiboid;
	}
	public void setWeiboid(int weiboid) {
		this.weiboid = weiboid;
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
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getCited() {
		return cited;
	}
	public void setCited(int cited) {
		this.cited = cited;
	}
	public int getCitedcommemtid() {
		return citedcommemtid;
	}
	public void setCitedcommemtid(int citedcommemtid) {
		this.citedcommemtid = citedcommemtid;
	}
}
