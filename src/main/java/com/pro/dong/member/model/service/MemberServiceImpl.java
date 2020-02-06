package com.pro.dong.member.model.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.member.model.dao.MemberDAO;
import com.pro.dong.member.model.vo.Address;
import com.pro.dong.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{

	static Logger log = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	MemberDAO md;

	
	// 민호 시작 ==========================

	@Override
	public Map<String, String> selectMemberPoints(Member memberLoggedIn) {
		return md.selectMemberPoints(memberLoggedIn);
	}
	
	@Override
	public int updatePoint(Map<String, String>map) {
		return md.updatePoint(map);
	}

	//==========================  민호 끝
	
	// 하진 시작 ==========================
	@Override
	public int byeMember(String memberId) {
		return md.byeMember(memberId);
	}
	
	@Override
	public Member selectDeleteOne(String memberId) {
		return md.selectDeleteOne(memberId);
	}
	//==========================  하진 끝
	
	// 근호 시작 ==========================
	@Override
	public Member selectLoginMember(String memberId) {
		return md.selectLoginMember(memberId);
	}
	//==========================  근호 끝
	
	// 지은 시작 ==========================
	@Override
	public int selectMember(Member m) {
		return md.selectMember(m);
	}
	
	@Override
	public int passwordUpdate(Member member) {
		return md.passwordUpdate(member);
	}
	
	//==========================  지은 끝
	
	// 예찬 시작 ==========================
	@Override
	public int idDuplicate(String memberId) {
		return md.idDuplicate(memberId);
	}
	@Override
	public int insertMember(Member member) {
		return md.insertMember(member);
	}
	@Override
	public int insertAddress(Address address) {
		return md.insertAddress(address);
	}
	@Override
	public int insertValid(String memberId) {
		return md.insertValid(memberId);
	}
	@Override
	public int insertShop(String memberId) {
		return md.insertShop(memberId);
	}
	
	@Override
	public int insertPoint(String memberId) {
		return md.insertPoint(memberId);
	}
	@Override
	public Address selectAddress(String memberId) {
		return md.selectAddress(memberId);
	}
	//==========================  예찬 끝

	// 주영 시작 ==========================
	@Override
	public Member selectMemberByName(Member member) {
		return md.selectMemberByName(member);
	}
	//==========================  주영 끝

	// 현규 시작 ==========================
	
	@Override
	public Map<String, Object> selectOneMember(String memberId) {
		return md.selectOneMember(memberId);
	}
	@Override
	public int updateMemberName(Map<String, String> param) {
		return md.updateMemberName(param);
	}
	@Override
	public int updateMemberPhone(Map<String, String> param) {
		return md.updateMemberPhone(param);
	}
	@Override
	public int updateMemberEmail(Map<String, String> param) {
		return md.updateMemberEmail(param);
	}
	//==========================  현규 끝





	
}
