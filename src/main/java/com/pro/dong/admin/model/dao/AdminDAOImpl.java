package com.pro.dong.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.dong.board.model.dao.BoardDAOImpl;
import com.pro.dong.board.model.vo.BoardReport;
import com.pro.dong.member.model.vo.Member;

@Repository
public class AdminDAOImpl implements AdminDAO {

	static Logger log = LoggerFactory.getLogger(AdminDAOImpl.class);
	@Autowired
	SqlSessionTemplate sst;

	// 민호 시작 ==========================

	// ==========================민호 끝

	// 하진 시작 ==========================
	@Override
	public List<Member> selectMemberList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sst.selectList("admin.selectMemberList",null,rowBounds);
	}
	@Override
	public int selectMemberTotalContent() {
		return sst.selectOne("admin.selectMemberTotalContent");
	}
	@Override
	public List<BoardReport> selectOneMember(int cPage, int numPerPage, Map<String, String> param) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("admin.selectOneMember",param,rowBounds);
	}
	@Override
	public int adselectBoardReportTotalContent(Map<String, String> param) {
		return sst.selectOne("admin.adselectBoardReportTotalContent",param);
	}
	@Override
	public Member selectMemberView(String memberId) {
		return sst.selectOne("admin.selectMemberView",memberId);
	}
	// ========================== 하진 끝

	// 근호 시작 ==========================

	// ========================== 근호 끝

	// 지은 시작 ==========================

	// ========================== 지은 끝

	// 예찬 시작 ==========================

	// ========================== 예찬 끝

	// 주영 시작 ==========================

	// ========================== 주영 끝

	// 현규 시작 ==========================

	// ========================== 현규 끝

}
