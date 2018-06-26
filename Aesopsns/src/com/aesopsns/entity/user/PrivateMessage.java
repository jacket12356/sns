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
@Table(name="privatemessage")
//这个Bean代表私信功能中的消息
//与User是一对多的关系
public class PrivateMessage {
	private int id;
	private String mail;				//用户邮箱，做关联用
	private String sender;				//用户名
	private String target;				//用户联系对象名
	private String message;				//消息文本
	private String time;				//消息接收时刻
	//下面这个icon是为了方便在chatframe中动态生成对话框的，必须填写绝对路径
	private String icon;
	//privatemessage与user之间的多对多关系
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
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	@ManyToMany(mappedBy="pmSet",fetch=FetchType.EAGER)
	public Set<User> getUserSet() {
		return userSet;
	}
	public void setUserSet(Set<User> userSet) {
		this.userSet = userSet;
	}
}

//这个私信模块还真是挺有意思的啊
//CREATE TABLE `userpm` (
//`mail` varchar(50) NOT NULL,
//`pmid` int(11) NOT NULL,
//PRIMARY KEY (`mail`,`pmid`),
//KEY `pmid` (`pmid`),
//CONSTRAINT `userpm_ibfk_1` FOREIGN KEY (`mail`) REFERENCES `user_base` (`mail`),
//CONSTRAINT `userpm_ibfk_2` FOREIGN KEY (`pmid`) REFERENCES `privatemessage` (`id`)
//) ENGINE=InnoDB DEFAULT CHARSET=utf8;


