package com.aesopsns.weibo.dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.aesopsns.entity.common.CommentBean;
import com.aesopsns.entity.common.CommentData;
import com.aesopsns.entity.common.Member;
import com.aesopsns.entity.common.Updating;
import com.aesopsns.entity.user.User;
import com.aesopsns.entity.weibo.Weibo;
import com.aesopsns.entity.weibo.WeiboBean;
import com.aesopsns.entity.weibo.WeiboComment;
import com.aesopsns.entity.weibo.WeiboUpvote;

@Repository("weiboDao")
public class WeiboDaoImpl {
	@Resource
	private SessionFactory sessionFactory;
	
	public void saveWeibo(Weibo w) {
		this.sessionFactory.getCurrentSession().save(w);
		this.sessionFactory.getCurrentSession().flush();
	}
	public Weibo getWeibo(int id) {
		return this.sessionFactory.getCurrentSession().get(Weibo.class, id);
	}
	public void updateWeibo(Weibo w) {
		this.sessionFactory.getCurrentSession().update(w);
		this.sessionFactory.getCurrentSession().flush();
	}
	public WeiboBean getWeiboBean(int id) {
		WeiboBean wb = new WeiboBean();
		Weibo w = this.sessionFactory.getCurrentSession().get(Weibo.class, id);
		wb.setW(w);
		wb.setU(this.getUserByName(w.getPublisher()));
		wb.setImages(w.getPictures().split("\\,"));
		return wb;
	}
	@SuppressWarnings("unchecked")
	public List<WeiboBean> find4Page(int pageNum, int pageSize) throws Exception {
		//因为要从最新的开始展示，所以要倒序查呢
		Query query=this.sessionFactory.getCurrentSession().createQuery("from Weibo order by id desc");
		query.setFirstResult((pageNum-1)*pageSize);
		query.setMaxResults(pageSize);
		List<Weibo> wlist = (List<Weibo>) query.list();
		List<WeiboBean> wblist = new ArrayList<>();
		for(Weibo w : wlist) {
			WeiboBean wb = new WeiboBean();
			wb.setW(w);
			wb.setU(this.getUserByName(w.getPublisher()));
			wb.setImages(w.getPictures().split("\\,"));
			wblist.add(wb);
		}
		return wblist;
	}
	private User getUserByName(String name) {
		String hql="from User where name=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, name);
		return (User)query.uniqueResult();
	}
	public long findCount() {
		Query query=this.sessionFactory.getCurrentSession().createQuery("select count(*) from Weibo");
		return (Long)query.uniqueResult();
	}
	public void delete() {
		String hql = "delete from Weibo";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.executeUpdate();
	}
	
	//下面是关于微博点赞用到的查询
	public boolean isWeiboUpvoted(String mail, int weiboid) {
		String hql = "from WeiboUpvote where mail=? and weiboid=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, mail);
		query.setInteger(1, weiboid);
		if(query.uniqueResult() != null)	return true;
		return false;
	}
	public void saveWeiboUpvote(WeiboUpvote wu) {
		this.sessionFactory.getCurrentSession().save(wu);
		this.sessionFactory.getCurrentSession().flush();
	}
	public void deleteWeiboUpvote(String mail, int weiboid) {
		String hql = "delete from WeiboUpvote where mail=? and weiboid=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, mail);
		query.setInteger(1, weiboid);
		query.executeUpdate();
	}
	//下面是关于微博评论的查询
	public void saveWeiboComment(WeiboComment wb) {
		this.sessionFactory.getCurrentSession().save(wb);
		this.sessionFactory.getCurrentSession().flush();
	}
	public WeiboComment getWeiboComment(int id) {
		return this.sessionFactory.getCurrentSession().get(WeiboComment.class, id);
	}
	public List<CommentData> getWeiboComments(int weiboid) {
		String hql = "from WeiboComment where weiboid=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, weiboid);
		@SuppressWarnings("unchecked")
		List<WeiboComment> wclist = (List<WeiboComment>) query.list();
		//上面是第一层
		List<CommentData> cdlist = new ArrayList<>();
		for(WeiboComment wc : wclist) {
			CommentData cd = new CommentData();
			cd.setId(wc.getId());
			cd.setCreatedtime(wc.getCreatedtime());
			cd.setContent(wc.getContent());
			User u = this.getUserByName(wc.getUsername());
			Member m = new Member();
			if(u.getIcon() == null) {
				m.setIcon("default-avatar.png");
			}else {
				m.setIcon(u.getIcon());
			}
			m.setName(u.getName());
			cd.setMember(m);
			//如果该评论引用了某评论的话
			if(wc.getCited() == 1) {
				CommentBean cb = new CommentBean();
				WeiboComment comment = this.getWeiboComment(wc.getCitedcommemtid());
				cb.setId(comment.getId());
				cb.setCreatedtime(comment.getCreatedtime());
				cb.setContent(comment.getContent());
				User uu = this.getUserByName(comment.getUsername());
				Member mm = new Member();
				if(uu.getIcon() == null) {
					mm.setIcon("default-avatar.png");
				}else {
					mm.setIcon(uu.getIcon());
				}
				mm.setName(uu.getName());
				cb.setMember(mm);
				cd.setWeiboComment(cb);
				//上面是第二层
			}
			//上面是第三层
			cdlist.add(cd);
		}
		return cdlist;
	}
	public void saveUpdating(Updating updating) {
		this.sessionFactory.getCurrentSession().save(updating);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	public Weibo getWeiboByTime(String pictures) {
		String hql = "from Weibo where publishtime=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, pictures);
		return (Weibo) query.uniqueResult();
	}
}
