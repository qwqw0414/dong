package com.pro.dong.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.pro.dong.board.model.vo.BoardReport;
import com.pro.dong.member.model.vo.Member;
import com.pro.dong.product.model.vo.Product;

public interface AdminDAO {

	// 민호 시작 ==========================
	int selectProductTotalContents(Map<String, String> param);
	List<Product> loadProductList(int cPage, int numPerPage, Map<String, String> param);
	List<String> selectAddressSido();
	List<String> selectAddressSigungu(String sido);
	List<String> selectAddressDong(String sigungu);
	// ==========================민호 끝

	// 하진 시작 ==========================
	List<Member> selectMemberList(int cPage, int numPerPage, Map<String, String> param);
	int selectMemberTotalContent(Map<String, String> param);
	List<BoardReport> selectOneMember(int cPage, int numPerPage, Map<String, String> param);
	int adselectBoardReportTotalContent(Map<String, String> param);
	Member selectMemberView(String memberId);
	int memberDelete(String memberId);
	// ========================== 하진 끝

	// 근호 시작 ==========================

	// ========================== 근호 끝

	// 지은 시작 ==========================
	List<Member> selectMemberPoint(String memberId);
	int selectMemberPointTotal(Map<String, String> param);
	List<Map<String, String>> selectMemberPointList(int cPage, int numPerPage, Map<String, String> param);
	int selectMemberOrderTotal(Map<String, String> param);
	List<Map<String, String>> selectMemberOrderList(int cPage, int numPerPage, Map<String, String> param);
	// ========================== 지은 끝

	// 예찬 시작 ==========================

	// ========================== 예찬 끝

	// 주영 시작 ==========================
	int selectBoardTotalContents(Map<String, String> param);
	List<Product> loadBoardList(int cPage, int numPerPage, Map<String, String> param);
	int selectReportBoardTotalContents(Map<String, String> param);
	List<Product> loadReportBoardList(int cPage, int numPerPage, Map<String, String> param);
	int selectProductReportTotalContents(Map<String, String> param);
	List<Product> loadProductReportList(int cPage, int numPerPage, Map<String, String> param);
	Map<String, String> selectOneProductReport(int boardNo);
	int updateReportStatus(int reportNo);
	// ========================== 주영 끝

	
	

	// 현규 시작 ==========================

	// ========================== 현규 끝

}
