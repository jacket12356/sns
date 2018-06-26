package com.aesopsns.user.dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.aesopsns.entity.user.ContactMember;
import com.aesopsns.entity.user.CreditDetail;
import com.aesopsns.entity.user.Follow;
import com.aesopsns.entity.user.FollowBean;
import com.aesopsns.entity.user.PrivateMessage;
import com.aesopsns.entity.user.User;
import com.aesopsns.entity.user.User_detail;

@Repository("userDao")
public class UserDaoImpl {
	@Resource
	private SessionFactory sessionFactory;
	
	public void saveUser(User u) {
		this.sessionFactory.getCurrentSession().save(u);
		this.sessionFactory.getCurrentSession().flush();
	}
	public void saveUser_detail(User_detail ud) {
		this.sessionFactory.getCurrentSession().save(ud);
		this.sessionFactory.getCurrentSession().flush();
	}
	public void saveContactMember(ContactMember cm) {
		this.sessionFactory.getCurrentSession().save(cm);
		this.sessionFactory.getCurrentSession().flush();
	}
	public void savePrivateMessage(PrivateMessage pm) {
		this.sessionFactory.getCurrentSession().save(pm);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	public void updateUser_detail(User_detail ud) {
		this.sessionFactory.getCurrentSession().update(ud);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	public void updateUser(User u) {
		this.sessionFactory.getCurrentSession().update(u);
		this.sessionFactory.getCurrentSession().flush();
	}
	//存积分详情（没想到这个也写到UserDao里来了
	public void saveCreditDetail(CreditDetail cd) {
		this.sessionFactory.getCurrentSession().save(cd);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	//邮箱不能重
	public boolean findByMail(String mail) {
		//这个方法只是用来查Id的
		User u = this.sessionFactory.getCurrentSession().get(User.class, mail);
		if(u == null)	return true;
		return false;
	}
	public User getByMail(String mail) {
		return this.sessionFactory.getCurrentSession().get(User.class, mail);
	}
	public User_detail findDetailByMail(String mail) {
		return this.sessionFactory.getCurrentSession().get(User_detail.class, mail);
	}
	
	//昵称不能重
	public boolean findByName(String name) {
//		User u = this.sessionFactory.getCurrentSession().get(User.class, name);
//		System.out.println("param:"+name);
//		System.out.println("u.name:"+u.getName());
//		if(u == null)	return true;
//		return false;
		
		String hql="from User where name=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, name);
		User u = (User)query.uniqueResult();
		if(u == null)	return true;
		return false;
	}
	public User getByName(String name) {
		String hql="from User where name=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, name);
		User u = (User)query.uniqueResult();
		return u;
	}
	
	//password, 根据用户名查对密码
	public User findByPassword(String password, String account) {
		User u = this.sessionFactory.getCurrentSession().get(User.class, account);
		if(u == null) {
			String hql="from User where name=?";
			Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
			query.setString(0, account);
			u = (User)query.uniqueResult();
		}
		if(u.getPassword().equals(password))	return u;
		return null;
	}
	
	//获取密码
	public String getPassword(String mail) {
		return this.sessionFactory.getCurrentSession().get(User.class, mail).getPassword();
	}
	
	//删除所有用户相关数据
	public void deleteAll() {
		String hql = "delete from User";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.executeUpdate();
		
		String hql2 = "delete from User_detail";
		Query query2=this.sessionFactory.getCurrentSession().createQuery(hql2);
		query2.executeUpdate();
	}
	public void deleteAllContactMember() {
		String hql = "delete from ContactMember";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.executeUpdate();
	}
	public void deleteAllPrivateMessage() {
		String hql = "delete from PrivateMessage";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.executeUpdate();
	}
	
	public boolean isContactMemberExist(String contactmember) {
		String hql="from ContactMember where contactmember=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, contactmember);
		ContactMember cm = (ContactMember) query.uniqueResult();
		if(cm == null)	return false;
		return true;
	}
	
	//获取特定的聊天记录（这个以后要扩展的）
	@SuppressWarnings("unchecked")
	public List<PrivateMessage> findpmRecords(String target){
		//我靠，还不能用逗号
		String hql = "from PrivateMessage where sender=? or target=?";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, target);
		query.setString(1, target);
		return (List<PrivateMessage>) query.list();
	}
	public void saveFollow(Follow follow) {
		this.sessionFactory.getCurrentSession().save(follow);
		this.sessionFactory.getCurrentSession().flush();
	}
	public boolean isFollowed(String u, String other) {
		String hql = "from Follow where follower=? and befollowed=?";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, u);
		query.setString(1, other);
		if(query.uniqueResult() == null)	return false;
		return true;
	}
	public void deleteFollowing(String u, String other) {
		String hql = "delete from Follow where follower=? and befollowed=?";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, u);
		query.setString(1, other);
		query.executeUpdate();
	}
	@SuppressWarnings("unchecked")
	public List<FollowBean> getFollowList(String username){
		String hql = "from Follow where follower=?";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, username);
		List<Follow> followlist = (List<Follow>) query.list();
		List<FollowBean> followbeanlist = new ArrayList<>();
		//封装一下
		for(Follow f : followlist) {
			User u = this.getByMail(f.getBefollowed());
			User_detail ud = this.findDetailByMail(u.getMail());
			FollowBean fb = new FollowBean();
			fb.setFollow(f);
			fb.setUser(u);
			fb.setUd(ud);
			followbeanlist.add(fb);
		}
		return followbeanlist;
	}
	
	@SuppressWarnings("unchecked")
	public List<FollowBean> getFollowerList(String username){
		String hql = "from Follow where befollowed=?";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, username);
		List<Follow> followlist = (List<Follow>) query.list();
		List<FollowBean> followbeanlist = new ArrayList<>();
		//封装一下
		for(Follow f : followlist) {
			User u = this.getByMail(f.getFollower());
			User_detail ud = this.findDetailByMail(u.getMail());
			FollowBean fb = new FollowBean();
			fb.setFollow(f);
			fb.setUser(u);
			fb.setUd(ud);
			followbeanlist.add(fb);
		}
		return followbeanlist;
	}
}
