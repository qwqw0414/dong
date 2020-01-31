package com.pro.dong.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO{
	
	static Logger log = LoggerFactory.getLogger(MemberDAOImpl.class);
	
	@Autowired
	SqlSessionTemplate sst;
	
	// 민호 시작 ==========================
	
	//==========================  민호 끝
	
	// 하진 시작 ==========================
	
	//==========================  하진 끝
	
	// 근호 시작 ==========================
	
	//==========================  근호 끝
	
	// 지은 시작 ==========================
	
	//==========================  지은 끝
	
	// 예찬 시작 ==========================
	@Override
	public int idDuplicate(String memberId) {
		return sst.selectOne("idDuplicate", memberId);
	}
	//==========================  예찬 끝
	
	// 주영 시작 ==========================
	
	//==========================  주영 끝
	
	// 현규 시작 ==========================
	
	//==========================  현규 끝
}
