package com.pro.dong.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.pro.dong.test.model.service.TestService;
import com.pro.dong.test.model.vo.Test;

@Controller
@RequestMapping("/test")
public class TestController {

	@Autowired
	TestService testService;
	
	@RequestMapping("/test.do")
	public ModelAndView test(ModelAndView mav) {
		
		Test test = testService.selectOne();
		mav.addObject("test", test);
		
		return mav;
	}
	
}
