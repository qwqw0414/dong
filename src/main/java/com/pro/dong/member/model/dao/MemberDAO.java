package com.pro.dong.member.model.dao;

import java.util.Map;

import com.pro.dong.member.model.vo.Address;
import com.pro.dong.member.model.vo.Member;

public interface MemberDAO {

	
	// 민호 시작 ==========================
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
	Member selectMember(Map<String, String> map);
	
	int passwordUpdate(String memberId);
	
	//==========================  지은 끝
	
	// 예찬 시작 ==========================
	int idDuplicate(String memberId);

	int insertMember(Member member);

	int insertAddress(Address address);

	int insertValid(String memberId);

	int insertPoint(String memberId);



	//==========================  예찬 끝
	
	// 주영 시작 ==========================
	Member selectMemberByName(Member member);
	//==========================  주영 끝

	
	// 현규 시작 ==========================
	
	//==========================  현규 끝
	
}
