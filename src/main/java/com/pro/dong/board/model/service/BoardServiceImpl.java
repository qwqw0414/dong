package com.pro.dong.board.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.board.model.dao.BoardDAO;
import com.pro.dong.board.model.vo.Attachment;
import com.pro.dong.board.model.vo.Board;
import com.pro.dong.board.model.vo.BoardCategory;
import com.pro.dong.board.model.vo.BoardComment;
import com.pro.dong.member.model.vo.Member;
@Service
public class BoardServiceImpl implements BoardService {

	static Logger log = LoggerFactory.getLogger(BoardServiceImpl.class);
	@Autowired
	BoardDAO bd;
	
	// 민호 시작 ==========================
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
	@Override
	public List<Board> selectBoardNotice(Map<String, String> param) {
		return bd.selectBoardNotice(param);
	}
	@Override
	public Member getMemberByMemberId(String memberId) {
		return bd.getMemberByMemberId(memberId);
	}
	//==========================민호 끝
		
	// 하진 시작 ==========================
	@Override
	public List<Board> selectBoardList(String dong) {
		return bd.selectBoardList(dong);
	}
	@Override
	public List<Map<String, String>> loadBoardReportCategory() {
		return bd.loadBoardReportCategory();
	}
	@Override
	public int insertBoardReport(Map<String, String> param) {
		return bd.insertBoardReport(param);
	}
	//========================== 하진 끝
		
	// 근호 시작 ==========================
	@Override
	public int insertBoard(Board board, List<Attachment> attachList) {
		int result = 0;
		result = bd.insertBoard(board);
		
		//2. attachment 행추가
		if(attachList.size() > 0) {
			for(Attachment a : attachList) {
				a.setBoardNo(board.getBoardNo());
				result = bd.insertAttachment(a);
			}
		}
		return result;
	}
	//========================== 근호 끝
		
	// 지은 시작 ==========================
	@Override
	public Board selectOneBoard(int boardNo) {
		return bd.selectOneBoard(boardNo);
	}
	/*@Override
	public Board selectOneBoard(Map<String, String> param) {
		return bd.selectOneBoard(param);
	}*/
	@Override
	public int boardInCount(int boardNo) {
		return bd.boardInCount(boardNo);
	}
	@Override
	public Attachment selectAttachmentList(int boardNo) {
		return bd.selectAttachmentList(boardNo);
	}
	/*@Override
	public List<Attachment> selectAttachmentList(Map<String, String> param) {
		return bd.selectAttachmentList(param);
	}*/
	@Override
	public int deleteBoard(int boardNo) {
		return bd.deleteBoard(boardNo);
	}
	@Override
	public int boardUpdate(Board board) {
		return bd.boardUpdate(board);
	}
	@Override
	public int insertBoardReputation(Map<String, String> map) {
		return bd.insertBoardReputation(map);
	}
	@Override
	public int selectBoardLike(Map<String, String> map) {
		return bd.selectBoardLike(map);
	}
	@Override
	public int deleteBoardReputation(Map<String, String> map) {
		return bd.deleteBoardReputation(map);
	}
	@Override
	public int selectBoardLikeByMemberId(Map<String, String> map) {
		return bd.selectBoardLikeByMemberId(map);
	}
	//========================== 지은 끝
		
	// 예찬 시작 ==========================
		
	//========================== 예찬 끝
		
	// 주영 시작 ==========================
	@Override
	public List<Map<String, String>> selectBoardReportList(int boardNo) {
		return bd.selectBoardReportList(boardNo);
	}	
	@Override
	public int updateReportStatus(int reportNo) {
		return bd.updateReportStatus(reportNo);
	}
	//========================== 주영 끝
		
	// 현규 시작 ==========================
	@Override
	public int insertBoardComment(BoardComment bc) {
		return bd.insertBoardComment(bc);
	}
	@Override
	public List<Map<String, String>> selectBoardCommentList(int boardNo, int cPage, int numPerPage) {
		return bd.selectBoardCommentList(boardNo, cPage, numPerPage);
	}
	@Override
	public int deleteLevel1(int commentNo) {
		return bd.deleteLevel1(commentNo);
	}
	@Override
	public int countComment(int boardNo) {
		return bd.countComment(boardNo);
	}
	@Override
	public int deleteLevel2(int commentNo) {
		return bd.deleteLevel2(commentNo);
	}
	//========================== 현규 끝

	
}
