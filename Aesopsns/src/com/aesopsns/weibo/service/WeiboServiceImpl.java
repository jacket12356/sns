package com.aesopsns.weibo.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.aesopsns.album.dao.AlbumDaoImpl;
import com.aesopsns.entity.album.Album;
import com.aesopsns.entity.album.AlbumPicture;
import com.aesopsns.entity.common.CommentData;
import com.aesopsns.entity.common.Page;
import com.aesopsns.entity.common.Res;
import com.aesopsns.entity.common.Updating;
import com.aesopsns.entity.user.User;
import com.aesopsns.entity.weibo.ResponseModel;
import com.aesopsns.entity.weibo.Weibo;
import com.aesopsns.entity.weibo.WeiboBean;
import com.aesopsns.entity.weibo.WeiboComment;
import com.aesopsns.entity.weibo.WeiboUpvote;
import com.aesopsns.user.dao.UserDaoImpl;
import com.aesopsns.weibo.dao.WeiboDaoImpl;

@Service
public class WeiboServiceImpl {
	@Resource
	private UserDaoImpl userDaoImpl;
	@Resource
	private WeiboDaoImpl weiboDaoImpl;
	@Resource
	private AlbumDaoImpl albumDaoImpl;
	
	//微博——上传图片功能
	public Object uploadImage(MultipartFile file, HttpServletRequest request) {
		byte[] image;
		StringBuilder name = new StringBuilder();
    	if(!file.isEmpty()) {
    		try {
    			image = file.getBytes();
    			//利用时刻创造一个唯一的文件名
    			LocalTime t = LocalTime.now();
    			name.append(t.getHour()); name.append(t.getMinute()); name.append(t.getSecond()); name.append(t.getNano());
    			String realFile = request.getServletContext().getRealPath("/") + "res/common/uploads/weiboimage/" + name.toString() + ".jpg";
    			@SuppressWarnings("resource")
				OutputStream output = new FileOutputStream(new File(realFile));
    			output.write(image); 
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	return new ResponseModel(0,"上传成功",name.toString() + ".jpg");
	}
	//发布微博
	public String publishWeibo(String content, String pictures, HttpSession session, HttpServletRequest request) {
		User u = (User) session.getAttribute("currentuser");
		//没登录就转到登录页面
		if(u == null) {
			//删掉已经上传的图片
			if(pictures != null && !"".equals(pictures)) {
				this.deleteUploadedImages(pictures, request);
			}
			return "front/user/login";
		}
		//新建一个weibo对象
		Weibo w = new Weibo();
		w.setContent(content);
		w.setPictures(pictures);
		w.setPublisher(u.getName());
		w.setPublishtime(this.getCurrentTime());
		//持久化
		this.weiboDaoImpl.saveWeibo(w);
		
		//在发布微博的同时，将微博中的配图添加到“微博配图”相册中
		String[] images = pictures.split(",");
		if(this.albumDaoImpl.isWeiboAlbumExists(w.getPublisher())) {
			Album a = this.albumDaoImpl.getWeiboAlbumByName(w.getPublisher());
			for(String image : images) {
				AlbumPicture ap = new AlbumPicture();
				ap.setAlbumid(a.getId());
				ap.setCreatedtime(this.getCurrentTime());
				ap.setImage(image);
				ap.setUsername(w.getPublisher());
				this.albumDaoImpl.saveAlbumPicture(ap);
				
				try {
					this.copyFile(request, image);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}else {
			Album a = new Album();
			a.setFaces(images[0]);
			a.setIntro("weibo");
			a.setNamess("微博配图");
			a.setRights(0);
			a.setUsername(w.getPublisher());
			this.albumDaoImpl.saveAlbum(a);
			a = this.albumDaoImpl.getWeiboAlbumByName(w.getPublisher());
			for(String image : images) {
				AlbumPicture ap = new AlbumPicture();
				ap.setAlbumid(a.getId());
				ap.setCreatedtime(this.getCurrentTime());
				ap.setImage(image);
				ap.setUsername(w.getPublisher());
				this.albumDaoImpl.saveAlbumPicture(ap);
			}
		}
		
		//更新动态
		Updating updating = new Updating();
		updating.setDetailid(this.weiboDaoImpl.getWeiboByTime(w.getPublishtime()).getId());
		updating.setIcon(u.getIcon());
		updating.setType(3);
		updating.setUpdater(u.getName());
		updating.setWeibocontent(w.getContent());
		updating.setUpdatetime(this.getCurrentTime());
		this.weiboDaoImpl.saveUpdating(updating);
		
		return "redirect:/weibo/list";
	}
	//用户上传好图片后却没登录
	private void deleteUploadedImages(String pictures, HttpServletRequest request) {
		String[] images = pictures.split(",");
		String pathPrefix = request.getServletContext().getRealPath("/") + "res/common/uploads/weiboimage/";
		for(String image : images)	 new File(pathPrefix + image).delete();
	}
	private String getCurrentTime() {
		StringBuilder time = new StringBuilder();
		time.append(LocalDate.now().toString() + " ");
		LocalTime t = LocalTime.now();
		String[] tim = t.toString().split("\\.");
		time.append(tim[0]);
		return time.toString();
	}
	private void copyFile(HttpServletRequest request, String image) throws IOException {
		String srcPath = request.getServletContext().getRealPath("/") +
				"res/common/uploads/weiboimage/" + image;
		String destPath = request.getServletContext().getRealPath("/") +
				"res/common/uploads/albumimage/" + image;
        FileInputStream fis = new FileInputStream(srcPath);
        FileOutputStream fos = new FileOutputStream(destPath);
        
        int len = 0;
        while ((len = fis.read()) != -1) {
            fos.write(len);
        }
        
        fos.close(); 
        fis.close(); 
	}
	
	//按页列出微博信息
	public void listWeiboByPage(int pageNo, Model model) {
		List<WeiboBean> currentPageList = null;
		Page weiboPage = new Page(2, this.weiboDaoImpl.findCount());
		weiboPage.setCurrentPage(pageNo);
		try {
			//为了能看出分页效果，先弄每页两个吧
			currentPageList = this.weiboDaoImpl.find4Page(weiboPage.getCurrentPage(), weiboPage.getPageSize());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("weibopage", weiboPage);
		model.addAttribute("currentpagelist", currentPageList);
	}
	//获取微博信息
	public void getWeiboDetail(int id, Model model) {
		model.addAttribute("weibodetail", this.weiboDaoImpl.getWeiboBean(id));
	}
	//微博点赞功能
	public Res weiboFavor(int id, HttpSession session) {
		Res res = new Res();
		User u = (User) session.getAttribute("currentuser");
		if(u == null) {
			res.setCode(-1);
			res.setMsg("请先登录");
			return res;
		}
		Weibo w = this.weiboDaoImpl.getWeibo(id);
		if(this.weiboDaoImpl.isWeiboUpvoted(u.getMail(), id)) {//表示投过了
			w.setUpvotes(w.getUpvotes() - 1);
			this.weiboDaoImpl.updateWeibo(w);
			res.setCode(1);
			res.setData(w.getUpvotes() + "");
			//删掉点赞记录
			this.weiboDaoImpl.deleteWeiboUpvote(u.getMail(), id);
		}else {//表示没投过
			w.setUpvotes(w.getUpvotes() + 1);
			this.weiboDaoImpl.updateWeibo(w);
			res.setCode(0);
			res.setData(w.getUpvotes() + "");
			//持久化upvote
			WeiboUpvote wu = new WeiboUpvote();
			wu.setMail(u.getMail());
			wu.setWeiboid(id);
			this.weiboDaoImpl.saveWeiboUpvote(wu);
		}
		return res;
	}
	//微博追加评论
	public String weiboComment(int id, String content, HttpSession session, String weiboCommentId) {
		User u = (User) session.getAttribute("currentuser");
		if(u == null)	return "front/user/login";
		//数据过来先持久化
		WeiboComment weiboComment = new WeiboComment();
		weiboComment.setWeiboid(id);
		weiboComment.setContent(content);
		weiboComment.setCreatedtime(getCurrentTime());
		weiboComment.setUsername(u.getName());
		//如果该评论是引用某一个评论的话
		if(weiboCommentId != null) {
			weiboComment.setCited(1);
			weiboComment.setCitedcommemtid(Integer.parseInt(weiboCommentId));
		}else {
			weiboComment.setCited(0);
		}
		this.weiboDaoImpl.saveWeiboComment(weiboComment);
		//更新下微博的评论数
		Weibo w = this.weiboDaoImpl.getWeibo(id);
		w.setComments(w.getComments() + 1);
		this.weiboDaoImpl.updateWeibo(w);
		//应该就这些吧
		return "redirect:/weibo/detail/" + id;
	}
	//列出某一条微博的所有评论
	public List<CommentData> commentData(int weiboid){
		return this.weiboDaoImpl.getWeiboComments(weiboid);
	}
	//测试
	public void deleteall() {
		this.weiboDaoImpl.delete();
	}
}
