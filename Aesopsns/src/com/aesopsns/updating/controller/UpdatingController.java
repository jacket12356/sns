package com.aesopsns.updating.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aesopsns.updating.service.UpdatingServiceImpl;

@Controller
@RequestMapping("/updating")
public class UpdatingController {
	@Resource
	private UpdatingServiceImpl updatingServiceImpl;
	
	//动态主页面
	@RequestMapping("/list")
	public String list(@RequestParam(value="pageNo", required=false) String pageNo, Model model) {
		if(pageNo == null)	this.updatingServiceImpl.listWeiboByPage(1, model);
		else	this.updatingServiceImpl.listWeiboByPage(Integer.parseInt(pageNo), model);
		
		return "front/updating/list";
	}
	//动态个人页面
	@RequestMapping("/personal")
	public String listPersonal(@RequestParam(value="name", required=false) String name,
			HttpSession session, Model model) {
		return this.updatingServiceImpl.personalUpdating(name, session, model);
	}
}
