package com.aesopsns.entity.album;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="albums")
public class Album {
	private int id;
	private String namess;			//有关键词冲突啊
	private String intro;
	private String username;        //谁的相册
	private int upvotes;		    //相册总点赞数
	private String faces;			//相册中上传的第一张图片，用来做一个相册的封面
	private int rights;				//权限管理：0 所有人    1 相互关注的人    2 仅自己
	private int num;				//相册照片数
	@Id
	@GeneratedValue(generator = "my_gen")
	@GenericGenerator(name = "my_gen", strategy = "increment")  
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getUpvotes() {
		return upvotes;
	}
	public void setUpvotes(int upvotes) {
		this.upvotes = upvotes;
	}
	public int getRights() {
		return rights;
	}
	public void setRights(int rights) {
		this.rights = rights;
	}
	public String getFaces() {
		return faces;
	}
	public void setFaces(String faces) {
		this.faces = faces;
	}
	public String getNamess() {
		return namess;
	}
	public void setNamess(String namess) {
		this.namess = namess;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
}
