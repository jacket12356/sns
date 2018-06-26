package com.aesopsns.updating.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.aesopsns.entity.common.Updating;

@Repository("updatingDao")
public class UpdatingDaoImpl {
	@Resource
	private SessionFactory sessionFactory;
	
	public long findCount() {
		Query query=this.sessionFactory.getCurrentSession().createQuery("select count(*) from Updating");
		return (Long)query.uniqueResult();
	}
	
	@SuppressWarnings("unchecked")
	public List<Updating> find4Page(int pageNum, int pageSize) throws Exception {
		//因为要从最新的开始展示，所以要倒序查呢
		Query query=this.sessionFactory.getCurrentSession().createQuery("from Updating order by id desc");
		query.setFirstResult((pageNum-1)*pageSize);
		query.setMaxResults(pageSize);
		List<Updating> wlist = (List<Updating>) query.list();
		return wlist;
	}
	
	@SuppressWarnings("unchecked")
	public List<Updating> getUpdatingsByUpdater(String name) {
		String hql = "from Updating where updater=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, name);
		return (List<Updating>) query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Updating> getUpdatingsByUpdaterAndType(String name, String type) {
		String hql = "from Updating where updater=? and type=?";
		Query query=this.sessionFactory.getCurrentSession().createQuery(hql);
		query.setString(0, name);
		query.setInteger(1, Integer.parseInt(type));
		return (List<Updating>) query.list();
	}
}
