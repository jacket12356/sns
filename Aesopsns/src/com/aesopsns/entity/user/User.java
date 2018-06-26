package com.aesopsns.entity.user;

import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.aesopsns.entity.article.Article;
import com.aesopsns.entity.article.ArticleComment;

@Entity
@Table(name="user_base")
public class User {
	private String mail;		
	private String name;		
	private String password;
	private String icon;
	//hibernate的一对一，一个用户有其对应的详细信息
	private User_detail ud;
	//user与creditdetail之间的一对多关系
	private Set<CreditDetail> cdSet = new LinkedHashSet<>();
	//user与contactmember之间的多对多关系
	private Set<ContactMember> cmSet = new LinkedHashSet<>();
	//user与privatemessage之间的多对多关系
	private Set<PrivateMessage> pmSet = new LinkedHashSet<>();
	//user与article之间的一对多关系
	private Set<Article> articleSet = new LinkedHashSet<>();
	//user与articlecomment之间是一对多关系
	private Set<ArticleComment> acset = new LinkedHashSet<>();
	
	//这个user是User_detail中的成员吗，竟然不是表名
	@OneToOne(mappedBy="user")
	public User_detail getUd() {
		return ud;
	}
	public void setUd(User_detail ud) {
		this.ud = ud;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Id
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	
	
	//user与CreditDetail之间的一对多关系
	@OneToMany(mappedBy="user", targetEntity=CreditDetail.class, cascade=CascadeType.ALL, fetch=FetchType.EAGER)
	public Set<CreditDetail> getCdSet() {
		return cdSet;
	}
	public void setCdSet(Set<CreditDetail> cdSet) {
		this.cdSet = cdSet;
	}
	
	
	//user与ContactMember之间的一对多关系
	@ManyToMany(fetch=FetchType.EAGER)
    @JoinTable(name="usercm", 
        joinColumns=@JoinColumn(name="mail"),
        inverseJoinColumns=@JoinColumn(name="cmid"))
	public Set<ContactMember> getCmSet() {
		return cmSet;
	}
	public void setCmSet(Set<ContactMember> cmSet) {
		this.cmSet = cmSet;
	}
	
	
	//user与PrivateMessage之间的多对多关系
	@ManyToMany(fetch=FetchType.EAGER)
    @JoinTable(name="userpm", 
        joinColumns=@JoinColumn(name="mail"),
        inverseJoinColumns=@JoinColumn(name="pmid"))
	public Set<PrivateMessage> getPmSet() {
		return pmSet;
	}
	public void setPmSet(Set<PrivateMessage> pmSet) {
		this.pmSet = pmSet;
	}
	//user与article之间的一对多关系
	@OneToMany(mappedBy="user", targetEntity=Article.class, cascade=CascadeType.ALL, fetch=FetchType.EAGER)
	public Set<Article> getArticleSet() {
		return articleSet;
	}
	public void setArticleSet(Set<Article> articleSet) {
		this.articleSet = articleSet;
	}
	@OneToMany(mappedBy="user", targetEntity=ArticleComment.class, cascade=CascadeType.ALL, fetch=FetchType.EAGER)
	public Set<ArticleComment> getAcset() {
		return acset;
	}
	public void setAcset(Set<ArticleComment> acset) {
		this.acset = acset;
	}
	
	
}
