package com.aesopsns.group.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aesopsns.entity.common.CommentData;
import com.aesopsns.entity.common.Res;
import com.aesopsns.entity.weibo.ResponseModel;
import com.aesopsns.group.service.GroupServiceImpl;

@Controller
@RequestMapping("/group")
public class GroupController {
	@Resource
	private GroupServiceImpl groupServiceImpl;
	//群组最一开始的界面
	@RequestMapping("/list")
	public String group(Model model) {
		this.groupServiceImpl.listGroup(model);
		
		return "front/group/group";
	}
	
	//转到申请群组页面
	@RequestMapping("/toaddgroup")
	public String toAddGroup() {
		return "front/group/addgroup";
	}
	
	//表单提交新添群组
	@RequestMapping("/addgroup")
	public @ResponseBody Res addGroup(@RequestParam String name, @RequestParam String face, 
			@RequestParam String intro, @RequestParam String tags, HttpSession session) {
		return this.groupServiceImpl.addGroup(name, face, intro, tags, session);
	}
	
	//上传图片
	@RequestMapping("/uploadimage")
	public @ResponseBody ResponseModel uploadImage(@RequestParam MultipartFile file, HttpServletRequest request) {
		return this.groupServiceImpl.uploadImage(file, request);
	}
	
	//群组详情
	@RequestMapping("/detail/{id}")
	public String groupDetail(@PathVariable int id, Model model, HttpSession session, 
								@RequestParam(value="pageNo", required=false) String pageNo) {
		this.groupServiceImpl.setGroupDetail(id, model, session, pageNo);
		
		return "front/group/detail";
	}
	
	//群组关注
	@RequestMapping("/follow/{id}")
	public @ResponseBody Res groupFollow(@PathVariable int id, HttpSession session){
		return this.groupServiceImpl.groupFollow(id, session);
	}
	
	//转到群组发帖
	@RequestMapping("/topost/{id}")
	public @ResponseBody Res toPost(@PathVariable int id, Model model, HttpSession session) {
		return this.groupServiceImpl.toPost(id, session, model);
	}
	
	//发帖页面
	@RequestMapping("/post/{id}")
	public String post(@PathVariable int id, Model model) {
		model.addAttribute("groupid", id);
		return "front/group/post";
	}
	
	//发帖表单提交
	@RequestMapping("/posting")
	public @ResponseBody Res posting(@RequestParam int groupid, @RequestParam String title, 
			@RequestParam String thumbnail, @RequestParam String description,
			@RequestParam String content, HttpSession session, HttpServletRequest request) {
		return this.groupServiceImpl.posting(groupid, title, thumbnail, description, content, session, request);
	}
	
	//帖子详情页面
	@RequestMapping("/postdetail/{id}")
	public String postDetail(@PathVariable int id, Model model, HttpServletRequest request, HttpSession session) {
		return this.groupServiceImpl.postDetail(id, model, request, session);
	}
	
	//微博追加评论功能
	@RequestMapping("/comment/{id}")
	public String postComment(@PathVariable int id, @RequestParam String content, HttpSession session,
			@RequestParam(value="postCommentId", required=false) String postCommentId) {
		try {
			//解析的时候咋就换编码了呢
			content = new String(content.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return this.groupServiceImpl.postComment(id, content, session, postCommentId);
	}
	//将某条微博的评论列出来
	@RequestMapping("/commentList/{weiboid}")
	public @ResponseBody List<CommentData> commentList(@PathVariable int weiboid) {
		return this.groupServiceImpl.commentData(weiboid);
	}
	
	//测试
	@RequestMapping("/deleteall")
	public String deleteAll() {
		return this.groupServiceImpl.deleteAll();
	}
}
