package com.pro.dong.board.model.dao;

import java.util.List;
import java.util.Map;

import com.pro.dong.board.model.vo.Attachment;
import com.pro.dong.board.model.vo.Board;
import com.pro.dong.board.model.vo.BoardCategory;
import com.pro.dong.board.model.vo.BoardComment;
import com.pro.dong.member.model.vo.Member;

public interface BoardDAO {

	// 민호 시작 ==========================


	List<Board> loadBoardList(int cPage, int numPerPage, Map<String, String> param);

	int selectBoardTotalContents(Map<String, String> param);

	List<BoardCategory> selectBoardCategory();

	List<Board> selectBoardNotice();
	
	Member getMemberByMemberId(String memberId);
	//==========================민호 끝
		
	// 하진 시작 ==========================
	List<Board> selectBoardList(String dong);
	List<Map<String, String>> loadBoardReportCategory();
	int insertBoardReport(Map<String, String> param);
	//========================== 하진 끝
		
	// 근호 시작 ==========================
	int insertBoard(Board board);

	int insertAttachment(Attachment a);
	
	//========================== 근호 끝
		
	// 지은 시작 ==========================
	Board selectOneBoard(int boardNo);

	int boardInCount(int boardNo);

	List<Attachment> selectAttachmentList(int boardNo);

	int deleteBoard(int boardNo);


	int boardUpdate(Board board);

	int insertBoardReputation(Map<String, String> map);
	
	
	
	//========================== 지은 끝
		
	// 예찬 시작 ==========================
		
	//========================== 예찬 끝
		
	// 주영 시작 ==========================
		
	//========================== 주영 끝
		
	// 현규 시작 ==========================
	int insertBoardComment(BoardComment bc);

	List<Map<String, String>> selectBoardCommentList(int boardNo, int cPage, int numPerPage);

	int deleteLevel1(int commentNo);

	int countComment(int boardNo);

	int deleteLevel2(int commentNo);

	int selectBoardLike(Map<String, String> map);

	




	//========================== 현규 끝


}
