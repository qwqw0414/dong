package com.pro.dong.board.model.service;

import java.util.List;
import java.util.Map;

import com.pro.dong.board.model.vo.Attachment;
import com.pro.dong.board.model.vo.Board;
import com.pro.dong.board.model.vo.BoardCategory;
import com.pro.dong.board.model.vo.BoardComment;
import com.pro.dong.member.model.vo.Member;

public interface BoardService {

	// 민호 시작 ==========================
	List<Board> loadBoardList(int cPage, int numPerPage, Map<String, String> param);
	int selectBoardTotalContents(Map<String, String> param);
	List<BoardCategory> selectBoardCategory();
	List<Board> selectBoardNotice(Map<String, String> param);
	//==========================민호 끝
		
	// 하진 시작 ==========================
	List<Board> selectBoardList(String dong);
	List<Map<String, String>> loadBoardReportCategory();
	int insertBoardReport(Map<String, String> param);
	//========================== 하진 끝
		
	// 근호 시작 ==========================
	int insertBoard(Board board, List<Attachment> attachList);
	//========================== 근호 끝
		
	// 지은 시작 ==========================
	Board selectOneBoard(int boardNo);
	int boardInCount(int boardNo);
	Attachment selectAttachmentList(int boardNo);
	int deleteBoard(int boardNo);
	Member getMemberByMemberId(String memberId);
	int boardUpdate(Board board);
	int insertBoardReputation(Map<String, String> map);
	int selectBoardLike(Map<String, String> map);
	int deleteBoardReputation(Map<String, String> map);
	int selectBoardLikeByMemberId(Map<String, String> map);
	//========================== 지은 끝
		
	// 예찬 시작 ==========================
		
	//========================== 예찬 끝
		
	// 주영 시작 ==========================
	List<Map<String, String>> selectBoardReportList(int boardNo);
	int updateReportStatus(int reportNo);
	//========================== 주영 끝
		
	// 현규 시작 ==========================
	int insertBoardComment(BoardComment bc);
	List<Map<String, String>> selectBoardCommentList(int boardNo, int cPage, int numPerPage);
	int deleteLevel1(int commentNo);
	int countComment(int boardNo);
	int deleteLevel2(int commentNo);
	//========================== 현규 끝



}
