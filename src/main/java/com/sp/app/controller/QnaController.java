package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/qna/*")
public class QnaController {
	@RequestMapping(value = "list")
	public String list() {
		return ".qna.list";
	}
}
