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
import com.pro.dong.product.model.vo.Product;

@Repository
public class AdminDAOImpl implements AdminDAO {

	static Logger log = LoggerFactory.getLogger(AdminDAOImpl.class);
	@Autowired
	SqlSessionTemplate sst;

	// 민호 시작 ==========================
	@Override
	public int selectProductTotalContents(Map<String, String> param) {
		return sst.selectOne("admin.selectProductTotalContents", param);
	}
	@Override
	public List<Product> loadProductList(int cPage, int numPerPage, Map<String, String> param) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("admin.loadProductList", param, rowBounds);
	}
	@Override
	public List<String> selectAddressSido() {
		return sst.selectList("admin.selectAddressSido");
	}
	@Override
	public List<String> selectAddressSigungu(String sido) {
		return sst.selectList("admin.selectAddressSigungu", sido);
	}
	@Override
	public List<String> selectAddressDong(String sigungu) {
		return sst.selectList("admin.selectAddressDong", sigungu);
	}
	// ==========================민호 끝

	// 하진 시작 ==========================
	@Override
	public List<Member> selectMemberList(int cPage, int numPerPage, Map<String, String> param) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("admin.selectMemberList",param,rowBounds);
	}
	@Override
	public int selectMemberTotalContent(Map<String, String> param) {
		return sst.selectOne("admin.selectMemberTotalContent", param);
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
	@Override
	public int memberDelete(String memberId) {
		return sst.delete("admin.memberDelete",memberId);
	}
	// ========================== 하진 끝

	// 근호 시작 ==========================

	// ========================== 근호 끝

	// 지은 시작 ==========================
	@Override
	public List<Member> selectMemberPoint(String memberId) {
		return sst.selectList("admin.selectMemberPoint",memberId);
	}
	@Override
	public int selectMemberPointTotal(Map<String, String> param) {
		return sst.selectOne("admin.selectMemberPointTotal",param);
	}
	@Override
	public List<Map<String, String>> selectMemberPointList(int cPage, int numPerPage, Map<String, String> param) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sst.selectList("admin.selectMemberPointList", param, rowBounds);
	}
	@Override
	public int selectMemberOrderTotal(Map<String, String> param) {
		return sst.selectOne("admin.selectMemberOrderTotal", param);
	}
	@Override
	public List<Map<String, String>> selectMemberOrderList(int cPage, int numPerPage, Map<String, String> param) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sst.selectList("admin.selectMemberOrderList", param,rowBounds);
	}
	
	// ========================== 지은 끝

	// 예찬 시작 ==========================

	// ========================== 예찬 끝

	// 주영 시작 ==========================
	@Override
	public int selectBoardTotalContents(Map<String, String> param) {
		return sst.selectOne("admin.selectBoardTotalContents", param);
	}
	@Override
	public List<Product> loadBoardList(int cPage, int numPerPage, Map<String, String> param) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("admin.loadBoardList", param, rowBounds);
	}
	@Override
	public int selectReportBoardTotalContents(Map<String, String> param) {
		return sst.selectOne("admin.selectReportBoardTotalContents", param);
	}
	@Override
	public List<Product> loadReportBoardList(int cPage, int numPerPage, Map<String, String> param) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("admin.loadReportBoardList", param, rowBounds);
	}
	@Override
	public int selectProductReportTotalContents(Map<String, String> param) {
		return sst.selectOne("admin.selectProductReportTotalContents", param);
	}
	@Override
	public List<Product> loadProductReportList(int cPage, int numPerPage, Map<String, String> param) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("admin.loadProductReportList", param, rowBounds);
	}
	@Override
	public Map<String, String> selectOneProductReport(int boardNo) {
		return sst.selectOne("admin.selectOneProductReport", boardNo);
	}
	@Override
	public int updateReportStatus(int reportNo) {
		return sst.update("admin.updateReportStatus", reportNo);
	}
	// ========================== 주영 끝
	
	
	

	// 현규 시작 ==========================

	// ========================== 현규 끝

}
