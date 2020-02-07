package com.pro.dong.admin.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.pro.dong.admin.model.service.AdminService;
import com.pro.dong.board.controller.BoardController;
import com.pro.dong.board.model.vo.BoardCategory;
import com.pro.dong.board.model.vo.BoardReport;
import com.pro.dong.common.util.Utils;
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
	@RequestMapping("/memberList.do")
	public ModelAndView memberList(ModelAndView mav,@RequestParam(defaultValue="1") int cPage) {
		// 페이징바 작업
		final int numPerPage = 10;
		
		List<Member> list = as.selectMemberList(cPage,numPerPage);
		int totalContents = as.selectMemberTotalContent();
		
		mav.addObject("list", list);
		mav.addObject("totalContents",totalContents);
		mav.addObject("numPerPage",numPerPage);
		mav.addObject("cPage",cPage);
		mav.setViewName("/admin/memberList");
		
		return mav;
	}

	@RequestMapping("/memberView.do")
	public ModelAndView memberView(ModelAndView mav,
					@RequestParam("memberId") String memberId
									,@RequestParam(defaultValue="1") int cPage) {

		final int numPerPage = 10;

		Map<String, Object> result = new HashMap<>();
		
		Member m = as.selectMemberView(memberId);
		
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		
		// 페이징바 작업
		int totalContents = as.selectBoardReportTotalContent(param);
		List<BoardReport> list = as.selectOneMember(cPage, numPerPage, param);
		
		mav.addObject("list",list);
		mav.addObject("m",m);
		mav.addObject("cPage",cPage);
		mav.addObject("numPerPage",numPerPage);
		mav.addObject("totalContents",totalContents);
		mav.setViewName("admin/memberView");
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
