package com.aesopsns.user.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.socket.TextMessage;

import com.aesopsns.entity.common.Res;
import com.aesopsns.entity.user.ContactMember;
import com.aesopsns.entity.user.ContactMemberBean;
import com.aesopsns.entity.user.CreditDetail;
import com.aesopsns.entity.user.Follow;
import com.aesopsns.entity.user.PrivateMessage;
import com.aesopsns.entity.user.PrivateMessageBean;
import com.aesopsns.entity.user.User;
import com.aesopsns.entity.user.User_detail;
import com.aesopsns.updating.dao.UpdatingDaoImpl;
import com.aesopsns.user.dao.UserDaoImpl;
import com.aesopsns.websocket.MyHandler;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class UserServiceImpl {
	@Resource
	private UserDaoImpl userDaoImpl;
	@Resource
	private UpdatingDaoImpl updatingDaoImpl;
	//加入websocket功能
	@Resource
	MyHandler myHandler;
	
	//进行用户注册操作
	//后面分别追加了一个一对一和一个一对多操作
	public void doRegist(String name, String password, String mail) {
		//没有才能存
		if(this.userDaoImpl.findByMail(mail) && this.userDaoImpl.findByName(name)) {
			User u = new User();
			u.setMail(mail);
			u.setName(name);
			u.setPassword(password);
			
			User_detail ud = new User_detail();
			ud.setJoin_time(LocalDate.now().toString());
			ud.setMail(mail);
			ud.setCredit(100); 		//初始积分为100
			ud.setSex("privacy");
			
			CreditDetail cd = this.getCustomCreditDetail(u.getMail(), 100, "注册奖励", this.getCurrentTime());
			//一对一配置
			ud.setUser(u);
			u.setUd(ud);
			//一对多配置
			cd.setUser(u);
			u.getCdSet().add(cd);

			//进行User对象和User_detail对象的持久化
			this.addUser(u);
			this.addUser_detail(ud);
			this.addCreditDetail(cd);
		}
	}
	//辅助函数，获取一个CreditDetail对象
	private CreditDetail getCustomCreditDetail(String mail, int alter, String comment, String time) {
		CreditDetail cd = new CreditDetail();
		cd.setMail(mail);
		cd.setAlteration(alter);
		cd.setComment(comment);
		cd.setTime(time);
		return cd;
	}
	//辅助函数，以一定格式输出当前时刻字符串
	private String getCurrentTime() {
		StringBuilder time = new StringBuilder();
		time.append(LocalDate.now().toString() + " ");
		LocalTime t = LocalTime.now();
		time.append(t.getHour() + ":");
		time.append(t.getMinute() + ":");
		time.append(t.getSecond());
		return time.toString();
	}
	
	//doRegist的辅助函数，进行User对象的持久化
	private void addUser(User u) {
		this.userDaoImpl.saveUser(u);
	}
	//doRegist的辅助函数，进行User_detail对象的持久化
	private void addUser_detail(User_detail ud) {
		this.userDaoImpl.saveUser_detail(ud);
	}
	//doRegist的辅助函数，进行CreditDetail对象的持久化
	private void addCreditDetail(CreditDetail cd) {
		this.userDaoImpl.saveCreditDetail(cd);
	}
	
	//mail和name的查重
	public String isMailOrNameExist(String mail, String name) {
		String error = "";
		if(!this.userDaoImpl.findByMail(mail)) {
			error = "<div class=\"layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layer-anim\" id=\"layui-layer6\" type=\"dialog\" times=\"6\" showtime=\"3000\" contype=\"string\" style=\"z-index: 19891020; top: 355px; left: 666px;\">\r\n" + 
					"    			<div id=\"\" class=\"layui-layer-content layui-layer-padding\">\r\n" + 
					"    			<i class=\"layui-layer-ico layui-layer-ico5\"></i>This mail is used!\r\n" + 
					"    			</div>\r\n" + 
					"    			<span class=\"layui-layer-setwin\"></span>\r\n" + 
					"    			</div>";
		}
		
		if(!this.userDaoImpl.findByName(name)) {
			error = "<div class=\"layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layer-anim\" id=\"layui-layer6\" type=\"dialog\" times=\"6\" showtime=\"3000\" contype=\"string\" style=\"z-index: 19891020; top: 355px; left: 666px;\">\r\n" + 
					"    			<div id=\"\" class=\"layui-layer-content layui-layer-padding\">\r\n" + 
					"    			<i class=\"layui-layer-ico layui-layer-ico5\"></i>This name is used!\r\n" + 
					"    			</div>\r\n" + 
					"    			<span class=\"layui-layer-setwin\"></span>\r\n" + 
					"    			</div>";
		}
		
		return error;
	}
	
	//登录信息检查
	//登录功能同样在后期分别追加了一对一操作和多对一操作
	public String loginInfoCheck(String account, String password, HttpSession session) {
		String error = "";
		User u = null;
		if(this.userDaoImpl.findByMail(account) && this.userDaoImpl.findByName(account)) {
			error = "<div class=\"layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layer-anim\" id=\"layui-layer6\" type=\"dialog\" times=\"6\" showtime=\"3000\" contype=\"string\" style=\"z-index: 19891020; top: 355px; left: 666px;\">\r\n" + 
					"    			<div id=\"\" class=\"layui-layer-content layui-layer-padding\">\r\n" + 
					"    			<i class=\"layui-layer-ico layui-layer-ico5\"></i>Account not found!\r\n" + 
					"    			</div>\r\n" + 
					"    			<span class=\"layui-layer-setwin\"></span>\r\n" + 
					"    			</div>";
		}else { //如果没找到用户，后面也别对密码了
			u = this.userDaoImpl.findByPassword(password, account);
			if(u == null) {
				error = "<div class=\"layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layer-anim\" id=\"layui-layer6\" type=\"dialog\" times=\"6\" showtime=\"3000\" contype=\"string\" style=\"z-index: 19891020; top: 355px; left: 666px;\">\r\n" + 
						"    			<div id=\"\" class=\"layui-layer-content layui-layer-padding\">\r\n" + 
						"    			<i class=\"layui-layer-ico layui-layer-ico5\"></i>Password mismatched!\r\n" + 
						"    			</div>\r\n" + 
						"    			<span class=\"layui-layer-setwin\"></span>\r\n" + 
						"    			</div>";
			}
		}
		
		//如果登陆成功，就将User对象和User_detail对象存到session里
		if(error.equals("")) {
			session.setAttribute("currentuser", u);
			User_detail ud = u.getUd();
			
			Set<CreditDetail> cdOrder = u.getCdSet();
			//签到登录加一分，并记录下积分变更明细
			if(!LocalDate.now().toString().equals(ud.getRecent_login())){	//如果最近登陆时间与最近登陆时间不同，就说明是隔天登录
				ud.setCredit(ud.getCredit() + 1);
				CreditDetail cd = this.getCustomCreditDetail(u.getMail(), 1, "每天登录奖励", this.getCurrentTime());
				cdOrder.add(cd);
				this.addCreditDetail(cd);
			}
			ud.setRecent_login(LocalDate.now().toString());   //我去，原来把这句放错位置了
			//更新一下用户详情及增加一个积分明细记录
			this.userDaoImpl.updateUser_detail(ud);
			session.setAttribute("userdetail", ud);  //这个对象需要经常更新
		}
		
		return error;
	}
	
	//找回密码
	public String getBackPassword(String name, String mail) {
		String error = "";
		
		if(this.userDaoImpl.findByName(name)) {
			error = "<div class=\"layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layer-anim\" id=\"layui-layer6\" type=\"dialog\" times=\"6\" showtime=\"3000\" contype=\"string\" style=\"z-index: 19891020; top: 355px; left: 666px;\">\r\n" + 
					"    			<div id=\"\" class=\"layui-layer-content layui-layer-padding\">\r\n" + 
					"    			<i class=\"layui-layer-ico layui-layer-ico5\"></i>name not found!\r\n" + 
					"    			</div>\r\n" + 
					"    			<span class=\"layui-layer-setwin\"></span>\r\n" + 
					"    			</div>";
			
			//用户名找不到，直接返回
			return error;
		}
		
		if(this.userDaoImpl.findByMail(mail)) {
			error = "<div class=\"layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layer-anim\" id=\"layui-layer6\" type=\"dialog\" times=\"6\" showtime=\"3000\" contype=\"string\" style=\"z-index: 19891020; top: 355px; left: 666px;\">\r\n" + 
					"    			<div id=\"\" class=\"layui-layer-content layui-layer-padding\">\r\n" + 
					"    			<i class=\"layui-layer-ico layui-layer-ico5\"></i>Mail mismatched!\r\n" + 
					"    			</div>\r\n" + 
					"    			<span class=\"layui-layer-setwin\"></span>\r\n" + 
					"    			</div>";
			
			//用户名找到了，但是邮箱不匹配
			return error;
		}
		
		//用户提供信息匹配，直接将密码返回给用户
		error = "<div class=\"layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layer-anim\" id=\"layui-layer6\" type=\"dialog\" times=\"6\" showtime=\"3000\" contype=\"string\" style=\"z-index: 19891020; top: 355px; left: 666px;\">\r\n" + 
				"    			<div id=\"\" class=\"layui-layer-content layui-layer-padding\">\r\n" + 
				"    			<i class=\"layui-layer-ico layui-layer-ico4\"></i>" + "Your Password: " + this.userDaoImpl.getPassword(mail) + "\r\n" + 
				"    			</div>\r\n" + 
				"    			<span class=\"layui-layer-setwin\"></span>\r\n" + 
				"    			</div>";
		return error;
	}
	
	//修改用户基本信息
	public void updateBaseInfo(String sex, String intro, HttpSession session) {
		User_detail ud = (User_detail) session.getAttribute("userdetail");
		ud.setSex(sex);
		ud.setIntro(intro);
		//应用层和持久层的用户详细信息都得更新一下
		session.setAttribute("userdetail", ud);
		this.userDaoImpl.updateUser_detail(ud);
	}
	
	//修改用户其它信息
	public void updateOtherInfo(String birthday, String qq, String wechat, String cellphone,String personal_web, HttpSession session) {
		User_detail ud = (User_detail) session.getAttribute("userdetail");
		ud.setBirthday(birthday);
		ud.setQq(qq);
		ud.setWechat(wechat);
		ud.setCellphone(cellphone);
		ud.setPersonal_web(personal_web);
		//应用层和持久层的用户详细信息都得更新一下
		session.setAttribute("userdetail", ud);
		this.userDaoImpl.updateUser_detail(ud);
	}
	
	//上传头像
	public void uploadIcon(MultipartFile file, HttpSession session, HttpServletRequest request) {
		byte[] icon;
		StringBuilder name = new StringBuilder();
    	if(!file.isEmpty()) {
    		try {
    			icon = file.getBytes();
    			//利用时刻创造一个唯一的文件名
    			LocalTime t = LocalTime.now();
    			name.append(t.getHour()); name.append(t.getMinute()); name.append(t.getSecond()); name.append(t.getNano());
    			String realFile = request.getServletContext().getRealPath("/") + "res/common/uploads/" + name.toString() + ".jpg";
    			@SuppressWarnings("resource")
				OutputStream output = new FileOutputStream(new File(realFile));
    			output.write(icon); 
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    		
    		User_detail ud = (User_detail)session.getAttribute("userdetail");    	
    		ud.setIcon(name.toString() + ".jpg");
    		//应用层和持久层的用户详细信息都得更新一下
    		session.setAttribute("userdetail", ud);
    		this.userDaoImpl.updateUser_detail(ud);
    		
    		//也存到User里去吧（可能使我设计的有些不行吧）（用户的头像在这个网站中随处可见，这样可以减少很多数据库查询吧）
    		User u = (User) session.getAttribute("currentuser");
    		u.setIcon(name.toString() + ".jpg");
    		session.setAttribute("currentuser", u);
    		this.userDaoImpl.updateUser(u);
    	}
	}
	
	//修改密码
	public String rePassword(String repassword, String oldpassword, HttpSession session) {
		User u = (User) session.getAttribute("currentuser");
		
		if(oldpassword.equals(u.getPassword())) {
			u.setPassword(repassword);
			session.setAttribute("currentuser", u);
			this.userDaoImpl.updateUser(u);
			return "<div class=\"layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layer-anim\" id=\"layui-layer6\" type=\"dialog\" times=\"6\" showtime=\"3000\" contype=\"string\" style=\"z-index: 19891020; top: 355px; left: 666px;\">\r\n" + 
					"    			<div id=\"\" class=\"layui-layer-content layui-layer-padding\">\r\n" + 
					"    			<i class=\"layui-layer-ico layui-layer-ico6\"></i>Manipulation succeed!\r\n" + 
					"    			</div>\r\n" + 
					"    			<span class=\"layui-layer-setwin\"></span>\r\n" + 
					"    			</div>";
		}else {
			return "<div class=\"layui-layer layui-layer-dialog layui-layer-border layui-layer-msg layer-anim\" id=\"layui-layer6\" type=\"dialog\" times=\"6\" showtime=\"3000\" contype=\"string\" style=\"z-index: 19891020; top: 355px; left: 666px;\">\r\n" + 
					"    			<div id=\"\" class=\"layui-layer-content layui-layer-padding\">\r\n" + 
					"    			<i class=\"layui-layer-ico layui-layer-ico5\"></i>Oldpassword incorrect!\r\n" + 
					"    			</div>\r\n" + 
					"    			<span class=\"layui-layer-setwin\"></span>\r\n" + 
					"    			</div>";
		}
	}
	
	//转到其他用户的个人页面
	public void setOthers(String name, HttpSession session) {
		User u = this.userDaoImpl.getByName(name);
		session.setAttribute("anotheruser", u);
		session.setAttribute("anotheruserdetail", u.getUd());
		//如果当前用户关注了这个用户，我们需要一个标志位标明
		String umail = null;
		if(session.getAttribute("currentuser") == null)	umail = "#####";
		else	umail = ((User) session.getAttribute("currentuser")).getMail();
		if(this.userDaoImpl.isFollowed(umail, u.getMail())) {
			session.setAttribute("isfollowed", true);
		}else {
			session.setAttribute("isfollowed", false);
		}
	}
	
	//个人动态
	public void personalUpdating(String type, String name, HttpSession session, Model model) {
		if(name == null) {
			User u = (User) session.getAttribute("currentuser");
			if(type == null) {
				model.addAttribute("updatings", this.updatingDaoImpl.getUpdatingsByUpdater(u.getName()));
				model.addAttribute("title", "动态");
			}
			else {
				model.addAttribute("updatings", this.updatingDaoImpl.getUpdatingsByUpdaterAndType(u.getName(), type));
				if(type.equals("1"))	model.addAttribute("title", "文章");
				else if(type.equals("2"))	model.addAttribute("title", "群组帖子");
				else	model.addAttribute("title", "微博");
			}
		}else {
			if(type == null) {
				model.addAttribute("updatings", this.updatingDaoImpl.getUpdatingsByUpdater(name));
				model.addAttribute("title", "动态");
			}
			else {
				model.addAttribute("updatings", this.updatingDaoImpl.getUpdatingsByUpdaterAndType(name, type));
				if(type.equals("1"))	model.addAttribute("title", "文章");
				else if(type.equals("2"))	model.addAttribute("title", "群组帖子");
				else	model.addAttribute("title", "微博");
			}
		}
	}
	
	//新建当前用户的私信对象并向前台返回弹出层代码
	public void sendMessageBox(String mail, HttpSession session) {
		//User u = (User) session.getAttribut e("currentuser");
		User another = this.userDaoImpl.getByMail(mail);
		//私信对象名在messagebox中有要求，所以要存起来
		session.setAttribute("contactmember", another.getName());
	}
	
	//列出联系人
	public List<ContactMemberBean> listContactMember(String mail, HttpSession session){
		Set<ContactMember> cmListProto = ((User) session.getAttribute("currentuser")).getCmSet();
		System.out.println(cmListProto.size());
		List<ContactMemberBean> cmList = new ArrayList<>();
		for(ContactMember cm : cmListProto) {
			cmList.add(this.toCmb(cm, ((User) session.getAttribute("currentuser")).getMail()));
		}
		return cmList;
	}
	//辅助函数
	private ContactMemberBean toCmb(ContactMember cm, String mail) {
		ContactMemberBean cmb = new ContactMemberBean();
		if(cm.getMail().equals(mail)) {
			cmb.setMail(cm.getMail());
			cmb.setTarget(cm.getTarget());
			String icon = this.userDaoImpl.getByName(cm.getTarget()).getUd().getIcon();
			if(icon == null) {
				cmb.setIcon("/Aesopsns/res/common/images/default-avatar.png");
			}else {
				cmb.setIcon("/Aesopsns/res/common/uploads/" + icon);
			}
		}else {
			User another = this.userDaoImpl.getByMail(cm.getMail());
			cmb.setMail(mail);
			cmb.setTarget(another.getName());
			String icon = another.getUd().getIcon();
			if(icon == null) {
				cmb.setIcon("/Aesopsns/res/common/images/default-avatar.png");
			}else {
				cmb.setIcon("/Aesopsns/res/common/uploads/" + icon);
			}
		}
		return cmb;
	}
	
	//私信模块中处理消息的功能点
	public PrivateMessageBean sendMessage(String messagetarget, String content, HttpSession session) {//返回值为0说明发送成功
		User u = this.userDaoImpl.getByMail(((User) session.getAttribute("currentuser")).getMail());
		//先前创建联系人的顺序不对，那段逻辑出现的时机早了，其实应该放在这儿
		User another = this.userDaoImpl.getByName(messagetarget);
		//为了这个判等我还特意在表中新添了一个字段，如果联系人对象已经存在了，就不必创建了
		if(!this.userDaoImpl.isContactMemberExist(u.getName() + another.getName())&&
				!this.userDaoImpl.isContactMemberExist(another.getName() + u.getName())) {
			//新建一个联系人对象
			ContactMember cm = new ContactMember();
			cm.setMail(u.getMail());
			cm.setTarget(another.getName());
			cm.setContactmember(u.getName() + another.getName());
			
			//一波多对多的配置
			u.getCmSet().add(cm);
			another.getCmSet().add(cm);
			cm.getUserSet().add(u);
			cm.getUserSet().add(another);
			this.userDaoImpl.saveContactMember(cm);
			//原来hibernate能力也有限啊
			this.userDaoImpl.updateUser(u);
			this.userDaoImpl.updateUser(another);
		}
		
		//新建一个消息对象
		PrivateMessage pm = new PrivateMessage();
		pm.setMail(u.getMail());
		pm.setSender(u.getName());
		pm.setTarget(another.getName());
		pm.setMessage(content);
		pm.setTime(this.getCurrentTime());
		
		//这个必须填绝对路径，如果为null，就填写那张默认图片的绝对路径
		String icon = u.getUd().getIcon();
		if(icon == null) {
			pm.setIcon("/Aesopsns/res/common/images/default-avatar.png");
		}else {
			pm.setIcon("/Aesopsns/res/common/uploads/" + icon);
		}
		
		
		//又是一波多对多的配置
		u.getPmSet().add(pm);
		another.getPmSet().add(pm);
		pm.getUserSet().add(u);
		pm.getUserSet().add(another);
		this.userDaoImpl.savePrivateMessage(pm);
		//原来hibernate能力也有限啊
		this.userDaoImpl.updateUser(u);
		this.userDaoImpl.updateUser(another);
		
		//建一个转json用的bean,因为PrivateMessage在配了多对多之后，就不是严格意义上的Bean了
		PrivateMessageBean pmb = this.toPmb(pm);
		
		//最后，利用websocket，把消息推送到对方的私信界面上（如果对方正在私信界面和本人聊天的话）
		ObjectMapper mapper = new ObjectMapper();  
		try {
			myHandler.sendMessageToUser(another.getName(), new TextMessage(mapper.writeValueAsString(pmb)));
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return pmb;
	}
	
	private PrivateMessageBean toPmb(PrivateMessage pm) {
		//建一个转json用的bean,因为PrivateMessage在配了多对多之后，就不是严格意义上的Bean了
		PrivateMessageBean pmb = new PrivateMessageBean();
		pmb.setIcon(pm.getIcon());
		pmb.setMail(pm.getMail());
		pmb.setSender(pm.getSender());
		pmb.setMessage(pm.getMessage());
		pmb.setTarget(pm.getTarget());
		pmb.setTime(pm.getTime());
		
		return pmb;
	}
	//私信模块中获取聊天记录的功能点
	public List<PrivateMessageBean> getMessageRecords(String usermail, String membername) {
		List<PrivateMessage> recordListProto = this.userDaoImpl.findpmRecords(membername);
		List<PrivateMessageBean> recordList = new ArrayList<>();
		//整成一个Bean List
		if(recordListProto.size() > 0) {
			for(PrivateMessage pm : recordListProto) 	recordList.add(this.toPmb(pm));
		}
		return recordList; 
	}
	//个人页面下的关注功能模块
	public Res follow(HttpSession session) {
		//在session里存这两个对象，多少是方便了一些吧
		User u = (User) session.getAttribute("currentuser");
		User_detail ud =  (User_detail) session.getAttribute("userdetail");
		User other = (User) session.getAttribute("anotheruser");
		User_detail otherd =  (User_detail) session.getAttribute("anotheruserdetail");
		Res res = new Res();
		//前端处理，如果用户没登录
		if(u == null) {
			res.setCode(1);
			res.setMsg("请先登录");
			return res;
		}
		//不能自己关注自己
		if(u.getMail().equals(other.getMail())) {
			res.setCode(1);
			res.setMsg("不能自己关注自己");
			return res;
		}
		
		//总之是u关注了other，这里有个分支，就是如果之前关注了，就取消掉
		//哦，对了User_detail里还有一个关注数，被关注数呢，得更新一下
		if(this.userDaoImpl.isFollowed(u.getMail(), other.getMail())) {
			//删掉关注记录
			this.userDaoImpl.deleteFollowing(u.getMail(), other.getMail());
			//需要一个标志位，表明当前用户已被关注
			session.setAttribute("isfollowed", false);
			res.setMsg("已取消关注");
			res.setCode(1);
			//更新一下双方的关注数和被关注数
			ud.setFocus(ud.getFocus() - 1);
			otherd.setFans(otherd.getFans() - 1);
			this.userDaoImpl.updateUser_detail(ud);
			this.userDaoImpl.updateUser_detail(otherd);
		}else {
			Follow follow = new Follow();
			follow.setFollower(u.getMail());
			follow.setBefollowed(other.getMail());
			//持久化
			this.userDaoImpl.saveFollow(follow);
			//需要一个标志位，表明当前用户已被关注
			session.setAttribute("isfollowed", true);
			res.setMsg("已关注");
			res.setCode(0);
			//更新一下双方的关注数和被关注数
			ud.setFocus(ud.getFocus() + 1);
			otherd.setFans(otherd.getFans() + 1);
			this.userDaoImpl.updateUser_detail(ud);
			this.userDaoImpl.updateUser_detail(otherd);
		}
		return res;
	}
	//在个人页面列出关注的人
	public void listFollows(String username, Model model) {
		model.addAttribute("followlist", this.userDaoImpl.getFollowList(this.userDaoImpl.getByName(username).getMail()));
	}
	//在个人页面列出此人的粉丝
	public void listFans(String username, Model model) {
		model.addAttribute("fanslist", this.userDaoImpl.getFollowerList(this.userDaoImpl.getByName(username).getMail()));
	}
	
	public void deleteAll() {
//		this.userDaoImpl.deleteAll();
		this.userDaoImpl.deleteAllContactMember();
		this.userDaoImpl.deleteAllPrivateMessage();
	}
}
