package com.aesopsns.album.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aesopsns.album.service.AlbumServiceImpl;
import com.aesopsns.entity.album.PictureBean;

@Controller
public class GalleryController {
	@Resource
	private AlbumServiceImpl albumServiceImpl;
	
	//先把图片列表的第一页内容展示出来
	@RequestMapping("/gallery")
	public String toGallery(Model model) {
		model.addAttribute("aplist", this.albumServiceImpl.showFirstPage());
		
		return "front/album/gallery";
	}
	//之后下拉到底，继续加载下一页的内容
	@RequestMapping("/gallery/indexdata")
	public @ResponseBody List<PictureBean> indexData(@RequestParam int pageNo) {
		return this.albumServiceImpl.indexData(pageNo);
	}
	//图库页面下也有一个点赞功能啊，算了，反正和相册的一样，就用相册的吧
	
}
