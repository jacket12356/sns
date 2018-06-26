package com.aesopsns.manage.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aesopsns.manage.service.ManageServiceImpl;

@Controller
@RequestMapping("/system")
public class SystemController {
	@Resource
	private ManageServiceImpl manageServiceImpl;
	
	//进入后台管理系统的系统设置页面
	@RequestMapping("/config/edit")
	public String toSystemConfig() {
		return "manage/system/config";
	}
	
	//积分规则
	@RequestMapping("/scoreRule/list")
	public String scoreRuleList() {
		return "manage/system/scorelist";
	}
}
