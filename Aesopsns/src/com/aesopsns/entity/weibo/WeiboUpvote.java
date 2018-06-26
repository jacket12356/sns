package com.aesopsns.entity.weibo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="weiboupvotes")
public class WeiboUpvote {
	private int id;
	private String mail;
	private int weiboid;
	
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
	public int getWeiboid() {
		return weiboid;
	}
	public void setWeiboid(int weiboid) {
		this.weiboid = weiboid;
	}
}
