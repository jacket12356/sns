package com.aesopsns.entity.weibo;

public class ResponseModel {
	private int code;
    private String message;
    private String url;
	public ResponseModel(int code, String message, String url) {
		super();
		this.code = code;
		this.message = message;
		this.url = url;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
}
