package com.aesopsns.manage.service;

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
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.aesopsns.entity.article.Article;
import com.aesopsns.entity.article.ArticleCate;
import com.aesopsns.entity.common.Page;
import com.aesopsns.entity.common.Res;
import com.aesopsns.entity.manage.ManageUser;
import com.aesopsns.entity.user.User;
import com.aesopsns.manage.dao.ManageDaoImpl;

@Service
public class ManageServiceImpl {
	@Resource
	private ManageDaoImpl manageDaoImpl;
	
	//后台登入
	public Res doLogin(String username, String password, HttpSession session) {
//		ManageUser mu = this.manageDaoImpl.getMu(username);
		Res res = new Res();
		if(password.equals("5820143a")) { //我还真懒得往数据库里加用户数据
			ManageUser mu = new ManageUser();
			mu.setUsername(username);
			mu.setPassword(password);
			session.setAttribute("manageuser", mu);
			res.setCode(1);
			res.setMsg("登陆成功");
			res.setUrl("/Aesopsns/manage/index");
		}else {
			res.setCode(-1);
			res.setMsg("账户与密码不匹配！");
			res.setUrl("/Aesopsns/manage/login");
		}
		return res;
	}
	
	//后台主页
	public String toIndex(Model model, HttpServletRequest request, HttpSession session) {
		//没登录不能进主页
		if(session.getAttribute("manageuser") == null) {
			return "manage/login";
		}
		
		
		Properties props = System.getProperties();
        //java版本
        String javaVersion = props.getProperty("java.version");
        //操作系统名称
        String osName = props.getProperty("os.name") + props.getProperty("os.version");
        //用户的主目录
        String userHome = props.getProperty("user.home");
        //用户的当前工作目录
        String userDir = props.getProperty("user.dir");
        //服务器IP
        String serverIP = request.getLocalAddr();
        //客户端IP
        String clientIP = request.getRemoteHost();
        //WEB服务器
        String webVersion = request.getServletContext().getServerInfo();
        //CPU个数
        String cpu = Runtime.getRuntime().availableProcessors() + "核";
        //虚拟机内存总量
        String totalMemory = (Runtime.getRuntime().totalMemory()/1024/1024) + "M";
        //虚拟机空闲内存量
        String freeMemory = (Runtime.getRuntime().freeMemory()/1024/1024) + "M";
        //虚拟机使用的最大内存量
        String maxMemory = (Runtime.getRuntime().maxMemory()/1024/1024) + "M";
        //网站根目录
        String webRootPath = request.getSession().getServletContext().getRealPath("");
        model.addAttribute("javaVersion",javaVersion);
        model.addAttribute("osName",osName);
        model.addAttribute("userHome",userHome);
        model.addAttribute("userDir",userDir);
        model.addAttribute("clientIP",clientIP);
        model.addAttribute("serverIP",serverIP);
        model.addAttribute("cpu",cpu);
        model.addAttribute("totalMemory",totalMemory);
        model.addAttribute("freeMemory",freeMemory);
        model.addAttribute("maxMemory",maxMemory);
        model.addAttribute("webVersion",webVersion);
        model.addAttribute("mysqlVersion","v5.6.15");
        model.addAttribute("webRootPath",webRootPath);
        model.addAttribute("systemVersion", "1.0");
        model.addAttribute("systemName","AESOPSNS");
        model.addAttribute("systemUpdateTime","2018-5-24");
        //managePath 
        request.getServletContext().setAttribute("managePath", "/Aesopsns");
        request.getServletContext().setAttribute("basePath", "/Aesopsns");
        
		
		return "manage/index";
	}
	
	//下面是文章管理部分
	
	//文章管理部分中的标签管理
	public void listCate(Model model) {
		model.addAttribute("catelist", this.manageDaoImpl.getCateList());
	}
	
	//增加标签
	public Res addCate(String catename) {
		ArticleCate cate = new ArticleCate();
		cate.setCatename(catename);
		this.manageDaoImpl.saveCate(cate);
		
		Res res = new Res();
		res.setMsg("操作成功");
		res.setCode(3);
		return res;
	}
	
	//标签编辑页面
	public void toEditCate(int cateid, Model model) {
		model.addAttribute("cate", this.manageDaoImpl.getCate(cateid));
	}
	
	//更新标签
	public Res updateCate(int cateid, String catename) {
		ArticleCate cate = this.manageDaoImpl.getCate(cateid);
		cate.setCatename(catename);
		this.manageDaoImpl.updateCate(cate);
		
		Res res = new Res();
		res.setMsg("操作成功");
		res.setCode(3);
		return res;
	}
	
	//删除标签
	public Res deleteCate(int cateid) {
		this.manageDaoImpl.deleteCate(cateid);
		
		Res res = new Res();
		res.setMsg("操作成功");
		res.setCode(1);
		return res;
	}
	
	//文章管理主页
	public void listcate(HttpSession session) {
		session.setAttribute("totalCount", this.manageDaoImpl.findArticleCount());
		session.setAttribute("catelist", this.manageDaoImpl.getCateList());
	}
	public void listArticle(HttpSession session) {
		session.setAttribute("articlepage", new Page(2, this.manageDaoImpl.findArticleCount()));
		if(session.getAttribute("catename") != null) 	session.removeAttribute("catename");
	}
	public void listArticleByCatename(HttpSession session, String catename) {
		session.setAttribute("articlepage", new Page(2, this.manageDaoImpl.findCountWithCateName(catename)));
		session.setAttribute("catename", catename);
	}
	public void listArticleByPageNo(HttpSession session, int pageNo, String key) {
		String catename = (String) session.getAttribute("catename");
		Page articlePage = (Page) session.getAttribute("articlepage");
		List<Article> currentPageList = null;
		//查询
		if(key != null) {
			currentPageList = this.search(key, pageNo, articlePage.getPageSize());
			session.setAttribute("articlepage", new Page(2, this.manageDaoImpl.findResultCount(key), pageNo));
			session.setAttribute("currentpagelist", currentPageList);
			return;
		}
		//分支出现了在“全部”下分页和在某个标签下分页
		if(catename == null) {
			try {
				//为了能看出分页效果，先弄每页两个吧
				currentPageList = this.manageDaoImpl.find4Page(pageNo, articlePage.getPageSize());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			session.setAttribute("articlepage", new Page(2, this.manageDaoImpl.findArticleCount(), pageNo));
			session.setAttribute("currentpagelist", currentPageList);
		}else {
			try {
				currentPageList = this.manageDaoImpl.find4PageByCatename(pageNo, articlePage.getPageSize(), catename);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			session.setAttribute("articlepage", new Page(2, this.manageDaoImpl.findCountWithCateName(catename), pageNo));
			session.setAttribute("currentpagelist", currentPageList);
		}
	}
	
	private List<Article> search(String key, int pageNo, int pageSize) {
		if(!key.startsWith("full-text:")) {
			//普通标题检索
			return this.manageDaoImpl.getArticlesByTitle(key, pageNo, pageSize);
		}
		return null;
	}
	
	public void editArticle(int id, Model model, HttpServletRequest request) {
		Article article = manageDaoImpl.findArticleById(id);
		model.addAttribute("article", article);
		model.addAttribute("content", this.readToString(request.getServletContext().getRealPath("/") + "res/common/uploads/articlecontent/" + article.getContent()));
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
	
	//发布文章
	public Res publishArticle(HttpSession session, MultipartFile file, int cateid, String title,
			String description, String articlecontent, HttpServletRequest request, int id) {
		//先建一个article对象
		String time = this.getCurrentTime();
		Article article = this.manageDaoImpl.findArticleById(id);
		if(!file.isEmpty())
			article.setImage(this.uploadImage(file, request));
		article.setContent(this.uploadContent(articlecontent, request));
		article.setTitle(title);
		article.setDescription(description);
		article.setPublishtime(time);
		article.setTag(this.manageDaoImpl.findCateNameById(cateid));
		//持久化article
		this.manageDaoImpl.updateArticle(article);
		
		Res res = new Res();
		res.setMsg("操作成功");
		res.setCode(3);
		return res;
	}
	//辅助函数，以一定格式输出当前时刻字符串
	private String getCurrentTime() {
		StringBuilder time = new StringBuilder();
		time.append(LocalDate.now().toString() + " ");
		LocalTime t = LocalTime.now();
		time.append(t.getHour() + ":");
		time.append(t.getMinute() );
		return time.toString();
	}
	//将文章内容保存到本地，并返回文件名
	private String uploadContent(String content, HttpServletRequest request) {
		byte[] con = content.getBytes();
		StringBuilder name = new StringBuilder();
		LocalTime t = LocalTime.now();
		name.append(t.getHour()); name.append(t.getMinute()); name.append(t.getSecond()); name.append(t.getNano());
		String fileName = name.toString() + ".txt";
		String realFile = request.getServletContext().getRealPath("/") + "res/common/uploads/articlecontent/" + fileName;
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
	
	//上传缩略图
	public String uploadImage(MultipartFile file, HttpServletRequest request) {
		byte[] image;
		StringBuilder name = new StringBuilder();
    	if(!file.isEmpty()) {
    		try {
    			image = file.getBytes();
    			//利用时刻创造一个唯一的文件名
    			LocalTime t = LocalTime.now();
    			name.append(t.getHour()); name.append(t.getMinute()); name.append(t.getSecond()); name.append(t.getNano());
    			String realFile = request.getServletContext().getRealPath("/") + "res/common/uploads/articleimage/" + name.toString() + ".jpg";
    			@SuppressWarnings("resource")
				OutputStream output = new FileOutputStream(new File(realFile));
    			output.write(image); 
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	return name.toString() + ".jpg";
	}
	
	//删除标签
	public Res deleteArticle(int id) {
		this.manageDaoImpl.deleteArticle(id);
		
		Res res = new Res();
		res.setMsg("操作成功");
		res.setCode(1);
		return res;
	}
	//获取用户信息
	public void getUserList(Model model) {
		model.addAttribute("userlist", this.manageDaoImpl.getUserList());
		model.addAttribute("usercount", this.manageDaoImpl.findUserCount());
	}
	//修改密码
	public Res changePwd(String name, String password) {
		User u = this.manageDaoImpl.getByName(name);
		u.setPassword(password);
		this.manageDaoImpl.updateUser(u);
		
		Res res = new Res();
		res.setMsg("操作成功");
		res.setCode(3);
		return res;
	}
	
	//删除用户
	public Res deleteUser(String name) {
		this.manageDaoImpl.deleteUserByName(name);
		
		Res res = new Res();
		res.setMsg("操作成功");
		res.setCode(1);
		return res;
	}
	
	//下面的内容是关于群组管理的
	public void getGroups(Model model) {
		model.addAttribute("totalcount", this.manageDaoImpl.findGroupCount());
		model.addAttribute("grouplist", this.manageDaoImpl.getGroupList());
	}
	
	//删除群组
	public Res deleteGroup(int id) {
		this.manageDaoImpl.deleteGroupById(id);
		
		Res res = new Res();
		res.setMsg("操作成功");
		res.setCode(1);
		return res;
	}
	
	//下面是关于微博管理的内容
	public void getWeibos(Model model) {
		model.addAttribute("totalcount", this.manageDaoImpl.findWeiboCount());
		model.addAttribute("weibolist", this.manageDaoImpl.getWeiboList());
	}
	
	//删除微博
	public Res deleteWeibo(int id) {
		this.manageDaoImpl.deleteWeiboById(id);
		
		Res res = new Res();
		res.setMsg("操作成功");
		res.setCode(1);
		return res;
	}
	
	//图片管理
	public void getPictures(Model model) {
		model.addAttribute("totalcount", this.manageDaoImpl.findPictureCount());
		model.addAttribute("pictures", this.manageDaoImpl.getPictureList());
	}
	
	//删除图片
	public Res deletePicture(int id) {
		this.manageDaoImpl.deletePictureById(id);
		
		Res res = new Res();
		res.setMsg("操作成功");
		res.setCode(1);
		return res;
	}
}
