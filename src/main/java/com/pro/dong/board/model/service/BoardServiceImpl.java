package com.pro.dong.board.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.board.model.dao.BoardDAO;
import com.pro.dong.board.model.vo.Board;
import com.pro.dong.board.model.vo.BoardCategory;
import com.pro.dong.member.model.vo.Address;
@Service
public class BoardServiceImpl implements BoardService {

	static Logger log = LoggerFactory.getLogger(BoardServiceImpl.class);
	@Autowired
	BoardDAO bd;
	
	// 민호 시작 ==========================
	@Override
	public Address getAddrByMemberId(String memberId) {
		return bd.getAddrByMemberId(memberId);
	}

	@Override
	public List<Board> loadBoardList(int cPage, int numPerPage, Map<String, String> param) {
		return bd.loadBoardList(cPage, numPerPage, param);
	}

	@Override
	public int selectBoardTotalContents(Map<String, String> param) {
		return bd.selectBoardTotalContents(param);
	}

	@Override
	public List<BoardCategory> selectBoardCategory() {
		return bd.selectBoardCategory();
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
