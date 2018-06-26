package com.aesopsns.manage.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aesopsns.entity.common.Res;
import com.aesopsns.manage.service.ManageServiceImpl;

@Controller
public class GalleryManageController {
	@Resource
	private ManageServiceImpl manageServiceImpl;
	
	//标签管理主页
	@RequestMapping("/tag/list/{id}")
	public String toTagList(@PathVariable int id) {
		return "manage/gallery/tag";
	}
	
	//图片管理主页
	@RequestMapping("/picture/list")
	public String toPictureList(Model model) {
		this.manageServiceImpl.getPictures(model);
		return "manage/gallery/picture";
	}
	
	@RequestMapping("/picture/delete/{id}")
	public @ResponseBody Res deletePicture(@PathVariable int id) {
		return this.manageServiceImpl.deletePicture(id);
	}
}
