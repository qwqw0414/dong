package com.pro.dong.admin.controller;



import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.pro.dong.admin.model.service.AdminService;
import com.pro.dong.board.model.vo.BoardReport;
import com.pro.dong.member.model.vo.Member;

@RequestMapping("/admin")
@Controller
public class AdminController {

	static Logger log = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	AdminService as;
	
	// 민호 시작 ==========================
	@RequestMapping("productList.do")
	public void productList() {
		
	}
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
	
	@RequestMapping("/member/memberView.do")
	public ModelAndView memberView(ModelAndView mav, @RequestParam("memberId") String memberId) {
		List<BoardReport> list = as.selectOneMember(memberId);
		Member m = as.selectMemberView(memberId);
		
		log.debug("memberId 게시판 @@@@@ ={}",list);
		log.debug("member객체 @@@@@={}",m);
		mav.addObject("list",list);
		mav.addObject("m",m);
		mav.setViewName("/admin/member/memberView");
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
