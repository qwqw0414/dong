package com.pro.dong.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pro.dong.member.model.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	static Logger log = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService ms;
	
	@RequestMapping("/memberEnroll.do")
	public void memberEnroll() {
		
	}
	
	@RequestMapping("/memberLogin.do")
	public void memberLogin() {
		
	}
	
	@RequestMapping("/findPassword.do")
	public void findPassword() {
		
	}
	
	@RequestMapping("/findId.do")
	public void findId() {
		
	}
	
	@RequestMapping("/memberView.do")
	public void memberView() {
		
	}
	
	@RequestMapping("/memberBye.do")
	public void memberBye() {
		
	}
	
	
	
}
