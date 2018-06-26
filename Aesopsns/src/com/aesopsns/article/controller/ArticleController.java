package com.aesopsns.article.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aesopsns.article.service.ArticleServiceImpl;
import com.aesopsns.entity.common.Page;
import com.aesopsns.entity.common.Res;
import com.aesopsns.lucene.CreateIndex;

@Controller
@RequestMapping("/article")
public class ArticleController {
	@Resource
	private ArticleServiceImpl articleServiceImpl;
	
	static {
		CreateIndex.initIndex();
	}
	
	//这个文章列表功能涉及到了按标签显示和分页
	@RequestMapping("/list")
	public String toArticleList(HttpSession session,
			@RequestParam(value="catename", required=false) String catename,
			@RequestParam(value="pageNo", required=false) String pageNo,
			@RequestParam(value="key", required=false) String key) {
		//列出标签
		this.articleServiceImpl.listCate(session);
		//列出文章
		if(catename != null)	this.articleServiceImpl.listArticleByCatename(session, catename);
		else	this.articleServiceImpl.listArticle(session);
		//搜索项智能推荐
		if(catename != null)	this.articleServiceImpl.generateTitleList(session, catename);
		else	this.articleServiceImpl.generateTitleList(session, null);
		
		Page articlePage = (Page) session.getAttribute("articlepage");
		
		//如果是查询的话，就列出搜索结果
		if(key != null) {
			this.articleServiceImpl.listArticleByPageNo(session, articlePage.getCurrentPage(), key);
			return "front/article/articlelist";
		}
		
		if(pageNo == null) {
			this.articleServiceImpl.listArticleByPageNo(session, articlePage.getCurrentPage(), null);
		}else {
			this.articleServiceImpl.listArticleByPageNo(session, Integer.parseInt(pageNo), null);
		}
		
		return "front/article/articlelist";
	}
	//测试用
	@RequestMapping("/full")
	public String toFullExample() {
		return "front/article/EditormdExample";
	}
	//测试用
	@RequestMapping("/addcate")
	public void addCate() {
		this.articleServiceImpl.addCate();
	}
	@RequestMapping("/deleteall")
	public void deleteall() {
		this.articleServiceImpl.deleteAll();
	}
	//转到文章发布页面
	@RequestMapping("/publish")
	public String toPublish(HttpSession session) {
		//跳转分支
		if(session.getAttribute("currentuser") == null) {
			return "front/user/login";
		}
		//列出标签
		this.articleServiceImpl.listCate(session);
		
		return "front/article/publish";
	}
	//发布文章
	@RequestMapping("/save")
	public String saveArticle(HttpSession session, @RequestParam("upload") MultipartFile file,
			@RequestParam int cateId, @RequestParam String title, @RequestParam String description,
			@RequestParam String articlecontent, HttpServletRequest request, HttpServletResponse response) {
		String path = this.articleServiceImpl.publishArticle(session, file, cateId, title, description, articlecontent, request);
		//列出文章，因为有新更新的
		this.articleServiceImpl.listArticle(session);
		//因为文章增加了，所以要重新索引
		CreateIndex.initIndex();
		
		return "redirect:" + path;
	}
	
	//上传缩略图
	@RequestMapping("/uploadimage")
	public @ResponseBody String uploadImage(@RequestParam("upload") MultipartFile file, HttpServletRequest request){
		return this.articleServiceImpl.uploadImage(file, request);
	}
	
	//转到文章发布页面
	@RequestMapping("/detail/{articleid}")
	public String toArticleDetail(@PathVariable String articleid, Model model, HttpServletRequest request) {
		this.articleServiceImpl.getArticle(articleid, model, request);
		
		return "front/article/detail";
	}
	//文章点赞
	@RequestMapping("/upvote/{id}")
	public @ResponseBody Res upvote(@PathVariable String id, HttpSession session){
		return this.articleServiceImpl.upvote(id, session);
	}
	//文章点评
	@RequestMapping("/comment/{id}")
	public String comment(@PathVariable String id, @RequestParam String content, HttpSession session) {
		int articleid = Integer.parseInt(id);
		
		return this.articleServiceImpl.comment(articleid, session, content);
	}
	
	//文章全文检索功能
//	public @ResponseBody void fullTextSearch() {
//		IndexSearch search = new IndexSearch();  
//        try {
//			search.search("姓名");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}  
//	}
}
