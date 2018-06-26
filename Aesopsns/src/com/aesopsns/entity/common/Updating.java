package com.aesopsns.entity.common;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="updatings")
public class Updating {
	private int id;
	private String updater;			//发布者的名字
	private String updatetime;		//发布时间
	private String icon;			//发布者的头像
	private int type;				//动态类型：1表示文章     2表示帖子     3表示微博
	private String weibocontent;	//如果是微博的话，要显示内容（插图就算了）
	private int detailid;			//详情id
	private String title;
	@Id
	@GeneratedValue(generator = "my_gen")
	@GenericGenerator(name = "my_gen", strategy = "increment")    	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUpdater() {
		return updater;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
	public String getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getWeibocontent() {
		return weibocontent;
	}
	public void setWeibocontent(String weibocontent) {
		this.weibocontent = weibocontent;
	}
	public int getDetailid() {
		return detailid;
	}
	public void setDetailid(int detailid) {
		this.detailid = detailid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
}
