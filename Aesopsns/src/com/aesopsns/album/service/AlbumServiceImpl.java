package com.aesopsns.album.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
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
import com.aesopsns.entity.album.PictureBean;
import com.aesopsns.entity.album.PictureComment;
import com.aesopsns.entity.album.PictureUpvote;
import com.aesopsns.entity.common.CommentBean;
import com.aesopsns.entity.common.Res;
import com.aesopsns.entity.user.User;
import com.aesopsns.entity.user.User_detail;
import com.aesopsns.entity.weibo.ResponseModel;
import com.aesopsns.user.dao.UserDaoImpl;

@Service
public class AlbumServiceImpl {
	@Resource
	private AlbumDaoImpl albumDaoImpl;
	@Resource
	private UserDaoImpl userDaoImpl;
	
	//相册个人管理模式
	public void currentUsersAlbum(HttpSession session) {
		User u = (User) session.getAttribute("currentuser");
		List<Album> albumlist = this.albumDaoImpl.listAlbum(u.getName());
		session.setAttribute("albumlist", albumlist);
		//对了，还有一个user要加到session里，相册个人管理模式下currentuser  1，相册外部查看模式下是anotheruser  2
		session.setAttribute("user", session.getAttribute("currentuser"));
		session.setAttribute("usersdetail", session.getAttribute("userdetail"));
		session.setAttribute("mode", 1);    
	}
	
	//相册外部查看模式
	public void otherUsersAlbum(HttpSession session, String username) {
		User u = (User) session.getAttribute("anotheruser");
		List<Album> albumlist = this.albumDaoImpl.listAlbum(u.getName());
		session.setAttribute("albumlist", albumlist);
		//对了，还有一个user要加到session里，相册个人管理模式下currentuser  1，相册外部查看模式下是anotheruser  2
		session.setAttribute("user", session.getAttribute("anotheruser"));
		session.setAttribute("usersdetail", session.getAttribute("anotheruserdetail"));
		session.setAttribute("mode", 2);    
	}
	
	//存相册
	public Res saveAlbum(String name, String intro, int right, HttpSession session) {
		//先进行表单检查，这个竟然要后台来
		Res res = new Res();
		if(name == null) {
			res.setCode(-1);
			res.setMsg("相册名不能为空");
		}
		if(intro == null) {
			res.setCode(-1);
			res.setMsg("相册描述不能为空");
		}
		
		Album album = new Album();
		album.setIntro(intro);
		album.setNamess(name);
		album.setRights(right);
		album.setUsername(((User) session.getAttribute("currentuser")).getName());
		this.albumDaoImpl.saveAlbum(album);
		res.setCode(0);
		res.setMsg("相册创建成功");
		res.setUrl("/Aesopsns/album/list");
		
		return res;
	}
	
	//删相册
	public void deleteAlbum(int albumid, HttpSession session) {
		this.albumDaoImpl.deleteAlbum(albumid);
		
		User u = (User) session.getAttribute("currentuser");
		List<Album> albumlist = this.albumDaoImpl.listAlbum(u.getName());
		session.setAttribute("albumlist", albumlist);
		//删相册时还要一并将它的照片删掉
		this.albumDaoImpl.deleteAlbumsPicture(albumid);
	}
	
	//相册详情
	public void setAlbumDetail(int id, Model model) {
		Album album = this.albumDaoImpl.getAlbum(id);
		List<AlbumPicture> aplist = this.albumDaoImpl.getAlbumPictureList(id);
		User_detail albumud = this.userDaoImpl.findDetailByMail(this.userDaoImpl.getByName(album.getUsername()).getMail());
		model.addAttribute("album", album);
		model.addAttribute("aplist", aplist);
		model.addAttribute("albumud", albumud);
	}
	
	//相册——上传图片功能
	public Object uploadImage(int id, MultipartFile file, HttpServletRequest request) {
		byte[] image;
		StringBuilder name = new StringBuilder();
    	if(!file.isEmpty()) {
    		try {
    			image = file.getBytes();
    			//利用时刻创造一个唯一的文件名
    			LocalTime t = LocalTime.now();
    			name.append(t.getHour()); name.append(t.getMinute()); name.append(t.getSecond()); name.append(t.getNano());
    			String realFile = request.getServletContext().getRealPath("/") + "res/common/uploads/albumimage/" + name.toString() + ".jpg";
    			@SuppressWarnings("resource")
				OutputStream output = new FileOutputStream(new File(realFile));
    			output.write(image); 
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	
    	//更新该album的状态 face length
    	Album album = this.albumDaoImpl.getAlbum(id);
    	if(album.getNum() == 0) {
    		album.setFaces(name.toString() + ".jpg");
    	}
    	album.setNum(album.getNum() + 1);
    	this.albumDaoImpl.updateAlbum(album);
    	
    	//持久化一个albumpicture对象
    	AlbumPicture ap = new AlbumPicture();
    	ap.setAlbumid(id);
    	ap.setCreatedtime(this.getCurrentTime());
    	ap.setImage(name.toString() + ".jpg");
    	ap.setUsername(album.getUsername());
    	this.albumDaoImpl.saveAlbumPicture(ap);
    	
    	return new ResponseModel(0,"上传成功",name.toString() + ".jpg");
	}
	
	private String getCurrentTime() {
		StringBuilder time = new StringBuilder();
		time.append(LocalDate.now().toString() + " ");
		LocalTime t = LocalTime.now();
		String[] tim = t.toString().split("\\.");
		time.append(tim[0]);
		return time.toString();
	}
	
	//没想到在一个简简单单的box里也要加对象
	public void toUploadPic(Model model, int albumid) {
		model.addAttribute("album", this.albumDaoImpl.getAlbum(albumid));
	}
	
	//测试用
	public void deleteAllAlbum() {
		this.albumDaoImpl.deleteAllAlbum();
	}
	
	//存一个相册照片对象
	public void pictureDetail(int id, Model model) {
		AlbumPicture picture = this.albumDaoImpl.getAlbumPicture(id);
		model.addAttribute("picture", picture);
		//烦人的头像
		model.addAttribute("icon", this.userDaoImpl.findDetailByMail(this.userDaoImpl.getByName(picture.getUsername()).getMail()).getIcon());
	}
	
	//相册照片点赞
	public Res pictureFavor(int id, HttpSession session) {
		Res res = new Res();
		User u = (User) session.getAttribute("currentuser");
		if(u == null) {
			res.setCode(-1);
			res.setMsg("请先登录");
			return res;
		}
		AlbumPicture picture = this.albumDaoImpl.getAlbumPicture(id);
		Album a = this.albumDaoImpl.getAlbum(picture.getAlbumid());
		if(this.albumDaoImpl.isPictureUpvoted(id, u.getMail())) {
			picture.setUpvotes(picture.getUpvotes() - 1);
			this.albumDaoImpl.updateAlbumPicture(picture);
			res.setCode(1);
			res.setData(picture.getUpvotes() + "");
			//删掉点赞记录
			this.albumDaoImpl.deletePictureUpvote(id, u.getMail());
			//更新一下album的点赞数
			a.setUpvotes(a.getUpvotes() - 1);
			this.albumDaoImpl.updateAlbum(a);
		}else {
			picture.setUpvotes(picture.getUpvotes() + 1);
			this.albumDaoImpl.updateAlbumPicture(picture);
			res.setCode(0);
			res.setData(picture.getUpvotes() + "");
			//持久化upvote
			PictureUpvote pu = new PictureUpvote();
			pu.setMail(u.getMail());
			pu.setPictureid(id);
			this.albumDaoImpl.savePictureUpload(pu);
			//更新一下album的点赞数
			a.setUpvotes(a.getUpvotes() + 1);
			this.albumDaoImpl.updateAlbum(a);
		}
		return res;
	}
	
	//相册照片评论
	public Res pictureComment(int id, HttpSession session, String content) {
		Res res = new Res();
		User u = (User) session.getAttribute("currentuser");
		if(u == null) {
			res.setCode(-1);
			res.setMsg("请先登录");
			return res;
		}
		
		PictureComment pc = new PictureComment();
		pc.setContent(content);
		pc.setCreatedtime(getCurrentTime());
		pc.setPictureid(id);
		pc.setUsername(u.getName());
		this.albumDaoImpl.savePictureComment(pc);
		
		res.setCode(0);
		res.setMsg("评论成功");
		return res;
	}
	
	//列出该相册图片详情页面中的评论
	public List<CommentBean> listPictureComment(int id){
		return this.albumDaoImpl.getCommentBeanList(id);
	}
	
	//以下是关于“图库”的内容
	public List<AlbumPicture> showFirstPage(){
		List<AlbumPicture> aplist = null;
		try {
			aplist = this.albumDaoImpl.find4Page(1, 20);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return aplist;
	}
	//加载下一页的内容
	public List<PictureBean> indexData(int pageNo) {
		List<AlbumPicture> aplist = null;
		try {
			aplist = this.albumDaoImpl.find4Page(pageNo, 20);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<PictureBean> pblist = new ArrayList<>();
		for(AlbumPicture ap : aplist) {
			PictureBean pb = new PictureBean();
			pb.setPictureId(ap.getId());
			pb.setCreatedTime(pb.getCreatedTime());
			pb.setFavorCount(ap.getUpvotes());
			pb.setPath(ap.getImage());
			pb.setUsername(ap.getUsername());
			
			User u = (User) this.albumDaoImpl.getUserByName(ap.getUsername());
			if(this.albumDaoImpl.isPictureUpvoted(pb.getPictureId(), u.getMail())) {
				pb.setIsFavor(0);
			}else {
				pb.setIsFavor(1);
			}
		}
		return pblist;
	}
}
