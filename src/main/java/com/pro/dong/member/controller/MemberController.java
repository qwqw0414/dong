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
	
// 민호 시작 ==========================
	@RequestMapping("/memberLogin.do")
	public void memberLogin() {
		
	}
	
//========================== 민호 끝
	
// 하진 시작 ==========================
	@RequestMapping("/memberBye.do")
	public void memberBye() {
		
	}
//========================== 하진 끝
	
// 근호 시작 ==========================
	
//========================== 근호 끝
	
// 지은 시작 ==========================
	@RequestMapping("/findPassword.do")
	public void findPassword() {
		
	}
	
//========================== 지은 끝
	
// 예찬 시작 ==========================
	@RequestMapping("/memberEnroll.do")
	public void memberEnroll() {
		
	}
	
//========================== 예찬 끝
	
// 주영 시작 ==========================
	@RequestMapping("/findId.do")
	public void findId() {
		
	}
	
//========================== 주영 끝
	
// 현규 시작 ==========================
	@RequestMapping("/memberView.do")
	public void memberView() {
		
	}
	
//========================== 현규 끝

	
}
