package com.aesopsns.article.dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.aesopsns.entity.article.Article;
import com.aesopsns.entity.article.ArticleCate;
import com.aesopsns.entity.article.ArticleComment;
import com.aesopsns.entity.article.Upvote;
import com.aesopsns.entity.common.Updating;

@Repository("articleDao")
public class ArticleDaoImpl {
	@Resource
	private SessionFactory sessionFactory;
	
	public void saveCate(ArticleCate cate) {
		this.sessionFactory.getCurrentSession().save(cate);
		this.sessionFactory.getCurrentSession().flush();
	}
	public void saveArticle(Article article) {
		//hehe
		if(this.findArticleById(article.getId()) != null) {
			this.updateArticle(article);
		}else {
			this.sessionFactory.getCurrentSession().save(article);
			this.sessionFactory.getCurrentSession().flush();
		}
	}
	@SuppressWarnings("unchecked")
	public List<String> getArticleTitles() {
		String hql = "select title from Article";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		return (List<String>) query.list();
	}
	public Article getArticleByTitle(String title) {
		String hql = "from Article where title=?";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, title);
		return (Article) query.uniqueResult();
	}
	@SuppressWarnings("unchecked")
	public List<String> getArticleTitlesByTag(String catename) {
		String hql = "select title from Article where tag=?";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, catename);
		return (List<String>) query.list();
	}
	@SuppressWarnings("unchecked")
	public List<Article> getArticlesByTitle(String key, int pageNum, int pageSize) {
		String hql = "from Article where title like '%" + key + "%'";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setFirstResult((pageNum-1)*pageSize);
		query.setMaxResults(pageSize);
		return (List<Article>) query.list();
	}
	
	public List<Article> getArticlesByIndex(List<String> result, int pageNum, int pageSize) {
		List<Article> articles = new ArrayList<>();
		for(String content : result) {
			articles.add(this.findArticleByContent(content));
		}
		return articles;
	}
	@SuppressWarnings("unused")
	private Article findArticleByContent(String content) {
		String hql = "from Article where content=?";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, content);
		return (Article) query.uniqueResult();
	}
	
	public long findResultCount(String key) {
		Query query=this.sessionFactory.getCurrentSession().createQuery("select count(*) from Article where title like '%?%'");
		query.setString(0, key);
		return (Long)query.uniqueResult();
	}
	
	public Article findArticleById(int id) {
		Article article = this.sessionFactory.getCurrentSession().get(Article.class, id);
		this.sessionFactory.getCurrentSession().flush();
		return article;
	}
	
	@SuppressWarnings("unchecked")
	public List<ArticleCate> getCates(){
		String hql = "from ArticleCate";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		return (List<ArticleCate>) query.list();
	}
	public String findCateNameById(int cateid) {
		return this.sessionFactory.getCurrentSession().get(ArticleCate.class, cateid).getCatename();
	}
	
	public void deleteAllArticle() {
		String hql = "delete from Article";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.executeUpdate();
	}
	//分页查询
	@SuppressWarnings("unchecked")
	public List<Article> find4Page(int pageNum, int pageSize) throws Exception {
		Query query=this.sessionFactory.getCurrentSession().createQuery("from Article");
		query.setFirstResult((pageNum-1)*pageSize);
		query.setMaxResults(pageSize);
		return (List<Article>) query.list();
	}
	//分页查询(带属性)
	@SuppressWarnings("unchecked")
	public List<Article> find4PageByCatename(int pageNum, int pageSize, String catename) throws Exception {
		Query query=this.sessionFactory.getCurrentSession().createQuery("from Article where tag=?");
		query.setString(0, catename);
		query.setFirstResult((pageNum-1)*pageSize);
		query.setMaxResults(pageSize);
		return (List<Article>) query.list();
	}
	public long findCount() {
		Query query=this.sessionFactory.getCurrentSession().createQuery("select count(*) from Article");
		return (Long)query.uniqueResult();
	}
	public long findCountWithCateName(String catename) {
		Query query=this.sessionFactory.getCurrentSession().createQuery("select count(*) from Article where tag=?");
		query.setString(0, catename);
		return (Long)query.uniqueResult();
	}
	public void updateArticle(Article article) {
		this.sessionFactory.getCurrentSession().update(article);
		this.sessionFactory.getCurrentSession().flush();
	}
	public void deleteUpvote(String mail, int articleid) {
		Query query=this.sessionFactory.getCurrentSession().createQuery("delete from Upvote where mail=? and articleid=?");
		query.setString(0, mail);
		query.setInteger(1, articleid);
		query.executeUpdate();
	}
	public void saveUpvote(Upvote upvote) {
		this.sessionFactory.getCurrentSession().save(upvote);
		this.sessionFactory.getCurrentSession().flush();
	}
	public boolean isUpvoted(String mail, int articleid) {
		Query query=this.sessionFactory.getCurrentSession().createQuery("from Upvote where mail=? and articleid=?");
		query.setString(0, mail);
		query.setInteger(1, articleid);
		
		if(query.uniqueResult() == null) return false;
		return true;
	}
	public void saveArticleComment(ArticleComment ac) {
		this.sessionFactory.getCurrentSession().save(ac);
		this.sessionFactory.getCurrentSession().flush();
	}
	public void deleteComments() {
		String hql = "delete from ArticleComment";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.executeUpdate();
	}
	
	@SuppressWarnings("unchecked")
	public List<ArticleComment> getComments(int articleid){
		Query query=this.sessionFactory.getCurrentSession().createQuery("from ArticleComment where articleid=?");
		query.setInteger(0, articleid);
		return (List<ArticleComment>) query.list();
	}
	
	public void saveUpdating(Updating updating) {
		this.sessionFactory.getCurrentSession().save(updating);
		this.sessionFactory.getCurrentSession().flush();
	}
}
