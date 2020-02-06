package com.pro.dong.member.model.service;

import java.util.Map;

import com.pro.dong.member.model.vo.Address;
import com.pro.dong.member.model.vo.Member;

public interface MemberService {

	// 민호 시작 ==========================
	
	int updatePoint(Map<String, String> map);
	Map<String, String> selectMemberPoints(Member memberLoggedIn);
	
	//==========================  민호 끝
	
	// 하진 시작 ==========================
	int byeMember(String memberId);
	
	Member selectDeleteOne(String memberId);
	//==========================  하진 끝
	
	// 근호 시작 ==========================
	Member selectLoginMember(String memberId);
	//==========================  근호 끝
	
	// 지은 시작 ==========================
	int selectMember(Member m);

	int passwordUpdate(Member member);
	
	//==========================  지은 끝
	
	// 예찬 시작 ==========================
	int idDuplicate(String memberId);
	int insertMember(Member member);
	int insertAddress(Address address);
	int insertValid(String memberId);
	int insertPoint(String memberId);
	int insertShop(String memberId);

	//==========================  예찬 끝
	
	// 주영 시작 ==========================
	Member selectMemberByName(Member member);


	
	//==========================  주영 끝
	
	// 현규 시작 ==========================
	Map<String,Object> selectOneMember(String memberId);
	int updateMemberName(Map<String, String> param);
	int updateMemberPhone(Map<String, String> param);
	int updateMemberEmail(Map<String, String> param);


	
	
	//==========================  현규 끝
}
