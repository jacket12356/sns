package com.aesopsns.manage.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aesopsns.entity.common.Res;
import com.aesopsns.manage.service.ManageServiceImpl;

@Controller
@RequestMapping("/manage")
public class ManageController {
	@Resource
	private ManageServiceImpl manageServiceImpl;
	
	//后台管理系统登录
	@RequestMapping("/login")
	public String toLogin() {
		return "manage/login";
	}
	
	//表单提交执行登录
	@RequestMapping("/dologin")
	public @ResponseBody Res doLogin(@RequestParam String username, @RequestParam String password, 
			HttpSession session) {
		return this.manageServiceImpl.doLogin(username, password, session);
	}
	
	//后台管理主页
	@RequestMapping("/index")
	public String toIndex(Model model, HttpServletRequest request, HttpSession session) {
		return this.manageServiceImpl.toIndex(model, request, session);
	}
}
