package com.aesopsns.entity.album;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="pictureupvotes")
public class PictureUpvote {
	private int id;
	private String mail;
	private int pictureid;
	
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
	public int getPictureid() {
		return pictureid;
	}
	public void setPictureid(int pictureid) {
		this.pictureid = pictureid;
	}
}
