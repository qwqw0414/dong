package com.pro.dong.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pro.dong.board.model.service.BoardService;
import com.pro.dong.board.model.vo.Board;
import com.pro.dong.member.model.vo.Address;


@RequestMapping("/board")
@Controller
public class BoardController {
	
	static Logger log = LoggerFactory.getLogger(BoardController.class);
	@Autowired
	BoardService bs;
	
	
	// 민호 시작 ==========================
	@RequestMapping("/boardList.do")
	public void boardList() {
		
	}
	
	@RequestMapping("/loadBoardList")
	@ResponseBody
	public Map<String, Object> loadBoardList(@RequestParam(defaultValue="1") int cPage, @RequestParam("memberId") String memberId){
		final int numPerPage = 10;
		Map<String, Object> result = new HashMap<>();
		// 주소 조회
		Address addr = bs.getAddrByMemberId(memberId);
		log.debug("addr={}",addr);
		// 파라미터 생성
		Map<String, String> param = new HashMap<>();
		String sido = addr.getSido();
		String sigungu = addr.getSigungu();
		String dong = addr.getDong();
		param.put("sido", sido);
		param.put("sigungu", sigungu);
		param.put("dong", dong);
		// 페이징바 작업
		int totalContents = bs.selectBoardTotalContents(param);
		// 게시글 조회
		List<Board> list = bs.loadBoardList(cPage, numPerPage, param);
		// 넘겨줄map에 담기
		result.put("sido", sido);
		result.put("sigungu", sigungu);
		result.put("dong", dong);
		result.put("list", list);
		result.put("cPage", cPage);
		result.put("numPerPage", numPerPage);
		result.put("totalContents", totalContents);
		
		return result;
	}
	//==========================민호 끝
		
	// 하진 시작 ==========================
		
	//========================== 하진 끝
		
	// 근호 시작 ==========================

	//========================== 근호 끝
		
	// 지은 시작 ==========================

	//========================== 지은 끝
		
	// 예찬 시작 ==========================
		
	//========================== 예찬 끝
		
	// 주영 시작 ==========================
		
	//========================== 주영 끝
		
	// 현규 시작 ==========================

	//========================== 현규 끝


}
