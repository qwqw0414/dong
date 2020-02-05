package com.pro.dong.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.dong.board.model.vo.Board;
import com.pro.dong.board.model.vo.BoardCategory;
import com.pro.dong.member.model.vo.Address;
@Repository
public class BoardDAOImpl implements BoardDAO {

	static Logger log = LoggerFactory.getLogger(BoardDAOImpl.class);
	@Autowired
	SqlSessionTemplate sst;
	
	// 민호 시작 ==========================
	@Override
	public Address getAddrByMemberId(String memberId) {
		return sst.selectOne("board.getAddrByMemberId", memberId);
	}
	
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


	
	//==========================민호 끝
		
	// 하진 시작 ==========================
		
	//========================== 하진 끝
		
	// 근호 시작 ==========================
	@Override
	public int insertBoard(Board board) {
		return sst.insert("board.insertBoard", board);
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

	//========================== 지은 끝
		
	// 예찬 시작 ==========================
		
	//========================== 예찬 끝
		
	// 주영 시작 ==========================
		
	//========================== 주영 끝
		
	// 현규 시작 ==========================

	//========================== 현규 끝


}
