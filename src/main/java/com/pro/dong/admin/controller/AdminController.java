package com.pro.dong.admin.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.pro.dong.admin.model.service.AdminService;
import com.pro.dong.board.controller.BoardController;
import com.pro.dong.member.model.vo.Address;
import com.pro.dong.member.model.vo.Member;

@RequestMapping("/admin")
@Controller
public class AdminController {

	static Logger log = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	AdminService as;
	
	// 민호 시작 ==========================
	
	// ==========================민호 끝
	
	// 하진 시작 ==========================
	@RequestMapping("/member/memberList.do")
	public ModelAndView memberList(ModelAndView mav) {
		List<Member> list = as.selectMemberList();
		
		log.debug("memberList@@@@@@@={}",list);
		mav.addObject("list", list);
		mav.setViewName("/admin/member/memberList");
		return mav;
	}
	// ========================== 하진 끝
	
	// 근호 시작 ==========================
	
	// ========================== 근호 끝
	
	// 지은 시작 ==========================
	
	// ========================== 지은 끝
	
	// 예찬 시작 ==========================
	
	// ========================== 예찬 끝
	
	// 주영 시작 ==========================
	
	// ========================== 주영 끝
	
	// 현규 시작 ==========================
	
	// ========================== 현규 끝
}
