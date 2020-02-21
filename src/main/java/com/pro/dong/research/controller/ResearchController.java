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
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
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
		
		List<Map<String,String>> addr = rs.selectTopAddr(param);
		
		
		
		return gson.toJson(addr);
	}
}
