package com.aesopsns.album.dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.aesopsns.entity.album.Album;
import com.aesopsns.entity.album.AlbumPicture;
import com.aesopsns.entity.album.PictureComment;
import com.aesopsns.entity.album.PictureUpvote;
import com.aesopsns.entity.common.CommentBean;
import com.aesopsns.entity.common.Member;
import com.aesopsns.entity.user.User;

@Repository("albumDao")
public class AlbumDaoImpl {
	@Resource
	private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	public List<Album> listAlbum(String username){
		String hql = "from Album where username=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, username);
		return (List<Album>) query.list();
	}
	
	public void saveAlbum(Album album) {
		this.sessionFactory.getCurrentSession().save(album);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	public void deleteAlbum(int albumid) {
		String hql = "delete from Album where id=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, albumid);
		query.executeUpdate();
	}
	
	public void deleteAllAlbum() {
		String hql = "delete from Album";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.executeUpdate();
	}
	
	public Album getAlbum(int id) {
		return this.sessionFactory.getCurrentSession().get(Album.class, id);
	}
	
	@SuppressWarnings("unchecked")
	public List<AlbumPicture> getAlbumPictureList(int albumid){
		String hql = "from AlbumPicture where albumid=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, albumid);
		return (List<AlbumPicture>) query.list();
	}
	
	public void updateAlbum(Album album) {
		this.sessionFactory.getCurrentSession().update(album);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	public void saveAlbumPicture(AlbumPicture ap) {
		this.sessionFactory.getCurrentSession().save(ap);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	public void updateAlbumPicture(AlbumPicture ap) {
		this.sessionFactory.getCurrentSession().update(ap);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	public AlbumPicture getAlbumPicture(int id) {
		return this.sessionFactory.getCurrentSession().get(AlbumPicture.class, id);
	}
	
	public boolean isPictureUpvoted(int id, String mail) {
		String hql = "from PictureUpvote where pictureid=? and mail=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, id);
		query.setString(1, mail);
		Object pu = query.uniqueResult();
		if(pu == null)	return false;
		return true;
	}
	public void deletePictureUpvote(int id, String mail) {
		String hql = "delete from PictureUpvote where pictureid=? and mail=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, id);
		query.setString(1, mail);
		query.executeUpdate();
	}
	
	public void savePictureUpload(PictureUpvote pu) {
		this.sessionFactory.getCurrentSession().save(pu);
		this.sessionFactory.getCurrentSession().flush();
	}
	
	public void savePictureComment(PictureComment pc) {
		this.sessionFactory.getCurrentSession().save(pc);
		this.sessionFactory.getCurrentSession().flush();
	}
	//下面是关于评论的了
	public List<CommentBean> getCommentBeanList(int id){
		String hql = "from PictureComment where pictureid=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, id);
		@SuppressWarnings("unchecked")
		List<PictureComment> pclist = (List<PictureComment>) query.list();
		List<CommentBean> cblist = new ArrayList<>();
		for(PictureComment pc : pclist) {
			User u = this.getUserByName(pc.getUsername());
			Member m = new Member();
			if(u.getIcon() == null)	m.setIcon("images/default-avatar.png");
			else	m.setIcon("uploads/" + u.getIcon());
			m.setName(u.getName());
			CommentBean cb = new CommentBean();
			cb.setId(pc.getId());
			cb.setMember(m);
			cb.setContent(pc.getContent());
			cb.setCreatedtime(pc.getCreatedtime());
			cblist.add(cb);
		}
		return cblist;
	}
	public User getUserByName(String username) {
		String hql = "from User Where name=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, username);
		return (User) query.uniqueResult();
	}
	
	
	//把照片删掉的时候，要同时把它的赞和评论都删掉
	public void deleteAlbumsPicture(int albumid) {
		String hql = "from AlbumPicture where albumid=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, albumid);
		@SuppressWarnings("unchecked")
		List<AlbumPicture> aplist = (List<AlbumPicture>) query.list();
		for(AlbumPicture ap : aplist) {
			this.deleteUpvotes(ap.getId());
			this.deleteComments(ap.getId());
			this.deletePictures(ap.getId());
		}
	}
	private void deleteUpvotes(int pictureid) {
		String hql = "delete from PictureUpvote where pictureid=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, pictureid);
		query.executeUpdate();
	}
	private void deleteComments(int pictureid) {
		String hql = "delete from PictureComment where pictureid=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, pictureid);
		query.executeUpdate();
	}
	private void deletePictures(int pictureid) {
		String hql = "delete from AlbumPicture where id=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setInteger(0, pictureid);
		query.executeUpdate();
	}
	
	//以下是涉及到“图库”模块的查询
	public boolean isWeiboAlbumExists(String username) {
		String hql = "from Album where namess=? and username=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, "微博配图");
		query.setString(1, username);
		if(query.uniqueResult() == null)	return false;
		return true;
	}
	public Album getWeiboAlbumByName(String username) {
		String hql = "from Album where namess=? and username=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, "微博配图");
		query.setString(1, username);
		return (Album) query.uniqueResult();
	}
	
	//以下是关于图库的内容
	@SuppressWarnings("unchecked")
	public List<AlbumPicture> find4Page(int pageNum, int pageSize) throws Exception {
		//因为要从最新的开始展示，所以要倒序查呢
		Query query=this.sessionFactory.getCurrentSession().createQuery("from AlbumPicture order by id desc");
		query.setFirstResult((pageNum-1)*pageSize);
		query.setMaxResults(pageSize);
		List<AlbumPicture> aplist = (List<AlbumPicture>) query.list();
		return aplist;
	}
}
