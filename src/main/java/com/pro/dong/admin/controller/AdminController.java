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

import com.google.gson.Gson;
import com.pro.dong.admin.model.service.AdminService;
import com.pro.dong.board.model.vo.BoardReport;
import com.pro.dong.common.util.Utils;
import com.pro.dong.member.model.vo.Member;
import com.pro.dong.product.model.vo.Product;

@RequestMapping("/admin")
@Controller
public class AdminController {

	static Logger log = LoggerFactory.getLogger(AdminController.class);
	static Gson gson = new Gson();
	@Autowired
	AdminService as;
	
	// 민호 시작 ==========================
	@RequestMapping("productList.do")
	public void productList() {

	}
	@ResponseBody
	@RequestMapping(value="/loadSidoList", produces="text/plain;charset=UTF-8")
	public String loadSidoList(){
		List<String> list = as.selectAddressSido();
		return gson.toJson(list);
	}
	@ResponseBody
	@RequestMapping(value="/loadSigunguList", produces="text/plain;charset=UTF-8")
	public String loadSigunguList(@RequestParam(value="sido")String sido){
		List<String> list = as.selectAddressSigungu(sido);
		return gson.toJson(list);
	}
	@ResponseBody
	@RequestMapping(value="/loadDongList", produces="text/plain;charset=UTF-8")
	public String loadDongList(@RequestParam(value="sigungu")String sigungu){
		List<String> list = as.selectAddressDong(sigungu);
		return gson.toJson(list);
	}
	
	@RequestMapping("/loadProductList")
	@ResponseBody
	public Map<String, Object> loadProductList(@RequestParam(value="sido", defaultValue="")String sido, @RequestParam(value="sigungu", defaultValue="")String sigungu, @RequestParam(value="dong", defaultValue="")String dong,
			@RequestParam(value="searchType", defaultValue="")String searchType, @RequestParam(value="searchKeyword",defaultValue="") String searchKeyword,
			@RequestParam(value="cPage",defaultValue="1") int cPage){
		final int numPerPage = 10;
		Map<String, Object> result = new HashMap<>();
		
		Map<String, String> param = new HashMap<>();
		param.put("sido", sido);
		param.put("sigungu", sigungu);
		param.put("dong", dong);
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		
		//페이징바 작업
		int totalContents = as.selectProductTotalContents(param);
		//상품 조회
		List<Product> list = as.loadProductList(cPage, numPerPage, param);
		result.put("list", list);
		result.put("cPage", cPage);
		result.put("numPerPage", numPerPage);
		result.put("totalContents", totalContents);
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
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
	
	@RequestMapping("/memberDelete.do")
	public ModelAndView memberDelete(ModelAndView mav, @RequestParam(value="memberId") String memberId) {
		
		String msg = "";
		String loc = "/";
		
		int result = as.memberDelete(memberId);
		
		if(result<0) {
			msg="회원삭제 실패";
			loc="/admin/memberView.do";
		}
		else {
			msg="회원삭제 성공";
			loc="/admin/memberList.do";
		}
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		
		return mav;
	}

	// ========================== 하진 끝
	
	// 근호 시작 ==========================
	
	// ========================== 근호 끝
	
	// 지은 시작 ==========================
	@RequestMapping("/memberPointList.do")
	public void memberPointList() {
		
	}
	
	@RequestMapping("/memberPointListEnd")
	@ResponseBody
	public Map<String, Object> memberPointListEnd(@RequestParam(value="searchType", defaultValue="")String searchType, 
												  @RequestParam(value="searchKeyword",defaultValue="") String searchKeyword,
												  @RequestParam(value="cPage",defaultValue="1") int cPage) {
		
		final int numPerPage = 10;
		Map<String,Object> result = new HashMap<>();
		Map<String, String> param = new HashMap<>();
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		
		int totalPoint = as.selectMemberPointTotal(param);
		List<Map<String,String>> list = as.selectMemberPointList(cPage, numPerPage, param);
		String function = "loadMemberPointList('"+searchType+"','"+searchKeyword+"',";
		String pageBar = Utils.getAjaxPageBar(totalPoint, cPage, numPerPage, function);
		
		result.put("list",list);
		result.put("totalPoint", totalPoint);
		result.put("cPage", cPage);
		result.put("numPerPage", numPerPage);
		result.put("pageBar", pageBar);
		log.debug("result={}", result);
		log.debug("list={}", list);
		
		return result;
	}
	
	
	// ========================== 지은 끝
	
	// 예찬 시작 ==========================
	
	// ========================== 예찬 끝
	
	// 주영 시작 ==========================
	@RequestMapping("boardList.do")
	public void boardList() {

	}
	
	@RequestMapping("/loadBoardList")
	@ResponseBody
	public Map<String, Object> loadBoardList(@RequestParam(value="sido", defaultValue="")String sido, @RequestParam(value="sigungu", defaultValue="")String sigungu, @RequestParam(value="dong", defaultValue="")String dong,
			@RequestParam(value="searchType", defaultValue="")String searchType, @RequestParam(value="searchKeyword",defaultValue="") String searchKeyword,@RequestParam(value="type",defaultValue="") String type,
			@RequestParam(value="cPage",defaultValue="1") int cPage){
		final int numPerPage = 10;
		Map<String, Object> result = new HashMap<>();
		
		Map<String, String> param = new HashMap<>();
		param.put("sido", sido);
		param.put("sigungu", sigungu);
		param.put("dong", dong);
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		param.put("type", type);
		
		//페이징바 작업
		int totalContents = as.selectBoardTotalContents(param);
		log.info("totalContents@@@@@@@@@@@@@@@@@={}", totalContents);

		List<Product> list = as.loadBoardList(cPage, numPerPage, param);
		result.put("list", list);
		result.put("cPage", cPage);
		result.put("numPerPage", numPerPage);
		result.put("totalContents", totalContents);
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
		result.put("pageBar", pageBar);
		log.info("list={}", list);
		return result;
	}
	
	@RequestMapping("/loadReportBoardList")
	@ResponseBody
	public Map<String, Object> loadReportList(@RequestParam(value="sido", defaultValue="")String sido, @RequestParam(value="sigungu", defaultValue="")String sigungu, @RequestParam(value="dong", defaultValue="")String dong,
			@RequestParam(value="searchType", defaultValue="")String searchType, @RequestParam(value="searchKeyword",defaultValue="") String searchKeyword,@RequestParam(value="type",defaultValue="") String type,
			@RequestParam(value="cPage",defaultValue="1") int cPage){
		final int numPerPage = 10;
		Map<String, Object> result = new HashMap<>();
		
		Map<String, String> param = new HashMap<>();
		param.put("sido", sido);
		param.put("sigungu", sigungu);
		param.put("dong", dong);
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		param.put("type", type);
		
		//페이징바 작업
		int totalContents = as.selectReportBoardTotalContents(param);
		log.info("reportTotalContents@@@@@@@@@@@@@@@@@={}", totalContents);

		List<Product> list = as.loadReportBoardList(cPage, numPerPage, param);
		result.put("list", list);
		result.put("cPage", cPage);
		result.put("numPerPage", numPerPage);
		result.put("totalContents", totalContents);
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
		result.put("pageBar", pageBar);
		log.info("list%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%={}", list);
		return result;
	}
	
	// ========================== 주영 끝
	
	// 현규 시작 ==========================
	
	// ========================== 현규 끝
}
