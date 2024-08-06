package com.sp.app.msg;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("msg.messageController")
@RequestMapping("/msg/*")
public class MessageController {
	
	@RequestMapping("main")
	public String  main(
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		String wsURL = "ws://"+req.getServerName()+":"+req.getServerPort()+cp+"/ws";
		model.addAttribute("wsURL", wsURL);
		
		return "msg/main";
	}
	
}
