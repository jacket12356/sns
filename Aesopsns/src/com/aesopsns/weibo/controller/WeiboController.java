package com.aesopsns.weibo.controller;

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
import com.aesopsns.weibo.service.WeiboServiceImpl;
import com.aesopsns.weibo.util.EmojiUtil;

@Controller
@RequestMapping("/weibo")
public class WeiboController {
	@Resource
	private WeiboServiceImpl weiboServiceImpl;
	
	@RequestMapping("/delete")
	public String deleteAll() {
		this.weiboServiceImpl.deleteall();
		return "";
	}
	
	@RequestMapping("/list")
	public String list(@RequestParam(value="pageNo", required=false) String pageNo, Model model) {
		if(pageNo == null)	this.weiboServiceImpl.listWeiboByPage(1, model);
		else	this.weiboServiceImpl.listWeiboByPage(Integer.parseInt(pageNo), model);
		
		return "front/weibo/weibolist";
	}
	
	//微博列表页中的emoji
	@RequestMapping("/emoji/emojiJsonData.json")
	public @ResponseBody Object emojiJson(){
		return EmojiUtil.emojiJson();
	}
	//emoji旁边的上传图片
	@RequestMapping("/uploadimage")
	public @ResponseBody Object uploadImage(@RequestParam MultipartFile file, HttpServletRequest request) {
		return this.weiboServiceImpl.uploadImage(file, request);
	}
	//发布微博
	@RequestMapping("/publish")
	public String publishWeibo(@RequestParam String content, @RequestParam String pictures,
			HttpSession session, HttpServletRequest request) {
		try {
			//解析的时候咋就换编码了呢
			content = new String(content.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return this.weiboServiceImpl.publishWeibo(content, pictures, session, request);
	}
	//微博详情页面
	@RequestMapping("/detail/{id}")
	public String weiboDetail(@PathVariable int id, Model model) {
		this.weiboServiceImpl.getWeiboDetail(id, model);
		return "front/weibo/detail";
	}
	//微博点赞功能
	@RequestMapping("/favor/{id}")
	public @ResponseBody Res weiboFavor(@PathVariable int id, HttpSession session) {
		return this.weiboServiceImpl.weiboFavor(id, session);
	}
	//微博追加评论功能
	@RequestMapping("/comment/{id}")
	public String weiboComment(@PathVariable int id, @RequestParam String content, HttpSession session,
			@RequestParam(value="weiboCommentId", required=false) String weiboCommentId) {
		try {
			//解析的时候咋就换编码了呢
			content = new String(content.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return this.weiboServiceImpl.weiboComment(id, content, session, weiboCommentId);
	}
	//将某条微博的评论列出来
	@RequestMapping("/commentList/{weiboid}")
	public @ResponseBody List<CommentData> commentList(@PathVariable int weiboid) {
		return this.weiboServiceImpl.commentData(weiboid);
	}
}
