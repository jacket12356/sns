package com.aesopsns.album.controller;

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

import com.aesopsns.album.service.AlbumServiceImpl;
import com.aesopsns.entity.common.Res;
import com.aesopsns.entity.common.CommentBean;

@Controller
@RequestMapping("/album")
public class AlbumController {
	@Resource
	private AlbumServiceImpl albumServiceImpl;
	
	//相册模块主页，即相册列表
	@RequestMapping("/list/{username}")
	public String listAlbum(@PathVariable(value="username", required=false) String username, HttpSession session) {
		//如果username是空的，说明这个是个人管理
		if(username.equals("username")) {
			this.albumServiceImpl.currentUsersAlbum(session);
		}else {
			this.albumServiceImpl.otherUsersAlbum(session, username);
		}
		
		return "front/album/albumlist";
	}
	
	//又是一个弹出框加载iframe，加载新建相册页面
	@RequestMapping("/add")
	public String toAddAlbum() {
		return "front/jspf/albumaddbox";
	}
	
	//存相册
	@RequestMapping("/save")
	public @ResponseBody Res saveAlbum(@RequestParam String name, @RequestParam String intro,
			@RequestParam int right, HttpSession session) {
		return this.albumServiceImpl.saveAlbum(name, intro, right, session);
	}
	
	//删相册
	@RequestMapping("/delete")
	public @ResponseBody int deleteAlbum(@RequestParam int albumid, HttpSession session) {
		this.albumServiceImpl.deleteAlbum(albumid, session);
		return albumid;
	}
	
	//相册详情，需要的对象有：album albumpicture userdetail
	@RequestMapping("/detail/{id}")
	public String albumDetail(@PathVariable int id, Model model) {
		this.albumServiceImpl.setAlbumDetail(id, model);
		
		return "front/album/albumdetail";
	}
	
	//转到图片上传框
	@RequestMapping("/touploadpic")
	public String toUploadPic(Model model, @RequestParam int albumid) {
		this.albumServiceImpl.toUploadPic(model, albumid);
		
		return "front/jspf/uploadpicbox";
	}
	
	//用户点击“上传图片”
	@RequestMapping("/uploadpic/{id}")
	public @ResponseBody Object uploadAlbumPicture(@PathVariable int id, @RequestParam MultipartFile file,
			HttpServletRequest request) {
		return this.albumServiceImpl.uploadImage(id, file, request);
	}
	
	//测试用
	@RequestMapping("/deleteall")
	public String deleteAllAlbum() {
		this.albumServiceImpl.deleteAllAlbum();
		return "";
	}
	
	//相册中的图片详情，_jeesnsOpen
	@RequestMapping("/picturedetail/{id}")
	public String toPictureDetail(@PathVariable int id, Model model) {
		this.albumServiceImpl.pictureDetail(id, model);
		
		return "front/jspf/picturedetailbox";
	}
	//相册图片详情中的点赞
	@RequestMapping("/picturefavor/{id}")
	public @ResponseBody Res pictureFavor(@PathVariable int id, HttpSession session) {
		return this.albumServiceImpl.pictureFavor(id, session);
	}
	//相册图片中的发评论
	@RequestMapping("/picturecomment/{id}")
	public @ResponseBody Res pictureComment(@PathVariable int id, String content, HttpSession session) {
		return this.albumServiceImpl.pictureComment(id, session, content);
	}
	//列出该相册图片详情页面中的评论
	@RequestMapping("/picturecommentlist/{id}")
	public @ResponseBody List<CommentBean> pictureCommentList(@PathVariable int id){
		return this.albumServiceImpl.listPictureComment(id);
	}
}
