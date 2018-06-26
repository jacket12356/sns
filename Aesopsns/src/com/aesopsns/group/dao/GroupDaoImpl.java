package com.aesopsns.group.dao;

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
import com.aesopsns.entity.group.Group;
import com.aesopsns.entity.group.GroupFollow;
import com.aesopsns.entity.group.Post;
import com.aesopsns.entity.group.PostComment;
import com.aesopsns.entity.user.User;

@Repository("groupDao")
public class GroupDaoImpl {
	@Resource
	private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	public List<Group> getGrouplist(){
		String hql = "from Group";
		Query query = this.sessionFactory.getCurrentSession().createQuery(hql);
		return (List<Group>) query.list();
	}
	
	public void saveGroup(Group group) {
		this.sessionFactory.getCurrentSession().save(group);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	public Group getGroup(int id) {
		return this.sessionFactory.getCurrentSession().get(Group.class, id);
	}
	
	public Group findGroupById(int id) {
		return this.sessionFactory.getCurrentSession().get(Group.class, id);
	}
	
	public User getUserByName(String username) {
		String hql = "from User Where name=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, username);
		return (User) query.uniqueResult();
	}
	
	public void saveGroupFollow(GroupFollow gf) {
		this.sessionFactory.getCurrentSession().save(gf);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	@SuppressWarnings("unchecked")
	public List<GroupFollow> getGroupFollowList(int groupid){
		String hql = "from GroupFollow where groupid=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, groupid);
		return (List<GroupFollow>) query.list();
	}
	
	public boolean isGroupFollowed(int groupid, String follower) {
		String hql = "from GroupFollow where groupid=? and follower=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, groupid);
		query.setString(1, follower);
		if(query.uniqueResult() == null)	return false;
		return true;
	}
	
	public void updateGroup(Group group) {
		this.sessionFactory.getCurrentSession().update(group);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	public void deleteGroupFollow(int groupid, String follower) {
		String hql = "delete from GroupFollow where groupid=? and follower=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, groupid);
		query.setString(1, follower);
		query.executeUpdate();
	}
	
	public void savePost(Post post) {
		this.sessionFactory.getCurrentSession().save(post);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	@SuppressWarnings("unchecked")
	public List<Post> getPostList(int groupid) {
		String hql = "from Post where groupid=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, groupid);
		return query.list();
	}
	
	public Post getPost(String contentname) {
		String hql = "from Post where content=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, contentname);
		return (Post) query.uniqueResult();
	}
	
	public Post getPostById(int id) {
		return this.sessionFactory.getCurrentSession().get(Post.class, id);
	}
	
	public void updatePost(Post post) {
		this.sessionFactory.getCurrentSession().update(post);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	//分页
	public long findCount(int groupid) {
		String hql = "select count(*) from Post where groupid=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, groupid);
		return (Long)query.uniqueResult();
	}
//	public List<WeiboBean> find4Page(int pageNum, int pageSize) throws Exception {
//	//因为要从最新的开始展示，所以要倒序查呢
//	Query query=this.sessionFactory.getCurrentSession().createQuery("from Weibo order by id desc");
//	query.setFirstResult((pageNum-1)*pageSize);
//	query.setMaxResults(pageSize);
//	List<Weibo> wlist = (List<Weibo>) query.list();
//	List<WeiboBean> wblist = new ArrayList<>();
//	for(Weibo w : wlist) {
//		WeiboBean wb = new WeiboBean();
//		wb.setW(w);
//		wb.setU(this.getUserByName(w.getPublisher()));
//		wb.setImages(w.getPictures().split("\\,"));
//		wblist.add(wb);
//	}
//	return wblist;
//}
	@SuppressWarnings("unchecked")
	public List<Post> find4Page(int pageNum, int pageSize, int groupid) {
		Query query=this.sessionFactory.getCurrentSession().createQuery("from Post where groupid=? order by id desc");
		query.setInteger(0, groupid);
		query.setFirstResult((pageNum-1)*pageSize);
		query.setMaxResults(pageSize);
		return (List<Post>) query.list();
	}
	
	//评论
	public void savePostComment(PostComment postComment) {
		this.sessionFactory.getCurrentSession().save(postComment);
		this.sessionFactory.getCurrentSession().flush();
	}
	
//	@SuppressWarnings("unchecked")
//	public List<PostComment> getPostComments(int postid){
//		String hql = "from PostComment where postid=?";
//		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
//		query.setInteger(0, postid);
//		return (List<PostComment>) query.list();
//	}
	
	public PostComment getPostComment(int commentid) {
		return this.sessionFactory.getCurrentSession().get(PostComment.class, commentid);
	}
	
	public List<CommentData> getPostComments(int postid) {
		String hql = "from PostComment where postid=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, postid);
		@SuppressWarnings("unchecked")
		List<PostComment> wclist = (List<PostComment>) query.list();
		//上面是第一层
		List<CommentData> cdlist = new ArrayList<>();
		for(PostComment wc : wclist) {
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
				PostComment comment = this.getPostComment(wc.getCitedcommemtid());
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
	
	//测试
	public void deleteAll() {
		String hql = "delete from Post";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.executeUpdate();
	}
}
