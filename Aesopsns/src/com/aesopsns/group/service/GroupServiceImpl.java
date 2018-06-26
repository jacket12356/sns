package com.aesopsns.group.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.aesopsns.entity.common.CommentData;
import com.aesopsns.entity.common.Page;
import com.aesopsns.entity.common.Res;
import com.aesopsns.entity.common.Updating;
import com.aesopsns.entity.group.Group;
import com.aesopsns.entity.group.GroupFollow;
import com.aesopsns.entity.group.Post;
import com.aesopsns.entity.group.PostComment;
import com.aesopsns.entity.user.User;
import com.aesopsns.entity.weibo.ResponseModel;
import com.aesopsns.group.dao.GroupDaoImpl;
import com.aesopsns.user.dao.UserDaoImpl;

@Service
public class GroupServiceImpl {
	@Resource
	private GroupDaoImpl groupDaoImpl;
	@Resource
	private UserDaoImpl userDaoImpl;
	
	public void listGroup(Model model) {
		model.addAttribute("groups", this.groupDaoImpl.getGrouplist());
	}
	
	//申请群组需要上传的图片
	public ResponseModel uploadImage(MultipartFile file, HttpServletRequest request) {
		byte[] image;
		StringBuilder name = new StringBuilder();
    	if(!file.isEmpty()) {
    		try {
    			image = file.getBytes();
    			//利用时刻创造一个唯一的文件名
    			LocalTime t = LocalTime.now();
    			name.append(t.getHour()); name.append(t.getMinute()); name.append(t.getSecond()); name.append(t.getNano());
    			String realFile = request.getServletContext().getRealPath("/") + "res/common/uploads/groupimage/" + name.toString() + ".jpg";
    			@SuppressWarnings("resource")
				OutputStream output = new FileOutputStream(new File(realFile));
    			output.write(image); 
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	return new ResponseModel(0,"上传成功","/res/common/uploads/groupimage/" + name.toString() + ".jpg");
	}
	
	//表单提交创建群组
	public Res addGroup(String name, String face, String intro, String tags, HttpSession session) {
		User u = (User) session.getAttribute("currentuser");
		Res res = new Res();
		//还没登录的话
		if(u == null) {
			res.setCode(-1);
			res.setMsg("请先登录");
			return res;
		}
		
		Group group = new Group();
		group.setCreatedtime(this.getCurrentTime());
		group.setCreator(u.getName());
		String[] faces = face.split("/");
		group.setFace(faces[faces.length - 1]);
		group.setIntro(intro);
		group.setName(name);
		group.setTags(tags);
		
		this.groupDaoImpl.saveGroup(group);
		res.setCode(0);
		res.setMsg("操作成功");
		return res;
	}
	private String getCurrentTime() {
		StringBuilder time = new StringBuilder();
		time.append(LocalDate.now().toString() + " ");
		LocalTime t = LocalTime.now();
		String[] tim = t.toString().split("\\.");
		time.append(tim[0]);
		return time.toString();
	}
	
	//群组详情页面
	public void setGroupDetail(int id, Model model, HttpSession session, String pageNo) {
		//先从数据库中获取群组的详细信息
		model.addAttribute("group", this.groupDaoImpl.findGroupById(id));
		//再从数据库中获取该群组的所有follower
		User u = (User) session.getAttribute("currentuser");
		model.addAttribute("gflist", this.groupDaoImpl.getGroupFollowList(id));
		if(u != null) {
			model.addAttribute("isfollowed", this.groupDaoImpl.isGroupFollowed(id, u.getName()));
		}else {
			model.addAttribute("isfollowed", false);
		}
		//最后从数据库中获取该群组的所有帖子，这个得分页取
//		model.addAttribute("postlist", this.groupDaoImpl.getPostList(id));
		if(pageNo == null) {
			model.addAttribute("postlist", this.listPostByPage(1, id, model));
		}else {
			model.addAttribute("postlist", this.listPostByPage(Integer.parseInt(pageNo), id, model));
		}
	}
	//此为辅助函数，方便分页列出群组详情页的帖子
	@SuppressWarnings("unused")
	private List<Post> listPostByPage(int pageNo, int groupid, Model model){
		Page postpage = new Page(2, this.groupDaoImpl.findCount(groupid));
		postpage.setCurrentPage(pageNo);
		model.addAttribute("postpage", postpage);
		return this.groupDaoImpl.find4Page(postpage.getCurrentPage(), postpage.getPageSize(), groupid);
	}
	
	//关注群组
	public Res groupFollow(int id, HttpSession session) {
		User u = (User) session.getAttribute("currentuser");
		Res res = new Res();
		//还没登录的话
		if(u == null) {
			res.setCode(-1);
			res.setMsg("请先登录");
			return res;
		}
		
		if(this.groupDaoImpl.isGroupFollowed(id, u.getName())) {
			this.groupDaoImpl.deleteGroupFollow(id, u.getName());
			
			//更新一下群组的关注数
			Group group = this.groupDaoImpl.getGroup(id);
			group.setFocus(group.getFocus() - 1);
			this.groupDaoImpl.updateGroup(group);
		}else {
			GroupFollow gf = new GroupFollow();
			gf.setFollower(u.getName());
			gf.setFollowericon(u.getIcon());
			gf.setGroupid(id);
			this.groupDaoImpl.saveGroupFollow(gf);
			
			//更新一下群组的关注数
			Group group = this.groupDaoImpl.getGroup(id);
			group.setFocus(group.getFocus() + 1);
			this.groupDaoImpl.updateGroup(group);
		}
		
		res.setCode(1);
		res.setMsg("操作成功");
		return res;
	}
	
	//转到群组发帖，需要判断用户是否关注该群组
	public Res toPost(int id, HttpSession session, Model model) {
		User u = (User) session.getAttribute("currentuser");
		Res res = new Res();
		//还没登录的话
		if(u == null) {
			res.setCode(4);
			res.setUrl("/Aesopsns/user/login");
			return res;
		}
		
		if(this.groupDaoImpl.isGroupFollowed(id, u.getName())) {
			model.addAttribute("groupid", id);
			res.setCode(4);
			res.setUrl("/Aesopsns/group/post/" + id);
			return res;
		}else {
			res.setCode(-1);
			res.setMsg("请先关注");
			return res;
		}
	}
	
	//帖子表单提交
	public Res posting(int groupid, String title, String thumbnail, String description,
			String content, HttpSession session, HttpServletRequest request) {
		User u = (User) session.getAttribute("currentuser");
		Post post = new Post();
		post.setGroupid(groupid);
		post.setTitle(title);
		post.setIcon(thumbnail);
		post.setDescription(description);
		String contentname = this.uploadContent(content, request);
		post.setContent(contentname);
		post.setPublisher(u.getName());
		post.setPublishtime(this.getCurrentTime());
		post.setComments(0);
		
		this.groupDaoImpl.savePost(post);
		
		//更新动态
		Updating updating = new Updating();
		updating.setDetailid(this.groupDaoImpl.getPost(post.getContent()).getId());
		updating.setIcon(u.getIcon());
		updating.setType(2);
		updating.setUpdater(u.getName());
		updating.setUpdatetime(this.getCurrentTime2());
		updating.setTitle(post.getTitle());
		this.groupDaoImpl.saveUpdating(updating);
		
		Res res = new Res();
		res.setCode(0);
		res.setMsg("操作成功");
		res.setUrl("/Aesopsns/group/postdetail/" + this.groupDaoImpl.getPost(contentname).getId());
		return res;
	}
	private String getCurrentTime2() {
		StringBuilder time = new StringBuilder();
		time.append(LocalDate.now().toString() + " ");
		LocalTime t = LocalTime.now();
		String[] tim = t.toString().split("\\.");
		time.append(tim[0]);
		return time.toString();
	}
	//将文章内容保存到本地，并返回文件名
	private String uploadContent(String content, HttpServletRequest request) {
		byte[] con = content.getBytes();
		StringBuilder name = new StringBuilder();
		LocalTime t = LocalTime.now();
		name.append(t.getHour()); name.append(t.getMinute()); name.append(t.getSecond()); name.append(t.getNano());
		String fileName = name.toString() + ".txt";
		String realFile = request.getServletContext().getRealPath("/") + "res/common/uploads/postcontent/" + fileName;
		try {
			@SuppressWarnings("resource")
			OutputStream output = new FileOutputStream(new File(realFile));
			output.write(con);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return fileName;
	}
	
	public String postDetail(int id, Model model, HttpServletRequest request, HttpSession session) {
		Post post = this.groupDaoImpl.getPostById(id);
		User u = (User) session.getAttribute("currentuser");
		//post对象与从txt中提取的postContent
		model.addAttribute("post", post);
		model.addAttribute("content", this.readToString(request.getServletContext().getRealPath("/") + "res/common/uploads/postcontent/" + post.getContent()));
		//帖子阅览数加1
		post.setReadcount(post.getReadcount() + 1);
		this.groupDaoImpl.updatePost(post);
		//该群组
		model.addAttribute("group", this.groupDaoImpl.findGroupById(post.getGroupid()));
		//user
		model.addAttribute("publisher", this.userDaoImpl.getByName(post.getPublisher()));
		//follow
		if(u != null) {
			model.addAttribute("isfollowed", this.groupDaoImpl.isGroupFollowed(id, u.getName()));
		}else {
			model.addAttribute("isfollowed", false);
		}
		return "front/group/postdetail";
	}
	//辅助函数，读取txt内容
	private String readToString(String fileName) {  
        String encoding = "UTF-8";  
        File file = new File(fileName);  
        Long filelength = file.length();  
        byte[] filecontent = new byte[filelength.intValue()];  
        try {  
            FileInputStream in = new FileInputStream(file);  
            in.read(filecontent);  
            in.close();  
        } catch (FileNotFoundException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        try {  
            return new String(filecontent, encoding);  
        } catch (UnsupportedEncodingException e) {  
            System.err.println("The OS does not support " + encoding);  
            e.printStackTrace();  
            return null;  
        }  
    }  
	
	public String postComment(int id, String content, HttpSession session, String postCommentId) {
		User u = (User) session.getAttribute("currentuser");
		if(u == null)	return "front/user/login";
		//数据过来先持久化
		PostComment postComment = new PostComment();
		postComment.setPostid(id);
		postComment.setContent(content);
		postComment.setCreatedtime(getCurrentTime());
		postComment.setUsername(u.getName());
		//如果该评论是引用某一个评论的话
		if(postCommentId != null) {
			postComment.setCited(1);
			postComment.setCitedcommemtid(Integer.parseInt(postCommentId));
		}else {
			postComment.setCited(0);
		}
		this.groupDaoImpl.savePostComment(postComment);
		//更新下微博的评论数
		Post w = this.groupDaoImpl.getPostById(id);
		w.setComments(w.getComments() + 1);
		this.groupDaoImpl.updatePost(w);
		//应该就这些吧
		return "redirect:/group/postdetail/" + id;
	}
	//列出某一条微博的所有评论
	public List<CommentData> commentData(int postid){
		return this.groupDaoImpl.getPostComments(postid);
	}
	
	//测试
	public String deleteAll() {
		this.groupDaoImpl.deleteAll();
		return "";
	}
}
