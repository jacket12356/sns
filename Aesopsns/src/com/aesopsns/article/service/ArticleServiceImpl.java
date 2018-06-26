package com.aesopsns.article.service;

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

import com.aesopsns.article.dao.ArticleDaoImpl;
import com.aesopsns.entity.article.Article;
import com.aesopsns.entity.article.ArticleCate;
import com.aesopsns.entity.article.ArticleComment;
import com.aesopsns.entity.article.Upvote;
import com.aesopsns.entity.common.Page;
import com.aesopsns.entity.common.Res;
import com.aesopsns.entity.common.Updating;
import com.aesopsns.entity.user.User;
import com.aesopsns.lucene.IndexSearch;
import com.aesopsns.user.dao.UserDaoImpl;

@Service
public class ArticleServiceImpl {
	@Resource 
	private ArticleDaoImpl articleDaoImpl;
	@Resource
	private UserDaoImpl userDaoImpl;
	
	//在文章列表页列出文章
	public void listArticle(HttpSession session) {
		//因为必须要分页显示，所以下面两行没用了
//		List<Article> list = this.articleDaoImpl.getArticles();
//		session.setAttribute("articlelist", list);
		//session里加一个Page对象
		session.setAttribute("articlepage", new Page(2, this.articleDaoImpl.findCount()));
		//如果想要标签下分页这样的二级操作，果然需要加一个属性
		if(session.getAttribute("catename") != null) 	session.removeAttribute("catename");
	}
	//根据标签id在文章列表页列出文章
	public void listArticleByCatename(HttpSession session, String catename) {
		//因为必须要分页显示，所以下面两行没用了
//		List<Article> list = this.articleDaoImpl.getArticlesByTag(catename);
//		session.setAttribute("articlelist", list);
		//session里加一个Page对象
		session.setAttribute("articlepage", new Page(2, this.articleDaoImpl.findCountWithCateName(catename)));
		//如果想要标签下分页这样的二级操作，果然需要加一个属性
		session.setAttribute("catename", catename);
	}
	//根据页数在文章列表页中列出文章
	public void listArticleByPageNo(HttpSession session, int pageNo, String key) {
		String catename = (String) session.getAttribute("catename");
		Page articlePage = (Page) session.getAttribute("articlepage");
		List<Article> currentPageList = null;
		//查询
		if(key != null) {
			currentPageList = this.search(key, pageNo, articlePage.getPageSize());
			session.setAttribute("articlepage", new Page(2, this.articleDaoImpl.findResultCount(key), pageNo));
			session.setAttribute("currentpagelist", currentPageList);
		}
		//分支出现了在“全部”下分页和在某个标签下分页
		if(catename == null) {
			try {
				//为了能看出分页效果，先弄每页两个吧
				currentPageList = this.articleDaoImpl.find4Page(pageNo, articlePage.getPageSize());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			session.setAttribute("articlepage", new Page(2, this.articleDaoImpl.findCount(), pageNo));
			session.setAttribute("currentpagelist", currentPageList);
		}else {
			try {
				currentPageList = this.articleDaoImpl.find4PageByCatename(pageNo, articlePage.getPageSize(), catename);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			session.setAttribute("articlepage", new Page(2, this.articleDaoImpl.findCountWithCateName(catename), pageNo));
			session.setAttribute("currentpagelist", currentPageList);
		}
	}
	
	private List<Article> search(String key, int pageNo, int pageSize) {
		List<String> result = null;
		if(key.startsWith("full-text:")) {
			//全文检索
			IndexSearch search = new IndexSearch();  
			try {
				result = search.search("姓名");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return this.articleDaoImpl.getArticlesByIndex(result, pageNo, pageSize);
		}
		else {
			//普通标题检索
			return this.articleDaoImpl.getArticlesByTitle(key, pageNo, pageSize);
		}
	}
	
	//发布文章
	public String publishArticle(HttpSession session, MultipartFile file, int cateid, String title,
			String description, String articlecontent, HttpServletRequest request) {
		User u = this.userDaoImpl.getByMail(((User) session.getAttribute("currentuser")).getMail());
		
		//先建一个article对象
		String time = this.getCurrentTime();
		Article article = new Article();
		article.setImage(this.uploadImage(file, request));
		article.setContent(this.uploadContent(articlecontent, request));
		article.setTitle(title);
		article.setDescription(description);
		article.setMail(u.getMail());
		article.setPublisher(u.getName());
		article.setPublishtime(time);
		article.setTag(this.articleDaoImpl.findCateNameById(cateid));
		//一对多
		article.setUser(u);
		u.getArticleSet().add(article);
		//持久化article
		this.articleDaoImpl.saveArticle(article);
		//更新session中的currentuser
		session.setAttribute("currentuser", u);
		//将发布文章这件事更新到动态中
		Updating update = new Updating();
		update.setDetailid(this.articleDaoImpl.getArticleByTitle(article.getTitle()).getId());
		update.setIcon(u.getIcon());
		update.setType(1);
		update.setUpdater(u.getName());
		update.setUpdatetime(this.getCurrentTime2());
		update.setTitle(article.getTitle());
		this.articleDaoImpl.saveUpdating(update);
		
		return "/article/list";
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
	
	//发布文章时，要列出要发布文章所属的标签或者在文章列表页要显示各种标签
	public void listCate(HttpSession session) {
		session.setAttribute("articlecates", this.articleDaoImpl.getCates());
	}
	
	//文章列表页，搜索项智能推荐
	public void generateTitleList(HttpSession session, String catename) {
		if(catename == null) {
			session.setAttribute("titlelist", this.articleDaoImpl.getArticleTitles());
		}else {
			session.setAttribute("titlelist", this.articleDaoImpl.getArticleTitlesByTag(catename));
		}
	}
	
	//获取一个文章对象
	public void getArticle(String id, Model model, HttpServletRequest request) {
		Article article = this.articleDaoImpl.findArticleById(Integer.parseInt(id));
		model.addAttribute("articledetail", article);
		//获取改文章的评论
		model.addAttribute("aclist", this.articleDaoImpl.getComments(article.getId()));
		//从文件系统中获取文章的内容
		model.addAttribute("content", this.readToString(request.getServletContext().getRealPath("/") + "res/common/uploads/articlecontent/" + article.getContent()));
		//文章阅览数加1
		article.setReadcount(article.getReadcount() + 1);
		this.articleDaoImpl.updateArticle(article);
		//作者
		model.addAttribute("publisher", this.userDaoImpl.getByName(article.getPublisher()));
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
	
	//点赞功能
	public Res upvote(String articleid, HttpSession session) {
		User u = (User) session.getAttribute("currentuser");
		Article article = this.articleDaoImpl.findArticleById(Integer.parseInt(articleid));
		Res res = new Res();
		if(u == null) {
			res.setCode(-1);
			res.setMsg("请先登录");
			return res;
		}
		if(this.articleDaoImpl.isUpvoted(u.getMail(), Integer.parseInt(articleid))) {
			this.articleDaoImpl.deleteUpvote(u.getMail(), Integer.parseInt(articleid));
			
			res.setCode(1);
			res.setData(article.getUpvotes() - 1 + "");
			article.setUpvotes(article.getUpvotes() - 1);
			this.articleDaoImpl.updateArticle(article);
		}else {
			Upvote upvote = new Upvote();
			upvote.setArticleid(Integer.parseInt(articleid));
			upvote.setMail(u.getMail());
			this.articleDaoImpl.saveUpvote(upvote);
			
			res.setCode(0);
			res.setData(article.getUpvotes() + 1 + "");
			article.setUpvotes(article.getUpvotes() + 1);
			this.articleDaoImpl.updateArticle(article);
		}
		return res;
	}
	
	//评论功能
	public String comment(int articleid, HttpSession session, String content) {
		User user = (User) session.getAttribute("currentuser");
		if(user == null)	return "front/user/login";
		User u = this.userDaoImpl.getByMail(user.getMail());
		Article article = this.articleDaoImpl.findArticleById(articleid);
		//评论的内容，评论时刻，评论人名
		ArticleComment ac = new ArticleComment();
		ac.setArticleid(article.getId());
		ac.setUsername(u.getName());
		ac.setContent(content);
		ac.setTime(this.getCurrentTime());
		ac.setMail(u.getMail());
		
		//一对多
		ac.setUser(u);
		
		this.articleDaoImpl.saveArticleComment(ac);
		
		return "redirect:/article/detail/" + articleid;
	}
	
	//测试用
	public void addCate() {
		String[] cates = {"Linux", "Oracle", "Mysql", "WEB前端", "Python", "Android", "Java", "程序人生"};
		for(String catestr : cates) {
			ArticleCate cate = new ArticleCate();
			cate.setCatename(catestr);
			this.articleDaoImpl.saveCate(cate);
		}
	}
	
	//测试用
	public void deleteAll() {
//		this.articleDaoImpl.deleteComments();
		this.articleDaoImpl.deleteAllArticle();
	}
}
