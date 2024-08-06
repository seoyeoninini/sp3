package com.sp.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.domain.Demo;
import com.sp.app.service.DemoService;


@Controller
@RequestMapping("/demo/*")
public class DemoController {
	@Autowired
	private DemoService service;
	
	@GetMapping("write")
	public String writeForm() {
		return "demo/write";
	}
	
	@PostMapping("write")
	public String writeSubmit(Demo dto, Model model) {
		try {
			service.insertDemo(dto);
			
			model.addAttribute("msg", "등록 성공!!");
		} catch (Exception e) {
			model.addAttribute("msg", "등록 실패ㅠㅠ");
		}
		
		return "demo/result";
	}
	
	
}
