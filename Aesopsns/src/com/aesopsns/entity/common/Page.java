package com.aesopsns.entity.common;

//分页对象
public class Page {
	private int currentPage;		//当前页码
	private int pageCount;			//总页数
	private int pageSize;			//每页拥有的文章条数
	private long totalCount;		//文章总数
	public Page(int pageSize, long totalCount) {
		super();
		this.currentPage = 1;
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		if(this.totalCount % this.pageSize != 0)	this.pageCount = (int) (this.totalCount / this.pageSize) + 1;
		else	this.pageCount = (int) (this.totalCount / this.pageSize);
	}
	public Page(int pageSize, long totalCount, int currentPage) {
		super();
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		if(this.totalCount % this.pageSize != 0)	this.pageCount = (int) (this.totalCount / this.pageSize) + 1;
		else	this.pageCount = (int) (this.totalCount / this.pageSize);
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public long getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(long totalCount) {
		this.totalCount = totalCount;
	}
}
