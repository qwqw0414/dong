package com.pro.dong.shop.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.dong.member.model.dao.MemberDAOImpl;
import com.pro.dong.shop.model.vo.Shop;
import com.pro.dong.shop.model.vo.ShopInquriy;

@Repository
public class ShopDAOImpl implements ShopDAO{

	static Logger log = LoggerFactory.getLogger(MemberDAOImpl.class);
	
	@Autowired
	SqlSessionTemplate sst;
	
	
	// 민호 시작 ==========================
	
	
	
	//========================== 민호 끝
	
	
	// 하진 시작 ==========================
	
	
	
	//========================== 하진 끝
	
	
	// 근호 시작 ==========================
	
	
	
	//========================== 근호 끝
	
	
	// 지은 시작 ==========================
	
	
	
	//========================== 지은 끝
	
	
	// 예찬 시작 ==========================
	
	
	
	//========================== 예찬 끝
	
	
	// 주영 시작 ==========================
	@Override
	public Map<String, String> selectOneShop(String memberId) {
		return sst.selectOne("shop.selectOneShop", memberId);
	}

	@Override
	public int updateShopInfo(Map<String, String> param) {
		return sst.update("shop.updateShopInfo", param);
	}

	@Override
	public int selectShopNameCheck(Map<String, String> param) {
		return sst.selectOne("shop.selectShopNameCheck", param);
	}

	@Override
	public int updateShopName(Map<String, String> param) {
		return sst.update("shop.updateShopName", param);
	}

	@Override
	public int updateShopImg(Shop s) {
		return sst.update("shop.updateShopImg", s);
	}

	@Override
	public List<ShopInquriy> selectShopInquiry(int shopNo) {
		return sst.selectList("shop.selectShopInquiry", shopNo);
	}

	
	
	//========================== 주영 끝
	
	
	// 현규 시작 ==========================
	
	
	
	//========================== 현규 끝
	
}
