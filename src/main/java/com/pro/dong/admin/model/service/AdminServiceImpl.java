package com.pro.dong.admin.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.admin.model.dao.AdminDAO;
import com.pro.dong.board.model.service.BoardServiceImpl;
import com.pro.dong.board.model.vo.BoardReport;
import com.pro.dong.member.model.vo.Member;
import com.pro.dong.product.model.vo.Product;

@Service
public class AdminServiceImpl implements AdminService {

	static Logger log = LoggerFactory.getLogger(AdminServiceImpl.class);
	@Autowired
	AdminDAO ad;

	// 민호 시작 ==========================
	@Override
	public int selectProductTotalContents(Map<String, String> param) {
		return ad.selectProductTotalContents(param);
	}
	@Override
	public List<Product> loadProductList(int cPage, int numPerPage, Map<String, String> param) {
		return ad.loadProductList(cPage, numPerPage, param);
	}
	@Override
	public List<String> selectAddressSido() {
		return ad.selectAddressSido();
	}
	@Override
	public List<String> selectAddressSigungu(String sido) {
		return ad.selectAddressSigungu(sido);
	}
	@Override
	public List<String> selectAddressDong(String sigungu) {
		return ad.selectAddressDong(sigungu);
	}
	// ==========================민호 끝

	// 하진 시작 ==========================
	@Override
	public List<Member> selectMemberList(int cPage, int numPerPage, Map<String, String> param) {
		return ad.selectMemberList(cPage,numPerPage,param);
	}
	@Override
	public int selectMemberTotalContent(Map<String, String> param) {
		return ad.selectMemberTotalContent(param);
	}
	@Override
	public List<BoardReport> selectOneMember(int cPage, int numPerPage, Map<String, String> param) {
		return ad.selectOneMember(cPage,numPerPage,param);
	}
	@Override
	public int selectBoardReportTotalContent(Map<String, String> param) {
		return ad.adselectBoardReportTotalContent(param);
	}
	@Override
	public Member selectMemberView(String memberId) {
		return ad.selectMemberView(memberId);
	}
	
	@Override
	public int memberDelete(String memberId) {
		return ad.memberDelete(memberId);
	}
	// ========================== 하진 끝

	// 근호 시작 ==========================

	// ========================== 근호 끝

	// 지은 시작 ==========================
	@Override
	public List<Member> selectMemberPoint(String memberId) {
		return ad.selectMemberPoint(memberId);
	}
	@Override
	public int selectMemberPointTotal(Map<String, String> param) {
		return ad.selectMemberPointTotal(param);
	}
	@Override
	public List<Map<String, String>> selectMemberPointList(int cPage, int numPerPage, Map<String, String> param) {
		return ad.selectMemberPointList(cPage,numPerPage,param);
	}
	@Override
	public int selectMemberOrderTotal(Map<String, String> param) {
		return ad.selectMemberOrderTotal(param);
	}
	@Override
	public List<Map<String, String>> selectMemberOrderList(int cPage, int numPerPage, Map<String, String> param) {
		return ad.selectMemberOrderList(cPage,numPerPage,param);
	}
	// ========================== 지은 끝

	// 예찬 시작 ==========================

	// ========================== 예찬 끝

	// 주영 시작 ==========================
	@Override
	public int selectBoardTotalContents(Map<String, String> param) {
		return ad.selectBoardTotalContents(param);
	}
	@Override
	public List<Product> loadBoardList(int cPage, int numPerPage, Map<String, String> param) {
		return ad.loadBoardList(cPage, numPerPage, param);
	}
	@Override
	public int selectReportBoardTotalContents(Map<String, String> param) {
		return ad.selectReportBoardTotalContents(param);
	}
	@Override
	public List<Product> loadReportBoardList(int cPage, int numPerPage, Map<String, String> param) {
		return ad.loadReportBoardList(cPage, numPerPage, param);
	}
	@Override
	public int selectProductReportTotalContents(Map<String, String> param) {
		return ad.selectProductReportTotalContents(param);
	}
	@Override
	public List<Product> loadProductReportList(int cPage, int numPerPage, Map<String, String> param) {
		return ad.loadProductReportList(cPage, numPerPage, param);
	}
	@Override
	public Map<String, String> selectOneProductReport(int boardNo) {
		return ad.selectOneProductReport(boardNo);
	}
	// ========================== 주영 끝
	
	
	
	
	

	// 현규 시작 ==========================

	// ========================== 현규 끝
}
