package com.pro.dong.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.dong.board.model.vo.Attachment;
import com.pro.dong.board.model.vo.Board;
import com.pro.dong.board.model.vo.BoardCategory;
import com.pro.dong.board.model.vo.BoardComment;
import com.pro.dong.member.model.vo.Member;
@Repository
public class BoardDAOImpl implements BoardDAO {

	static Logger log = LoggerFactory.getLogger(BoardDAOImpl.class);
	@Autowired
	SqlSessionTemplate sst;
	
	// 민호 시작 ==========================
	
	@Override
	public int selectBoardTotalContents(Map<String, String> param) {
		return sst.selectOne("board.selectBoardTotalContents", param);
	}

	@Override
	public List<Board> loadBoardList(int cPage, int numPerPage, Map<String, String> param) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("board.loadBoardList", param, rowBounds);

	}

	@Override
	public List<BoardCategory> selectBoardCategory() {
		return sst.selectList("board.selectBoardCategory");
	}

	@Override
	public List<Board> selectBoardNotice() {
		return sst.selectList("board.selectBoardNotice");
	}
	
	@Override
	public Member getMemberByMemberId(String memberId) {
		return sst.selectOne("board.getMemberByMemberId", memberId);
	}
	
	//==========================민호 끝
		
	// 하진 시작 ==========================
	@Override
	public List<Board> selectBoardList() {
		return sst.selectList("board.selectBoardList");
	}
	@Override
	public List<Map<String, String>> loadBoardReportCategory() {
		return sst.selectList("board.loadBoardReportCategory");
	}
	@Override
	public int insertBoardReport(Map<String, String> param) {
		return sst.insert("board.insertBoardReport",param);
	}
	//========================== 하진 끝
		
	// 근호 시작 ==========================
	@Override
	public int insertBoard(Board board) {
		return sst.insert("board.insertBoard", board);
	}

	@Override
	public int insertAttachment(Attachment a) {
		return sst.insert("board.insertAttachment", a);
	}

	//========================== 근호 끝
		
	// 지은 시작 ==========================
	@Override
	public Board selectOneBoard(int boardNo) {
		return sst.selectOne("board.selectOneBoard", boardNo);
	}

	@Override
	public int boardInCount(int boardNo) {
		return sst.update("board.boardInCount", boardNo);
	}

	@Override
	public List<Attachment> selectAttachmentList(int boardNo) {
		return sst.selectList("board.selectAttachmentList", boardNo);
	}

	@Override
	public int deleteBoard(int boardNo) {
		return sst.delete("board.deleteBoard", boardNo);
	}


	@Override
	public int boardUpdate(Board board) {
		return sst.update("board.boardUpdate", board);
	}
	

	@Override
	public int insertBoardReputation(Map<String, String> map) {
		return sst.insert("board.insertBoardReputation", map);
	}
	
	@Override
	public int selectBoardLike(Map<String, String> map) {
		return sst.selectOne("board.selectBoardLike", map);
	}

	
	//========================== 지은 끝
		
	// 예찬 시작 ==========================
		
	//========================== 예찬 끝
		
	// 주영 시작 ==========================
		
	//========================== 주영 끝
		
	// 현규 시작 ==========================
	@Override
	public int insertBoardComment(BoardComment bc) {
		return sst.insert("board.insertBoardComment",bc);
	}

	@Override
	public List<Map<String, String>> selectBoardCommentList(int boardNo, int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sst.selectList("board.selectBoardCommentList", boardNo, rowBounds);
	}

	@Override
	public int deleteLevel1(int commentNo) {
		return sst.delete("board.deleteLevel1",commentNo);
	}

	@Override
	public int countComment() {
		return sst.selectOne("board.countComment");
	}

	@Override
	public int deleteLevel2(int commentNo) {
		return sst.delete("board.deleteLevel2",commentNo);
	}

	
	



	



	//========================== 현규 끝


}
