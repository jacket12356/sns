package com.aesopsns.manage.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aesopsns.entity.common.Res;
import com.aesopsns.manage.service.ManageServiceImpl;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Resource
	private ManageServiceImpl manageServiceImpl;
	
	//会员管理主页
	@RequestMapping("/index")
	public String toMemberIndex(Model model) {
		this.manageServiceImpl.getUserList(model);
		return "manage/member/index";
	}
	
	//修改密码页面
	@RequestMapping("/changepwd/{name}")
	public String toChangePwd(Model model, @PathVariable String name) {
		model.addAttribute("name", name);
		return "manage/member/changepwd";
	}
	
	//修改密码
	@RequestMapping("/dochangepwd")
	public @ResponseBody Res changePwd(@RequestParam String name, @RequestParam String password){
		return this.manageServiceImpl.changePwd(name, password);
	}
	
	//删除用户
	@RequestMapping("/delete/{name}")
	public @ResponseBody Res deleteUser(@PathVariable String name) {
		return this.manageServiceImpl.deleteUser(name);
	}
}
