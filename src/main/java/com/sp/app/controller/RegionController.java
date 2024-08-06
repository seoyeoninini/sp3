package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.domain.Region;
import com.sp.app.service.RegionService;

@Controller
@RequestMapping("/maps/*")
public class RegionController {
	@Autowired
	private RegionService service;
	
	@RequestMapping("main")
	public String main() {
		return "kakaoMap/main";
	}

	@GetMapping("regions")
	@ResponseBody
	public Map<String, Object> regions(
			@RequestParam(defaultValue = "") String keyword
			) throws Exception {

		// 지도를 표시할 리전
		List<Region> list = null;
		
		if(keyword.length() == 0) {
			list = service.listRegion();
		} else {
			list = service.listRegion(keyword);
		}

		Map<String, Object> model = new HashMap<String, Object>();

		model.put("list", list);
		
		return model;
	}	

	@GetMapping("map1")
	public String map1() throws Exception {
		// 간단한 지도 만들기 및 마커 찍기
		return "kakaoMap/map1";
	}
	
	@GetMapping("map2")
	public String map2() throws Exception {
		// 클릭한 위치에 마커 찍기
		return "kakaoMap/map2";
	}
	
	@GetMapping("map3")
	public String map3(Model model) throws Exception {
		// 여러개 마커 및 이벤트 등록
		
		model.addAttribute("latitude", 37.557714093880406); // 래터튜드(위도)
		model.addAttribute("longitude", 126.92450981105797); //  란저튜드(경도)
		
		return "kakaoMap/map3";
	}	

	@GetMapping("map4")
	public String map4(Model model) throws Exception {
		// 여러개 마커 및 이벤트 등록
		
		model.addAttribute("latitude", 37.557714093880406);
		model.addAttribute("longitude", 126.92450981105797);
		
		return "kakaoMap/map4";
	}	
	
	@GetMapping("map5")
	public String map5(Model model) throws Exception {
		// 커스텀 오버레이
		
		return "kakaoMap/map5";
	}	

	@GetMapping("map6")
	public String map6(Model model) throws Exception {
		// 주소로 장소 표시
		
		return "kakaoMap/map6";
	}	

	@GetMapping("map7")
	public String map7(Model model) throws Exception {
		// 주소로 장소 표시 - 커스텀 오버레이
		
		return "kakaoMap/map7";
	}	

	@GetMapping("map8")
	public String map8(Model model) throws Exception {
		// 검색
		return "kakaoMap/map8";
	}	

	@GetMapping("map9")
	public String map9(Model model) throws Exception {
		// 카카오 키워드 검색
		return "kakaoMap/map9";
	}	
}
