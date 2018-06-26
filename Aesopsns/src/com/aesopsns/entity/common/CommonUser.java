package com.aesopsns.entity.common;

public class CommonUser {
	private String name;
	private String email;
	private String password;
	private String jointime;
	private String recentlogin;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getJointime() {
		return jointime;
	}
	public void setJointime(String jointime) {
		this.jointime = jointime;
	}
	public String getRecentlogin() {
		return recentlogin;
	}
	public void setRecentlogin(String recentlogin) {
		this.recentlogin = recentlogin;
	}
}
