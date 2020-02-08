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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pro.dong.admin.model.service.AdminService;
import com.pro.dong.board.model.vo.BoardReport;
import com.pro.dong.common.util.Utils;
import com.pro.dong.member.model.vo.Member;
import com.pro.dong.product.model.vo.Product;

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
	@RequestMapping("/loadProductList")
	@ResponseBody
	public Map<String, Object> loadProductList(@RequestParam(value="searchType", defaultValue="")String searchType, @RequestParam(value="searchKeyword",defaultValue="") String searchKeyword, @RequestParam(value="productCategory",defaultValue="") String productCategory,@RequestParam(value="cPage",defaultValue="1") int cPage){
		final int numPerPage = 10;
		Map<String, Object> result = new HashMap<>();
		
		Map<String, String> param = new HashMap<>();
		param.put("productCategory", productCategory);
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		
		//페이징바 작업
		int totalContents = as.selectProductTotalContents(param);
		//상품 조회
		List<Product> list = as.loadProductList(cPage, numPerPage, param);
		result.put("list", list);
		result.put("productCategory", productCategory);
		result.put("cPage", cPage);
		result.put("numPerPage", numPerPage);
		result.put("totalContents", totalContents);
		String function = "loadProductList('"+searchType+"','"+searchKeyword+"','"+productCategory+"',";
		String pageBar = Utils.getAjaxPageBar(totalContents, cPage, numPerPage, function);
		result.put("pageBar", pageBar);
		return result;
	}
	// ==========================민호 끝
	
	// 하진 시작 ==========================
	@RequestMapping("/memberList.do")
	public ModelAndView memberList(ModelAndView mav) {
		mav.setViewName("/admin/memberList");
		return mav;
	}
	
	@RequestMapping("/memberList")
	@ResponseBody
	public Map<String, Object> memberList(@RequestParam(value="searchType", defaultValue="")String searchType, 
											@RequestParam(value="searchKeyword",defaultValue="") String searchKeyword,
											@RequestParam(value="cPage",defaultValue="1") int cPage) {
		
		
		// 페이징바 작업
		final int numPerPage = 10;
		
		Map<String, Object> result = new HashMap<>();

		Map<String, String> param = new HashMap<>();
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		
		int totalContents = as.selectMemberTotalContent(param);
		List<Member> list = as.selectMemberList(cPage,numPerPage,param);
		
		result.put("list", list);
		result.put("cPage", cPage);
		result.put("numPerPage", numPerPage);
		result.put("totalContents", totalContents);
		String function = "loadMemberList('"+searchType+"','"+searchKeyword+"',";
		String pageBar = Utils.getAjaxPageBar(totalContents, cPage, numPerPage, function);
		result.put("pageBar", pageBar);
		return result;
	}

	@RequestMapping("/memberView.do")
	public ModelAndView memberView(ModelAndView mav,
			@RequestParam(value = "memberId") String memberId
			,@RequestParam(value = "cPage" ,defaultValue="1") int cPage) {

		final int numPerPage = 10;

		Map<String, Object> result = new HashMap<>();
		
		Member m = as.selectMemberView(memberId);
		
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		
		// 페이징바 작업
		int totalContents = as.selectBoardReportTotalContent(param);
		List<BoardReport> list = as.selectOneMember(cPage, numPerPage, param);
		log.debug("신고 카ㅌ테고리 @@@@@@@@@@@={}",list);
		
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
