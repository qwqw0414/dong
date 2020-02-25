package com.pro.dong.research.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pro.dong.common.util.Utils;
import com.pro.dong.research.model.service.ResearchService;

@Controller
@RequestMapping("/research")
public class ResearchController {
	
	static Logger log = LoggerFactory.getLogger(ResearchController.class);
	Gson gson = new Gson();
	@Autowired
	ResearchService rs;
	
	@RequestMapping(value="/selectTop", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String selectTop(String rank, String year, String month) {
		
		Map<String, String> param = new HashMap<>();
		param.put("rank", rank);
		param.put("year", year);
		param.put("month",month);
		
		//주소, 총 상품, 거래 수, 거래 비 조회
		List<Map<String,String>> addr = rs.selectTopAddr(param);
		
		Map<String,List<Map<String,String>>> result = new HashMap<>();
		result.put("addr", addr);
		
		return gson.toJson(result);
	}
	
	@RequestMapping("/thermometer")
	@ResponseBody
	public String thermometer(int shopNo) {

		int result = rs.getThermometer(shopNo);
		
		return result+"";
	}
	

	@RequestMapping("/insertHallOfFame")
	@ResponseBody
	public Map<String, Object> insertHallOfFame(@RequestParam("goldSido")String goldSido,@RequestParam("goldSigungu")String goldSigungu,@RequestParam("goldDong")String goldDong,
			@RequestParam("silverSido")String silverSido,@RequestParam("silverSigungu")String silverSigungu,@RequestParam("silverDong")String silverDong,
			@RequestParam("bronzeSido")String bronzeSido,@RequestParam("bronzeSigungu")String bronzeSigungu,@RequestParam("bronzeDong")String bronzeDong){
		Map<String, Object> resultMap = new HashMap<>();
		Map<String, String> param = new HashMap<>();
		String badgeType = "1G";
		
		param.put("badgeType", badgeType);
		param.put("sido", goldSido);
		param.put("sigungu", goldSigungu);
		param.put("dong", goldDong);
		int result = rs.insertHallOfFame(param);
		resultMap.put("goldResult", result);
		if(result>0) {
			badgeType = "2S";
			param.put("badgeType", badgeType);
			param.put("sido", silverSido);
			param.put("sigungu", silverSigungu);
			param.put("dong", silverDong);
			result = rs.insertHallOfFame(param);
			resultMap.put("silverResult", result);
			if(result>0) {
				badgeType = "3B";
				param.put("badgeType", badgeType);
				param.put("sido", bronzeSido);
				param.put("sigungu", bronzeSigungu);
				param.put("dong", bronzeDong);
				result = rs.insertHallOfFame(param);
				resultMap.put("bronzeResult", result);
			}
		}
		return resultMap;
	}
	
	@RequestMapping("/loadHallOfFame")
	@ResponseBody
	public Map<String, Object> loadHallOfFame(@RequestParam(value="cPage", defaultValue="1")int cPage){
		Map<String, Object> resultMap = new HashMap<>();
		int numPerPage = 36;
		List<Map<String, String>> HallOfFameList = rs.loadHallOfFame(cPage,numPerPage);

		for(Map<String, String> i : HallOfFameList) {
			i.put("BADGE_TYPE", i.get("BADGE_TYPE").trim());
		}
		
		int totalContents = rs.HallOfFameTotalContents();
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
		resultMap.put("HallOfFameList", HallOfFameList);
		resultMap.put("pageBar", pageBar);
		
		return resultMap;
	}


}
