package com.pro.dong.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.pro.dong.test.model.service.TestService;
import com.pro.dong.test.model.vo.Test;

@Controller
@RequestMapping("/test")
@RestController
public class TestController {

	@Autowired
	TestService testService;
	
	@RequestMapping("/test.do")
	public ModelAndView test(ModelAndView mav) {
		
		Test test = testService.selectOne();
		mav.addObject("test", test);
		
		return mav;
	}
	
	@PostMapping("/test")
	public String test(@RequestParam("text") String text) {
		return ""+testService.insert(text);
	}
	
	@GetMapping(value="/test", produces="text/plain;charset=UTF-8")
	public String test() {
		
		List<Test> list = testService.selectAll();
		Gson gson = new Gson();
		
		return gson.toJson(list);
	}
	
}
