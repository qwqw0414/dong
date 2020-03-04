package com.pro.dong.exception;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/common")
public class exception {

	@RequestMapping("/error.do")
	public ModelAndView error(ModelAndView mav) {
		mav.setViewName("/common/error");
		return mav;
	}
	
}
