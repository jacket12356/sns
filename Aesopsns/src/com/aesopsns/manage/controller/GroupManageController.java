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
@RequestMapping("/group")
public class GroupManageController {
	@Resource
	private ManageServiceImpl manageServiceImpl;
	
	//群组管理主页
	@RequestMapping("/index")
	public String toGroupIndex(Model model) {
		this.manageServiceImpl.getGroups(model);
		return "manage/group/index";
	}
	
	//删除群组
	@RequestMapping("/delete/{id}")
	public @ResponseBody Res deleteGroup(@PathVariable int id) {
		return this.manageServiceImpl.deleteGroup(id);
	}
}
