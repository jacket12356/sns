package com.aesopsns.entity.user;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="creditdetail")
//User与CreditDetail之间是一对多的关系
public class CreditDetail {
	private int id;				//个体ID，自增
	private String mail;		//关联用户ID
	private int alteration;		//变动积分
	private String comment;		//备注：说明变动积分缘由
	private String time;		//变动时间
	//creditdetail与user之间的多对一关系
	private User user;
	
	@Id
	@GeneratedValue(generator = "my_gen")
	@GenericGenerator(name = "my_gen", strategy = "increment")
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public int getAlteration() {
		return alteration;
	}
	public void setAlteration(int alteration) {
		this.alteration += alteration;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	@ManyToOne
	@JoinColumn(name="mail",insertable=false,updatable=false)
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
}
