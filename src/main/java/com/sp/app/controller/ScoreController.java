package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.MyUtil;
import com.sp.app.domain.Score;
import com.sp.app.service.ScoreService;

@Controller
@RequestMapping("/score/*")
public class ScoreController {
	@Autowired
	private ScoreService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("list") // GET, POST 모두 처리
	public String list(
			@RequestParam(name="page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "hak") String schType,
			@RequestParam(name="kwd", defaultValue = "") String kwd,
			HttpServletRequest req,
			Model model) throws Exception {
		
		if(req.getMethod().equals("GET")) {
			kwd = URLDecoder.decode(kwd, "UTF-8");
		}
		
		int size = 10;
		int dataCount, total_page;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("schType", schType);
		map.put("kwd", kwd);
		
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(dataCount, size);
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("size", size);
		
		List<Score> list = service.listScore(map);
		
		String cp = req.getContextPath();
		String listUrl = cp + "/score/list";
		
		if(kwd.length() != 0) {
			listUrl += "?schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		// 포워딩할 JSP에 전달할 모델
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("schType", schType);
		model.addAttribute("kwd", kwd);
		
		return "score/list";
	}
	
	@GetMapping("write")
	public String scoreForm(Model model) throws Exception {
		
		model.addAttribute("mode", "write");
		
		return "score/write";
	}
	
	@PostMapping("write")
	public String scoreSubmit(Score dto, Model model) throws Exception {
		
		try {
			service.insertScore(dto);
		} catch (DuplicateKeyException e) {
			// 기본키 중복에 의한 제약 위반
			model.addAttribute("message", "학번중복으로 등록이 실패 했습니다.");
			model.addAttribute("mode", "write");
			return "score/write";
		} catch (DataIntegrityViolationException e) {
			// 데이터 형식 오류, 참조키, NOT NULL 등의 제약 조건 위반
			model.addAttribute("message", "제약조건 위반으로 등록이 실패 했습니다.");
			model.addAttribute("mode", "write");
			return "score/write";
		} catch (Exception e) {
			// 기타
			model.addAttribute("message", "등록이 실패 했습니다.");
			model.addAttribute("mode", "write");
			return "score/write";
		}
		
		return "redirect:/score/list";
	}
	
	@GetMapping("delete")
	public String delete(@RequestParam String hak, @RequestParam String page) throws Exception {
		
		try {
			service.deleteScore(hak);
		} catch (Exception e) {
		}
		return "redirect:/score/list?page="+page;
	}
	
	// 요청파라미터를 List로 받기 위해서는 @RequestParam이 필수
	@PostMapping("deleteList")
	public String deleteList(@RequestParam List<String> haks, @RequestParam String page) throws Exception {
		try {
			service.deleteScore(haks);
		} catch (Exception e) {
			
		}
		
		return "redirect:/score/list?page=" + page;
	}
	
	@GetMapping("update")
	public String updateForm(@RequestParam String hak, @RequestParam String page, Model model) throws Exception {
		
		Score dto = service.findById(hak);
		if(dto == null) {
			return "redirect:/score/list?page=" + page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		
		return "score/write";
	}
	
	@PostMapping("update")
	public String updateSubmit(Score dto, @RequestParam String page) throws Exception {
		
		try {
			service.updateScore(dto);
		} catch (Exception e) {
		}
		return "redirect:/score/list?page=" + page;
	}
}
