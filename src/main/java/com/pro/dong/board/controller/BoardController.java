package com.pro.dong.board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pro.dong.board.model.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	static Logger log = LoggerFactory.getLogger(BoardController.class);
	@Autowired
	BoardService bs;
	
	
	// 민호 시작 ==========================
	@RequestMapping("/boardList.do")
	public void boardList() {
		
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
