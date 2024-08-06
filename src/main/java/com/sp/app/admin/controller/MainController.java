package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("admin.mainController")
public class MainController {
	@RequestMapping(value = "/admin")
	public String list() {
		return ".admin.main";
	}
}
