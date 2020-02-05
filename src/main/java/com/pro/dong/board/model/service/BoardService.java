package com.pro.dong.board.model.service;

import java.util.List;
import java.util.Map;

import com.pro.dong.board.model.vo.Board;
import com.pro.dong.board.model.vo.BoardCategory;
import com.pro.dong.member.model.vo.Address;

public interface BoardService {

	// 민호 시작 ==========================
	Address getAddrByMemberId(String memberId);

	List<Board> loadBoardList(int cPage, int numPerPage, Map<String, String> param);

	int selectBoardTotalContents(Map<String, String> param);

	List<BoardCategory> selectBoardCategory();

	
	//==========================민호 끝
		
	// 하진 시작 ==========================
		
	//========================== 하진 끝
		
	// 근호 시작 ==========================
	int insertBoard(Board board);
	
	//========================== 근호 끝
		
	// 지은 시작 ==========================
	Board selectOneBoard(int boardNo);

	int boardInCount(int boardNo);

	//========================== 지은 끝
		
	// 예찬 시작 ==========================
		
	//========================== 예찬 끝
		
	// 주영 시작 ==========================
		
	//========================== 주영 끝
		
	// 현규 시작 ==========================

	//========================== 현규 끝


}
