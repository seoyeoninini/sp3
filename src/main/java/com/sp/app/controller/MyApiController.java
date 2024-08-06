package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.APISerializer;

@Controller
@RequestMapping("/api/*")
public class MyApiController {
	@Autowired
	private APISerializer apiSerializer;
	
	@GetMapping("main")
	public String main() {
		//  JSP에서 AJAX로 공공 API 접속
		return "api/main";
	}

	@GetMapping("main1")
	public String main1() {
		//  JSP에서 AJAX로 공공 API : 한국관광공사_관광사진 정보 가져오기
		return "api/main1";
	}
	
	@GetMapping("main2")
	public String main2() {
		return "api/main2";
	}
	
	// produces : response의 Content-Type
	@RequestMapping(value = "xmlZip", method = RequestMethod.GET, produces = "application/xml; charset=utf-8")
	@ResponseBody
	public String xmlZip(@RequestParam String search) throws Exception {
		// 우편번호(공공 API)를 XML로 반환받아 클라이언트에게 XML로 전송
		String result = null;

		search = URLDecoder.decode(search, "utf-8");
		
		
		// 일반 encoding키 넣기
		String serviceKey = "p7n6IP102nDf2VS2RR0lUwD%2BUcwvFfKW8fbSebL2ZZX9x3L1O%2F157yGNVlwKCUgjarfOff2ZTVvgUkGAs9xkvw%3D%3D";
		String spec = "http://openapi.epost.go.kr/postal/retrieveNewAdressAreaCdService/retrieveNewAdressAreaCdService/getNewAddressListAreaCd";
		spec += "?ServiceKey=" + serviceKey;
		spec += "&searchSe=road&srchwrd=" + URLEncoder.encode(search, "utf-8");

		result = apiSerializer.receiveToString(spec);

		return result;
	}

	@RequestMapping(value = "jsonZip", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String jsonZip(@RequestParam String search) throws Exception {
		// 우편번호(공공 API)를 XML로 반환받아 클라이언트에게 JSON 으로 전송
		String result = null;

		search = URLDecoder.decode(search, "utf-8");

		String serviceKey = "p7n6IP102nDf2VS2RR0lUwD%2BUcwvFfKW8fbSebL2ZZX9x3L1O%2F157yGNVlwKCUgjarfOff2ZTVvgUkGAs9xkvw%3D%3D";
		String spec = "http://openapi.epost.go.kr/postal/retrieveNewAdressAreaCdService/retrieveNewAdressAreaCdService/getNewAddressListAreaCd";
		spec += "?ServiceKey=" + serviceKey;
		spec += "&searchSe=road&srchwrd=" + URLEncoder.encode(search, "utf-8");

		result = apiSerializer.receiveXmlToJson(spec);

		return result;
	}

	@RequestMapping(value = "weather1", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String weather1(@RequestParam String base_date,
			@RequestParam String base_time,
			@RequestParam String nx,
			@RequestParam String ny) throws Exception {
		String result = null;

		// 기상청_단기예보 ((구)_동네예보) 조회서비스
		// 날씨-초단기 실황 조회
		String spec = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst";
		// 응답:obsrValue-실황값, T1H-기온, PTY-강수형태:없음(0), 비(1), 비/눈(2), 눈(3), 소나기(4)
		// 키
		String serviceKey = "p7n6IP102nDf2VS2RR0lUwD%2BUcwvFfKW8fbSebL2ZZX9x3L1O%2F157yGNVlwKCUgjarfOff2ZTVvgUkGAs9xkvw%3D%3D";
		// 한페이지 결과수
		int numOfRows = 10;
		// 페이지번호
		int pageNo = 1;
		// 데이터 타입-XML/JSON, 기본:XML
		// String dataType = "XML";
		String dataType = "JSON";

		spec += "?serviceKey=" + serviceKey + "&numOfRows=" + numOfRows + "&pageNo=" + pageNo;
		spec += "&base_date=" + base_date + "&base_time=" + base_time;
		spec += "&nx=" + nx + "&ny=" + ny;
		spec += "&dataType=" + dataType;

		// XML로 받아서 JSON으로 변환
		// result = apiSerializer.receiveXmlToJson(spec);
		result = apiSerializer.receiveToString(spec);

		return result;
	}

	@RequestMapping(value = "weather2", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String weather2(@RequestParam String base_date,
			@RequestParam String base_time,
			@RequestParam String nx,
			@RequestParam String ny) throws Exception {
		String result = null;

		// 초단기 예보 조회
		String spec = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst";
		// 키
		String serviceKey = "p7n6IP102nDf2VS2RR0lUwD%2BUcwvFfKW8fbSebL2ZZX9x3L1O%2F157yGNVlwKCUgjarfOff2ZTVvgUkGAs9xkvw%3D%3D";
		// 한페이지 결과수
		int numOfRows = 40;
		// 페이지번호
		int pageNo = 1;
		// 데이터 타입-XML/JSON, 기본:XML
		String dataType = "JSON";

		spec += "?serviceKey=" + serviceKey + "&numOfRows=" + numOfRows + "&pageNo=" + pageNo;
		spec += "&base_date=" + base_date + "&base_time=" + base_time;
		spec += "&nx=" + nx + "&ny=" + ny;
		spec += "&dataType=" + dataType;

		// JSON으로 받음
		result = apiSerializer.receiveToString(spec);

		return result;
	}

	@RequestMapping(value = "weather3", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String weather3(@RequestParam String base_date,
			@RequestParam String base_time,
			@RequestParam String nx,
			@RequestParam String ny) throws Exception {
		String result = null;

		// 단기 예보 조회
		String spec = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";
		// 키
		String serviceKey = "p7n6IP102nDf2VS2RR0lUwD%2BUcwvFfKW8fbSebL2ZZX9x3L1O%2F157yGNVlwKCUgjarfOff2ZTVvgUkGAs9xkvw%3D%3D";
		// 한페이지 결과수
		int numOfRows = 9;
		// 페이지번호
		int pageNo = 1;
		// 데이터 타입-XML/JSON, 기본:XML
		String dataType = "JSON";

		spec += "?serviceKey=" + serviceKey + "&numOfRows=" + numOfRows + "&pageNo=" + pageNo;
		spec += "&base_date=" + base_date + "&base_time=" + base_time;
		spec += "&nx=" + nx + "&ny=" + ny;
		spec += "&dataType=" + dataType;

		result = apiSerializer.receiveToString(spec);

		return result;
	}

	@RequestMapping(value = "weather4", method = RequestMethod.GET, produces = "application/xml; charset=utf-8")
	@ResponseBody
	public String weather4() throws Exception {
		String result = null;

		// 현재 지역 날씨 확인(브라우저에서 해당 주소로 접근하면 xml 에러로 표시)
		String spec = "http://www.kma.go.kr/XML/weather/sfc_web_map.xml";
		result = apiSerializer.receiveToString(spec);

		return result;
	}
	
}
