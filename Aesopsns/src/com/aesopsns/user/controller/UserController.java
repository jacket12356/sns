package com.aesopsns.user.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aesopsns.entity.common.Res;
import com.aesopsns.entity.user.ContactMemberBean;
import com.aesopsns.entity.user.PrivateMessageBean;
import com.aesopsns.user.service.UserServiceImpl;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	private UserServiceImpl userServiceImpl;
	
	@RequestMapping("/regist")
	public String toRegist() {
		return "front/user/regist";
	}
	
	@RequestMapping("/login")
	public String toLogin() {
		return "front/user/login";
	}
	
	@RequestMapping("/forgotpassword")
	public String toForgotPassword() {
		return "front/user/forgotpassword";
	}
	
	@RequestMapping("/personal")
	public String toPersonal(@RequestParam(value="type", required=false) String type, HttpSession session, Model model) {
		this.userServiceImpl.personalUpdating(type, null, session, model);
		return "front/user/personal";
	}
	
	@RequestMapping("/editinfo")
	public String toEditInfo() {
		return "front/user/editinfo";
	}
	
	//上传头像
	@RequestMapping("/uploadicon")
	public String toUploadIcon() {
		return "front/user/uploadicon";
	}
	//查看获得积分明细
	@RequestMapping("/creditdetail")
	public String toCreditDetail() {
		return "front/user/creditdetail";
	}
	
	//修改密码
	@RequestMapping("/password")
	public String toPassword() {
		return "front/user/password";
	}
	
	//私信
	@RequestMapping("/privatemessage")
	public String toMessage() {
		return "front/user/privatemessage";
	}
	
	//系统信息
	@RequestMapping("/systemmessage")
	public String toSystemMessage() {
		return "front/user/systemmessage";
	}
	
	//表单提交，只涉及将用户信息存到数据库中
	@PostMapping("/doregist")
	public String regist(@RequestParam String name, @RequestParam String password, 
			@RequestParam String mail, HttpServletResponse response) {		//没做邮箱验证吗？倒是方便！可是后面的找回密码怎么办？
		this.userServiceImpl.doRegist(name, password, mail);
		
		//注册成功，跳转到登录页（这个跳转被js拦截了）
		return "front/user/login";    
	}
	
	//注册时涉及到的mail和name的查重
	@PostMapping("/infovalidate")
	public @ResponseBody String infoValidate(@RequestParam String mail, @RequestParam String name) {
		String error = this.userServiceImpl.isMailOrNameExist(mail, name);
		return error;
	}
	
	//这个就是dologin
	//登录时涉及到的登录信息检查(注意account时mail或name)
	@PostMapping("/logininfovalidate")
	public @ResponseBody String loginInfoValidate(@RequestParam String account, 
			@RequestParam String password, HttpSession session) {
		String error = this.userServiceImpl.loginInfoCheck(account, password, session);
		
		return error;
	}
	
	//找回密码，跟前两个还是差不多的套路
	@PostMapping("/passwordgetback")
	public @ResponseBody String passwordGetBack(@RequestParam String name, 
			@RequestParam String mail) {
		String error = this.userServiceImpl.getBackPassword(name, mail);
		
		return error;
	}
	
	//用户注销
	@RequestMapping("/logout")
	public String logOut(HttpSession session) {
		session.removeAttribute("currentuser");
		session.removeAttribute("userdetail");
		
		return "redirect:/index";
	}
	
	//用户基本信息修改
	@PostMapping("/editbaseinfo")
	public @ResponseBody String editBaseInfo(@RequestParam String sex, @RequestParam String intro,
			HttpSession session) {
		this.userServiceImpl.updateBaseInfo(sex, intro, session);
		String info = "<div class=\"layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layer-anim\" id=\"layui-layer6\" type=\"dialog\" times=\"6\" showtime=\"3000\" contype=\"string\" style=\"z-index: 19891020; top: 355px; left: 666px;\">\r\n" + 
				"    			<div id=\"\" class=\"layui-layer-content layui-layer-padding\">\r\n" + 
				"    			<i class=\"layui-layer-ico layui-layer-ico6\"></i>" + "Update succeed! \r\n" + 
				"    			</div>\r\n" + 
				"    			<span class=\"layui-layer-setwin\"></span>\r\n" + 
				"    			</div>";
		return info;
	}
	
	//用户其它信息修改
	@PostMapping("/editotherinfo")
	public @ResponseBody String editOtherInfo(@RequestParam String birthday, @RequestParam String qq, 
			@RequestParam String wechat, @RequestParam String cellphone, @RequestParam String personal_web, HttpSession session) {
		this.userServiceImpl.updateOtherInfo(birthday, qq, wechat, cellphone, personal_web, session);
		String info = "<div class=\"layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layer-anim\" id=\"layui-layer6\" type=\"dialog\" times=\"6\" showtime=\"3000\" contype=\"string\" style=\"z-index: 19891020; top: 355px; left: 666px;\">\r\n" + 
				"    			<div id=\"\" class=\"layui-layer-content layui-layer-padding\">\r\n" + 
				"    			<i class=\"layui-layer-ico layui-layer-ico6\"></i>" + "Update succeed! \r\n" + 
				"    			</div>\r\n" + 
				"    			<span class=\"layui-layer-setwin\"></span>\r\n" + 
				"    			</div>";
		return info;
	}
	
	//上传头像
	@PostMapping("/iconupload")
	public @ResponseBody Object iconUpload(@RequestParam("__avatar1") MultipartFile file, HttpSession session, HttpServletRequest request) {
		this.userServiceImpl.uploadIcon(file, session, request);	
		
		HashMap<String, Object> result = new HashMap<>();
		result.put("success", true);
        result.put("msg", "Upload succeed!");
		
		return result;
	}
	
	//修改密码
	@RequestMapping("/editpassword")
	public @ResponseBody String editPassword(@RequestParam String repassword, @RequestParam String oldpassword, HttpSession session) {
		return this.userServiceImpl.rePassword(repassword, oldpassword, session);
	}
	
	@RequestMapping("/deleteall")
	public void deleteAll() {
//		this.userServiceImpl.deleteAll();
		this.userServiceImpl.deleteAll();
	}
	
	//转到其他用户主页
	@RequestMapping("/others/{name}")
	public String toOthers(@RequestParam(value="type", required=false) String type, @PathVariable String name, HttpSession session, Model model) {
		this.userServiceImpl.setOthers(name, session);
		this.userServiceImpl.personalUpdating(type, name, session, model);
		return "front/user/others";
	}
	
	//查询私信中用户的聊天对象
//	@RequestMapping("/listcontactmember")
//	public @ResponseBody String listContactMember(@RequestParam String mail) {
//		
//	}
	
	//新建当前用户的私信对象并向前台返回弹出层代码
	@RequestMapping("/sendmessagebox")
	public String sendMessageBox(@RequestParam String mail, HttpSession session) {
		this.userServiceImpl.sendMessageBox(mail, session);
		
		return "front/jspf/messagebox";
	}
	//私信模块中的处理消息功能，这个是处理点他人页面中的“私信”时发送的私信时和在私信界面中点发送消息时
	@RequestMapping("/sendmessage")        
	public @ResponseBody PrivateMessageBean sendMessage(@RequestParam String messagetarget, @RequestParam String content, HttpSession session) {
		return this.userServiceImpl.sendMessage(messagetarget, content, session);  //我去，这私信模块做的，就算我不想弄懂ajax也非得给我整明白了
	}
	//私信模块中的列出联系人功能，下面注入的mail并没什么卵用，好吧，我懒得改了（配了多对多感觉好些多了）
	@RequestMapping("/listcontactmember")
	public @ResponseBody List<ContactMemberBean> listContactMember(@RequestParam String mail, HttpSession session) {
		return this.userServiceImpl.listContactMember(mail, session);
	}
	//私信模块中获取聊天记录的功能点
	@RequestMapping("/getmessagerecords")
	public @ResponseBody List<PrivateMessageBean> getMessageRecords(@RequestParam String usermail,
			@RequestParam String membername, HttpSession session) {
		return this.userServiceImpl.getMessageRecords(usermail, membername);
	}
	//关注功能
	@RequestMapping("/follow")
	public @ResponseBody Res follow(HttpSession session) {
		return this.userServiceImpl.follow(session);
	}
	//关注人列表
	@RequestMapping("/others/{username}/follows")
	public String follows(HttpSession session, @PathVariable String username, Model model) {
		//得先转到other呢(如果是查看本人的关注情况的话)
		this.userServiceImpl.setOthers(username, session);
		this.userServiceImpl.listFollows(username, model);
		return "front/user/follows";
	}
	//粉丝列表
	@RequestMapping("/others/{username}/fans")
	public String fans(HttpSession session, @PathVariable String username, Model model) {
		//得先转到other呢(如果是查看本人的关注情况的话)
		this.userServiceImpl.setOthers(username, session);
		this.userServiceImpl.listFans(username, model);
		return "front/user/fans";
	}
}
