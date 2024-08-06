package com.sp.app.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.domain.Chart;

// 2015년 평균기온
// 서울 : -0.9,1.0,6.3,13.3,18.9,23.6,25.8,26.3,22.4,15.5,8.9,1.6
// 제주 : 7.4,7.3,10.4,15.1,18.8,22.0,25.6,26.4,23.2,19.2,15.2,10.0
// 부산 : 4.7,5.4,9.5,13.9,18.8,21.0,23.9,26.1,22.1,18.1,13.6,7.9
// 대구 : 2.3,3.8,9.2,14.6,21.7,22.9,25.0,26.0,20.6,15.8,11.0,4.5
// 광주 : 1.7,3.0,8.0,13.9,19.4,22.5,25.4,26.0,22.0,16.9,11.6,5.3
// 전주 : 1.0,2.5,7.2	,13.9,19.2,22.7,25.1,25.9,21.6,16.1,10.9,4.4
// 대전 : 0.0,1.9,7.2	,13.3,19.5,23.4,25.4,26.4,21.7,15.5,10.1,3.1
// 춘천 : -2.7,-0.3,5.5,12.3,19.1,23.4,25.0,25.6,20.4,13.7,7.9,0.0
// 철원 : -4.0,-1.3,4.0,11.3,17.6,21.6,23.8,24.1,18.9,12.3,6.6,-1.2 

@Controller
@RequestMapping("/echart/*")
public class EChartController {
	
	@RequestMapping(value="main")
	public String main() throws Exception {
		return "echart/main";
	}
	
	@GetMapping("line1")
	@ResponseBody
	public Map<String, Object> line1() throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		List<Chart> list = new ArrayList<>();
		list.add(new Chart("1월", -0.9));
		list.add(new Chart("2월", 1.0));
		list.add(new Chart("3월", 6.3));
		list.add(new Chart("4월", 13.3));
		list.add(new Chart("5월", 18.9));
		list.add(new Chart("6월", 23.6));
		list.add(new Chart("7월", 25.8));
		list.add(new Chart("8월", 26.3));
		list.add(new Chart("9월", 22.4));
		list.add(new Chart("10월", 15.5));
		list.add(new Chart("11월", 8.9));
		list.add(new Chart("12월", 1.6));
		
		model.put("list", list);
		
		return model;
	}
	
	@GetMapping("line2")
	@ResponseBody
	public Map<String, Object> line2() throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		List<Map<String, Object>> list = new ArrayList<>();
		Map<String, Object> map;
		
		map = new HashMap<>();
		map.put("name", "서울");
		map.put("type", "line");
		map.put("data", new double[]{-0.9,1.0,6.3,13.3,18.9,23.6,25.8,26.3,22.4,15.5,8.9,1.6});
		list.add(map);

		map = new HashMap<>();
		map.put("name", "부산");
		map.put("type", "line");
		map.put("data", new double[]{4.7,5.4,9.5,13.9,18.8,21.0,23.9,26.1,22.1,18.1,13.6,7.9});
		list.add(map);
		
		map = new HashMap<>();
		map.put("name", "제주");
		map.put("type", "line");
		map.put("data", new double[]{7.4,7.3,10.4,15.1,18.8,22.0,25.6,26.4,23.2,19.2,15.2,10.0});
		list.add(map);

		map = new HashMap<>();
		map.put("name", "철원");
		map.put("type", "line");
		map.put("data", new double[]{-4.0,-1.3,4.0,11.3,17.6,21.6,23.8,24.1,18.9,12.3,6.6,-1.2});
		list.add(map);
		
		model.put("year", "2015");
		model.put("legend", new String[] {"서울", "부산", "제주", "철원"});
		model.put("series", list);
		
		return model;
	}

	@GetMapping("bar")
	@ResponseBody
	public Map<String, Object> bar() throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		List<Map<String, Object>> list = new ArrayList<>();
		Map<String, Object> map;
		
		map = new HashMap<>();
		map.put("name", "서울");
		map.put("type", "bar");
		map.put("data", new double[]{-0.9,1.0,6.3,13.3,18.9,23.6,25.8,26.3,22.4,15.5,8.9,1.6});
		list.add(map);

		map = new HashMap<>();
		map.put("name", "부산");
		map.put("type", "bar");
		map.put("data", new double[]{4.7,5.4,9.5,13.9,18.8,21.0,23.9,26.1,22.1,18.1,13.6,7.9});
		list.add(map);
		
		map = new HashMap<>();
		map.put("name", "제주");
		map.put("type", "bar");
		map.put("data", new double[]{7.4,7.3,10.4,15.1,18.8,22.0,25.6,26.4,23.2,19.2,15.2,10.0});
		list.add(map);

		map = new HashMap<>();
		map.put("name", "철원");
		map.put("type", "bar");
		map.put("data", new double[]{-4.0,-1.3,4.0,11.3,17.6,21.6,23.8,24.1,18.9,12.3,6.6,-1.2});
		list.add(map);
		
		model.put("year", "2015");
		model.put("legend", new String[] {"서울", "부산", "제주", "철원"});
		model.put("series", list);
		
		return model;
	}

	@GetMapping("pie")
	@ResponseBody
	public Map<String, Object> pie() throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		List<Chart> list = new ArrayList<>();
		list.add(new Chart("07-10시", 10));
		list.add(new Chart("10-13시", 30));
		list.add(new Chart("13-16시", 33));
		list.add(new Chart("16-19시", 20));
		list.add(new Chart("기타", 10));
		
		model.put("list", list);

		return model;
	}
}
