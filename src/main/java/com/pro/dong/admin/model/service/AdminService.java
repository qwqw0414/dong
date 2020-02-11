package com.pro.dong.admin.model.service;

import java.util.List;
import java.util.Map;

import com.pro.dong.board.model.vo.BoardReport;
import com.pro.dong.member.model.vo.Member;
import com.pro.dong.product.model.vo.Product;

public interface AdminService {

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
	int selectBoardReportTotalContent(Map<String, String> param);
	Member selectMemberView(String memberId);
	
	int memberDelete(String memberId);
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
