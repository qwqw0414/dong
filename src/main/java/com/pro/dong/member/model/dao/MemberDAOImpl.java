package com.pro.dong.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.dong.member.model.vo.Member;
import com.pro.dong.product.model.vo.OrderList;

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
	@Override
	public int orderListTotalContents(Map<String, String> param) {
		return sst.selectOne("member.orderListTotalContents", param);
	}
	@Override
	public List<OrderList> loadOrderList(Map<String, String> param, int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sst.selectList("member.loadOrderList", param, rowBounds);
	}
	@Override
	public int updateReceive(int orderNo) {
		return sst.update("member.updateReceive", orderNo);
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
	@Override
	public int emailDuplicate(String email) {
		return sst.selectOne("member.emailDuplicate", email);
	}
	@Override
	public int updateAddress(Map<String, String> param) {
		return sst.update("member.updateAddress", param);
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
	public int insertShop(String memberId) {
		return sst.insert("insertShop", memberId);
	}
	@Override
	public Member selectAddress(String memberId) {
		return sst.selectOne("selectAddress", memberId);
	}
	//==========================  예찬 끝

	
	// 주영 시작 ==========================
	@Override
	public Member selectMemberByName(Member member) {
		return sst.selectOne("member.selectMemberByName", member);
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
	@Override
	public int updateMemberPhone(Map<String, String> param) {
		return sst.update("member.updateMemberPhone",param);
	}
	@Override
	public int updateMemberEmail(Map<String, String> param) {
		return sst.update("member.updateMemberEmail",param);
	}

	@Override
	public List<Map<String, String>> selectAllDetails(String memberId, int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sst.selectList("member.selectChargingDetails", memberId,rowBounds);
	}
	@Override
	public int countDetails(String memberId) {
		return sst.selectOne("member.countDetails",memberId);
	}
	@Override
	public List<Map<String, String>> selectDetailsByOption(Map<String, String> param, int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sst.selectList("member.selectDetailsByOption", param,rowBounds);
	}
	@Override
	public int countDetailsByOption(Map<String, String> param) {
		return sst.selectOne("member.countDetailsByOption",param);
	}
	
	
	
	
	
	
	//==========================  현규 끝
}
