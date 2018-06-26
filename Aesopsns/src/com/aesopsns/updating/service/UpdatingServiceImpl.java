package com.aesopsns.updating.service;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.aesopsns.entity.common.Page;
import com.aesopsns.entity.common.Updating;
import com.aesopsns.entity.user.User;
import com.aesopsns.updating.dao.UpdatingDaoImpl;

@Service
public class UpdatingServiceImpl {
	@Resource
	private UpdatingDaoImpl updatingDaoImpl;
	
	//按页列出动态信息
	public void listWeiboByPage(int pageNo, Model model) {
		List<Updating> currentPageList = null;
		Page updatingPage = new Page(2, this.updatingDaoImpl.findCount());
		updatingPage.setCurrentPage(pageNo);
		try {
			//为了能看出分页效果，先弄每页两个吧
			currentPageList = this.updatingDaoImpl.find4Page(updatingPage.getCurrentPage(), updatingPage.getPageSize());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("updatingpage", updatingPage);
		model.addAttribute("currentpagelist", currentPageList);
	}
	
	//个人动态
	public String personalUpdating(String name, HttpSession session, Model model) {
		if(name == null) {
			User u = (User) session.getAttribute("currentuser");
			model.addAttribute("updatings", this.updatingDaoImpl.getUpdatingsByUpdater(u.getName()));
			return "front/updating/personal";
		}else {
			model.addAttribute("updatings", this.updatingDaoImpl.getUpdatingsByUpdater(name));
			return "front/updating/others";
		}
	}
}
