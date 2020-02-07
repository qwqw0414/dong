package com.pro.dong.admin.model.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.admin.model.dao.AdminDAO;
import com.pro.dong.board.model.service.BoardServiceImpl;
import com.pro.dong.board.model.vo.BoardReport;
import com.pro.dong.member.model.vo.Member;

@Service
public class AdminServiceImpl implements AdminService {

	static Logger log = LoggerFactory.getLogger(AdminServiceImpl.class);
	@Autowired
	AdminDAO ad;

	// 민호 시작 ==========================

	// ==========================민호 끝

	// 하진 시작 ==========================
	@Override
	public List<Member> selectMemberList() {
		return ad.selectMemberList();
	}
	@Override
	public List<BoardReport> selectOneMember(String memberId) {
		return ad.selectOneMember(memberId);
	}
	@Override
	public Member selectMemberView(String memberId) {
		return ad.selectMemberView(memberId);
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
