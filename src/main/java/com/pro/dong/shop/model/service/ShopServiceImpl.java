package com.pro.dong.shop.model.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.member.model.service.MemberServiceImpl;
import com.pro.dong.shop.model.dao.ShopDAO;
import com.pro.dong.shop.model.vo.Shop;

@Service
public class ShopServiceImpl implements ShopService{

	static Logger log = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	ShopDAO sd;
	
	
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
		return sd.selectOneShop(memberId);
	}

	@Override
	public int updateShopInfo(Map<String, String> param) {
		return sd.updateShopInfo(param);
	}


	
	
	//========================== 주영 끝
	
	
	// 현규 시작 ==========================
	
	
	
	//========================== 현규 끝
	
}
