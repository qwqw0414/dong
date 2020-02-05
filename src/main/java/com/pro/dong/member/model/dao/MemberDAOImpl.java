package com.pro.dong.member.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.dong.member.model.vo.Address;
import com.pro.dong.member.model.vo.Member;

@Repository
public class MemberDAOImpl implements MemberDAO{
	
	static Logger log = LoggerFactory.getLogger(MemberDAOImpl.class);
	
	@Autowired
	SqlSessionTemplate sst;
	
	// 민호 시작 ==========================

	@Override
	public Map<String, String> selectMemberPoints(Member memberLoggedIn) {
		return sst.selectOne("member.selectMemberPoints", memberLoggedIn);
	}
	@Override
	public int updatePoint(Map<String, String> map) {
		log.debug("map={}",map);
		return sst.insert("member.updatePoint", map);
	}
	//==========================  민호 끝
	
	// 하진 시작 ==========================
	@Override
	public int byeMember(String memberId) {
		return sst.delete("member.byeMember", memberId);
	}
	
	@Override
	public Member selectDeleteOne(String memberId) {
		return sst.selectOne("member.selectDeleteOne", memberId);
	}
	//==========================  하진 끝
	
	// 근호 시작 ==========================
	@Override
	public Member selectLoginMember(String memberId) {
		return sst.selectOne("member.selectLoginMember", memberId);
	}
	//==========================  근호 끝
	
	// 지은 시작 ==========================
	@Override
	public int selectMember(Member m) {
		return sst.selectOne("member.selectMember",m);
	}

	@Override
	public int passwordUpdate(Member member) {
		return sst.update("member.passwordUpdate", member);
	}

	//==========================  지은 끝
	
	// 예찬 시작 ==========================
	@Override
	public int idDuplicate(String memberId) {
		return sst.selectOne("idDuplicate", memberId);
	}
	@Override
	public int insertMember(Member member) {
		return sst.insert("insertMember", member);
	}
	@Override
	public int insertAddress(Address address) {
		return sst.insert("insertAddress", address);
	}
	@Override
	public int insertValid(String memberId) {
		return sst.insert("insertValid", memberId);
	}
	
	@Override
	public int insertPoint(String memberId) {
		return sst.insert("insertPoint", memberId);
	}
	//==========================  예찬 끝

	
	// 주영 시작 ==========================
	@Override
	public Member selectMemberByName(Map<String, String> map) {
		return sst.selectOne("member.selectMemberByName", map);
	}
	//==========================  주영 끝

	
	// 현규 시작 ==========================
	@Override
	public Map<String, Object> selectOneMember(String memberId) {
		return sst.selectOne("member.selectOneMember", memberId);
	}
	@Override
	public int updateMemberName(Map<String, String> param) {
		return sst.update("member.updateMemberName",param);
	}
	
	//==========================  현규 끝
}
