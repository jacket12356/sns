package com.aesopsns.manage.controller;

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

import com.aesopsns.entity.common.Page;
import com.aesopsns.entity.common.Res;
import com.aesopsns.manage.service.ManageServiceImpl;

@Controller
@RequestMapping("/cms")
public class CmsController {
	@Resource
	private ManageServiceImpl manageServiceImpl;
	
	//栏目管理主页
	@RequestMapping("/articleCate/list")
	public String articleCate(Model model) {
		this.manageServiceImpl.listCate(model);
		return "manage/cms/cate";
	}
	
	//弹窗：增加栏目
	@RequestMapping("/articleCate/add")
	public String toAddCate() {
		return "manage/cms/addcate";
	}
	
	//增加栏目处理
	@RequestMapping("/articleCate/save")
	public @ResponseBody Res addCate(@RequestParam String catename) {
		return this.manageServiceImpl.addCate(catename);
	}
	
	//弹窗：编辑栏目
	@RequestMapping("articleCate/edit/{cateid}")
	public String toEditCate(@PathVariable int cateid, Model model) {
		this.manageServiceImpl.toEditCate(cateid, model);
		return "manage/cms/editcate";
	}
	
	//编辑栏目
	@RequestMapping("/articleCate/update")
	public @ResponseBody Res toUpdateCate(@RequestParam int cateid, @RequestParam String catename) {
		return this.manageServiceImpl.updateCate(cateid, catename);
	}
	
	//删除栏目
	@RequestMapping("articleCate/delete/{cateid}")
	public @ResponseBody Res deleteCate(@PathVariable int cateid) {
		return this.manageServiceImpl.deleteCate(cateid);
	}
	
	//文章管理主页
	@RequestMapping("/index")
	public String toArticleList(HttpSession session,
			@RequestParam(value="catename", required=false) String catename,
			@RequestParam(value="pageNo", required=false) String pageNo,
			@RequestParam(value="key", required=false) String key) {
		//列出标签
		this.manageServiceImpl.listcate(session);
		//列出文章
		if(catename != null)	this.manageServiceImpl.listArticleByCatename(session, catename);
		else	this.manageServiceImpl.listArticle(session);
		
		Page articlePage = (Page) session.getAttribute("articlepage");
		
		//如果是查询的话，就列出搜索结果
		if(key != null) {
			this.manageServiceImpl.listArticleByPageNo(session, articlePage.getCurrentPage(), key);
			return "manage/cms/article";
		}
		
		if(pageNo == null) {
			this.manageServiceImpl.listArticleByPageNo(session, articlePage.getCurrentPage(), null);
		}else {
			this.manageServiceImpl.listArticleByPageNo(session, Integer.parseInt(pageNo), null);
		}
		
		return "manage/cms/article";
	}
	
	//文章信息修改页面
	@RequestMapping("/article/edit/{id}")
	public String toEditArticle(@PathVariable int id, Model model, HttpServletRequest request) {
		this.manageServiceImpl.editArticle(id, model, request);
		return "manage/cms/editarticle";
	}
	
	//文章信息修改
	@RequestMapping("/article/update/{id}")
	public @ResponseBody Res saveArticle(HttpSession session, @RequestParam(value="upload", required=false) MultipartFile file, @PathVariable int id,
			@RequestParam int cateId, @RequestParam String title, @RequestParam String description,
			@RequestParam String articlecontent, HttpServletRequest request, HttpServletResponse response) {
		return this.manageServiceImpl.publishArticle(session, file, cateId, title, description, articlecontent, request, id);
	}
	
	//删除文章
	@RequestMapping("/article/delete/{id}")
	public @ResponseBody Res deleteArticle(@PathVariable int id) {
		return this.manageServiceImpl.deleteArticle(id);
	}
}
