package com.aesopsns.manage.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aesopsns.entity.common.Res;
import com.aesopsns.manage.service.ManageServiceImpl;

@Controller
@RequestMapping("/weibo")
public class WeiboManageController {
	@Resource
	private ManageServiceImpl manageServiceImpl;
	
	//微博管理主页
	@RequestMapping("/index")
	public String toWeiboIndex(Model model) {
		this.manageServiceImpl.getWeibos(model);
		return "manage/weibo/index";
	}
	
	//删除微博
	@RequestMapping("/delete/{id}")
	public @ResponseBody Res deleteGroup(@PathVariable int id) {
		return this.manageServiceImpl.deleteWeibo(id);
	}
}
