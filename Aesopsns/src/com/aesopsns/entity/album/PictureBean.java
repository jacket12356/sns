package com.aesopsns.entity.album;

public class PictureBean {
	private int pictureId;
	private int isFavor;		//0表示点了
	private int favorCount;
	private String path;
	private String createdTime;
	private String username;
	public int getPictureId() {
		return pictureId;
	}
	public void setPictureId(int pictureId) {
		this.pictureId = pictureId;
	}
	public int getIsFavor() {
		return isFavor;
	}
	public void setIsFavor(int isFavor) {
		this.isFavor = isFavor;
	}
	public int getFavorCount() {
		return favorCount;
	}
	public void setFavorCount(int favorCount) {
		this.favorCount = favorCount;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getCreatedTime() {
		return createdTime;
	}
	public void setCreatedTime(String createdTime) {
		this.createdTime = createdTime;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
}
