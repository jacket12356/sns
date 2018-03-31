package com.aesopsns.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Index {
	//此为网站入口
	@RequestMapping("index")
	public String index() {
		return "front/index";
	}
}
