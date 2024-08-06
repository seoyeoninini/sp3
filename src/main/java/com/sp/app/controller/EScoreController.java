package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
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
import org.springframework.web.servlet.View;

import com.sp.app.common.MyExcelView;
import com.sp.app.common.MyUtil;
import com.sp.app.domain.Score;
import com.sp.app.pdf.ScorePdfView;
import com.sp.app.service.ScoreService;

@Controller
@RequestMapping("/escore/*")
public class EScoreController {
	@Autowired
	private ScoreService service;

	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private MyExcelView excelView;

	@RequestMapping("list")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "hak") String schType,
			@RequestParam(defaultValue = "") String kwd,
			HttpServletRequest req,
			Model model) throws Exception {

		if (req.getMethod().equalsIgnoreCase("GET")) {
			kwd = URLDecoder.decode(kwd, "utf-8");
		}

		int size = 10;
		int dataCount, total_page;

		Map<String, Object> map = new HashMap<>();
		map.put("schType", schType);
		map.put("kwd", kwd);

		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(dataCount, size);
		if (current_page > total_page) {
			current_page = total_page;
		}

		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("size", size);

		List<Score> list = service.listScore(map);

		String cp = req.getContextPath();
		String listUrl = cp + "/escore/list";

		if (kwd.length() != 0) {
			listUrl += "?schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
		}

		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("schType", schType);
		model.addAttribute("kwd", kwd);

		return "escore/list";
	}

	@GetMapping("insert")
	public String insertForm(Model model) throws Exception {
		model.addAttribute("mode", "insert");
		return "escore/write";
	}

	@PostMapping("insert")
	public String insertSubmit(Score dto, Model model) throws Exception {
		try {
			service.insertScore(dto);
		} catch (DuplicateKeyException e) {
			// 기본키 중복에 의한 제약 조건 위반
			model.addAttribute("msg", "학번 중복으로 등록이 실패했습니다.");
			model.addAttribute("mode", "insert");
			return "escore/write";
		} catch (DataIntegrityViolationException e) {
			// 데이터형식 오류, 참조키, NOT NULL 등의 제약조건 위반
			model.addAttribute("msg", "제약조건 위반으로 등록이 실패했습니다.");
			model.addAttribute("mode", "insert");
			return "escore/write";
		} catch (Exception e) {
			// 기타
			model.addAttribute("msg", "데이터 등록이 실패했습니다.");
			model.addAttribute("mode", "insert");
			return "escore/write";
		}

		return "redirect:/escore/list";
	}

	@GetMapping("update")
	public String updateForm(@RequestParam String hak,
			@RequestParam String page,
			Model model) throws Exception {
		Score dto = service.findById(hak);
		if (dto == null) {
			return "redirect:/escore/list?page=" + page;
		}

		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");

		return "escore/write";
	}

	@PostMapping("update")
	public String updateSubmit(Score dto,
			@RequestParam String page) throws Exception {

		try {
			service.updateScore(dto);
		} catch (Exception e) {
		}

		return "redirect:/escore/list?page=" + page;
	}

	@RequestMapping("delete")
	public String delete(@RequestParam String hak,
			@RequestParam String page) throws Exception {

		try {
			service.deleteScore(hak);
		} catch (Exception e) {
		}

		return "redirect:/escore/list?page=" + page;
	}
	
	// View : 클라이언트에게 던지는것.
	// excel로 다운받기
	@RequestMapping("excel")
	public View excel(Map<String, Object> model) throws Exception {
		List<Score> list = service.listScore();
		String sheetName="성적처리";
		List<String> columnLabels = new ArrayList<String>();
		List<Object[]> columnValues=new ArrayList<Object[]>();
		
		columnLabels.add("학번");
		columnLabels.add("이름");
		columnLabels.add("국어");
		columnLabels.add("영어");
		columnLabels.add("수학");
		columnLabels.add("총점");
		columnLabels.add("평균");
		
		for(Score dto : list) {
			columnValues.add(new Object[]{dto.getHak(), dto.getName(), dto.getKor(), dto.getEng(), dto.getMat(), dto.getTot(), dto.getAve()});
		}
		
		// model.put("filename", "score.xls"); // xlsx 파일을 인식하지 못하면 xls로 다운
		model.put("filename", "score.xlsx"); // 저장할 파일 이름
		model.put("sheetName", sheetName); // 시트이름
		model.put("columnLabels", columnLabels); // 타이틀
		model.put("columnValues", columnValues); // 값
		
		return excelView;  // 엑셀 파일 다운 로드
		// return new MyExcelView();
	}
	
	@RequestMapping("pdf")
	public View pdf(Map<String, Object> model) throws Exception {
		List<Score> list=service.listScore();
		
		List<String> columnLabels = new ArrayList<String>();
		List<Object[]> columnValues=new ArrayList<Object[]>();
		
		columnLabels.add("학번");
		columnLabels.add("이름");
		columnLabels.add("국어");
		columnLabels.add("영어");
		columnLabels.add("수학");
		columnLabels.add("총점");
		columnLabels.add("평균");
		
		for(Score dto : list) {
			columnValues.add(new Object[]{dto.getHak(), dto.getName(), dto.getKor(), dto.getEng(), dto.getMat(), dto.getTot(), dto.getAve()});
		}
		
		model.put("filename", "score.pdf"); // 저장할 파일 이름
		model.put("columnLabels", columnLabels); // 타이틀
		model.put("columnValues", columnValues); // 값
		
		return new ScorePdfView();
	}
	
	@RequestMapping("print")
	public String print(Model model) throws Exception {
		List<Score> list=service.listScore();
		
		model.addAttribute("list", list);
		
		return "escore/print";
	}	
}
