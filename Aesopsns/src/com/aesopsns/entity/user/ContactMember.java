package com.aesopsns.entity.user;

import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="contactmember")
//私信竟然需要建两个实体Bean
//与User是多对多的关系(如果配多对多的话，信息量会小一倍吧)
public class ContactMember {
	private int id;
	private String mail;				//用户邮箱
	private String target;				//联系对象的名字
	private String contactmember;		//识别数据库表中联系人对象用
	//contactmember与user之间的多对多关系
	private Set<User> userSet = new LinkedHashSet<>();
	
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
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getContactmember() {
		return contactmember;
	}
	public void setContactmember(String contactmember) {
		this.contactmember = contactmember;
	}
	@ManyToMany(mappedBy="cmSet",fetch=FetchType.EAGER)
	public Set<User> getUserSet() {
		return userSet;
	}
	public void setUserSet(Set<User> userSet) {
		this.userSet = userSet;
	}
}

//没想到都弄到写SQL语句的地步了
//CREATE TABLE `usercm` (
//  `mail` varchar(50) NOT NULL,
//  `cmid` int(11) NOT NULL,
//  PRIMARY KEY (`mail`,`cmid`),
//  KEY `cmid` (`cmid`),
//  CONSTRAINT `usercm_ibfk_1` FOREIGN KEY (`mail`) REFERENCES `user_base` (`mail`),
//  CONSTRAINT `usercm_ibfk_2` FOREIGN KEY (`cmid`) REFERENCES `contactmember` (`id`)
//) ENGINE=InnoDB DEFAULT CHARSET=utf8;
