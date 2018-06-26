package com.aesopsns.manage.dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.aesopsns.entity.album.AlbumPicture;
import com.aesopsns.entity.article.Article;
import com.aesopsns.entity.article.ArticleCate;
import com.aesopsns.entity.common.CommonUser;
import com.aesopsns.entity.group.Group;
import com.aesopsns.entity.manage.ManageUser;
import com.aesopsns.entity.user.User;
import com.aesopsns.entity.user.User_detail;
import com.aesopsns.entity.weibo.Weibo;

@Repository("manageDao")
public class ManageDaoImpl {
	@Resource
	private SessionFactory sessionFactory;
	
	public ManageUser getMu(String username) {
		return this.sessionFactory.getCurrentSession().get(ManageUser.class, username);
	}
	
	//文章管理部分
	@SuppressWarnings("unchecked")
	public List<ArticleCate> getCateList(){
		String hql = "from ArticleCate";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		return (List<ArticleCate>) query.list();
	}
	
	public void saveCate(ArticleCate cate) {
		this.sessionFactory.getCurrentSession().save(cate);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	public ArticleCate getCate(int cateid) {
		return this.sessionFactory.getCurrentSession().get(ArticleCate.class, cateid);
	}
	
	public void updateCate(ArticleCate cate) {
		this.sessionFactory.getCurrentSession().update(cate);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	public void deleteCate(int cateid) {
		String hql = "delete from ArticleCate where cateid=?";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, cateid);
		query.executeUpdate();
	}
	
	public long findArticleCount() {
		Query query=this.sessionFactory.getCurrentSession().createQuery("select count(*) from Article");
		return (Long)query.uniqueResult();
	}
	public long findCountWithCateName(String catename) {
		Query query=this.sessionFactory.getCurrentSession().createQuery("select count(*) from Article where tag=?");
		query.setString(0, catename);
		return (Long)query.uniqueResult();
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
	@SuppressWarnings("unchecked")
	public List<Article> getArticlesByTitle(String key, int pageNum, int pageSize) {
		String hql = "from Article where title like '%" + key + "%'";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setFirstResult((pageNum-1)*pageSize);
		query.setMaxResults(pageSize);
		return (List<Article>) query.list();
	}
	public long findResultCount(String key) {
		Query query=this.sessionFactory.getCurrentSession().createQuery("select count(*) from Article where title like '%" + key + "%'");
		return (Long)query.uniqueResult();
	}
	
	public Article findArticleById(int id) {
		Article article = this.sessionFactory.getCurrentSession().get(Article.class, id);
		this.sessionFactory.getCurrentSession().flush();
		return article;
	}
	public String findCateNameById(int cateid) {
		return this.sessionFactory.getCurrentSession().get(ArticleCate.class, cateid).getCatename();
	}
	public void updateArticle(Article article) {
		this.sessionFactory.getCurrentSession().update(article);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	public void deleteArticle(int id) {
		String hql = "delete from Article where id=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, id);
		query.executeUpdate();
	}
	
	@SuppressWarnings("unchecked")
	public List<CommonUser> getUserList() {
		List<CommonUser> culist = new ArrayList<>();
		String hql = "from User";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		List<User> list = (List<User>) query.list();
		for(User u : list) {
			User_detail ud = this.getUd(u.getMail());
			CommonUser cu = new CommonUser();
			cu.setName(u.getName());
			cu.setEmail(u.getMail());
			cu.setPassword(u.getPassword());
			cu.setJointime(ud.getJoin_time());
			cu.setRecentlogin(ud.getRecent_login());
			culist.add(cu);
		}
		return culist;
	}
	private User_detail getUd(String email) {
		return this.sessionFactory.getCurrentSession().get(User_detail.class, email);
	}
	
	public User getByName(String name) {
		String hql="from User where name=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, name);
		User u = (User)query.uniqueResult();
		return u;
	}
	public void updateUser(User u) {
		this.sessionFactory.getCurrentSession().update(u);
		this.sessionFactory.getCurrentSession().flush();
	}
	public void deleteUserByName(String name) {
		String hql = "delete from User where name=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, name);
		query.executeUpdate();
		
		String hql2 = "delete from User_detail mail=?";
		Query query2=this.sessionFactory.getCurrentSession().createQuery(hql2);
		query.setString(0, this.getByName(name).getMail());
		query2.executeUpdate();
	}
	public long findUserCount() {
		Query query=this.sessionFactory.getCurrentSession().createQuery("select count(*) from User");
		return (Long)query.uniqueResult();
	}
	
	public long findGroupCount() {
		Query query=this.sessionFactory.getCurrentSession().createQuery("select count(*) from Group");
		return (Long)query.uniqueResult();
	}
	
	@SuppressWarnings("unchecked")
	public List<Group> getGroupList(){
		String hql = "from Group";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		return (List<Group>) query.list();
	}
	
	public void deleteGroupById(int id) {
		String hql = "delete from Group where id=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, id);
		query.executeUpdate();
	}
	
	public long findWeiboCount() {
		Query query=this.sessionFactory.getCurrentSession().createQuery("select count(*) from Weibo");
		return (Long)query.uniqueResult();
	}
	
	@SuppressWarnings("unchecked")
	public List<Weibo> getWeiboList(){
		String hql = "from Weibo";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		return (List<Weibo>) query.list();
	}
	
	public void deleteWeiboById(int id) {
		String hql = "delete from Weibo where id=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, id);
		query.executeUpdate();
	}
	
	public long findPictureCount() {
		Query query=this.sessionFactory.getCurrentSession().createQuery("select count(*) from AlbumPicture");
		return (Long)query.uniqueResult();
	}
	
	@SuppressWarnings("unchecked")
	public List<AlbumPicture> getPictureList() {
		//因为要从最新的开始展示，所以要倒序查呢
		Query query=this.sessionFactory.getCurrentSession().createQuery("from AlbumPicture order by id desc");
		List<AlbumPicture> aplist = (List<AlbumPicture>) query.list();
		return aplist;
	}
	
	public void deletePictureById(int id) {
		String hql = "delete from AlbumPicture where id=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, id);
		query.executeUpdate();
	}
}
