package com.pro.dong.shop.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.member.model.service.MemberServiceImpl;
import com.pro.dong.shop.model.dao.ShopDAO;
import com.pro.dong.shop.model.vo.Shop;
import com.pro.dong.shop.model.vo.ShopInquriy;

@Service
public class ShopServiceImpl implements ShopService{

	static Logger log = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	ShopDAO sd;
	
	
	// 민호 시작 ==========================
	@Override
	public int shopFollow(Map<String, String> param) {
		return sd.shopFollow(param);
	}
	@Override
	public int isFollowing(Map<String, String> param) {
		return sd.isFollowing(param);
	}
	@Override
	public int shopUnfollow(Map<String, String> param) {
		return sd.shopUnfollow(param);
	}
	
	//========================== 민호 끝
	
	
	// 하진 시작 ==========================
	@Override
	public List<Map<String, String>> loadMyProductList(String memberId, int cPage, int numPerPage) {
		return sd.loadMyProductList(memberId,cPage,numPerPage);
	}
	@Override
	public int totalCountMyProduct(String memberId) {
		return sd.totalCountMyProduct(memberId);
	}

	
	
	//========================== 하진 끝
	
	
	// 근호 시작 ==========================
	
	
	
	//========================== 근호 끝
	
	
	// 지은 시작 ==========================
	
	
	
	//========================== 지은 끝
	
	
	// 예찬 시작 ==========================
	@Override
	public List<Shop> searchShop(Map<String,String> param) {
		return sd.searchShop(param);
	}
	@Override
	public Shop selectOneShopByShopNo(int shopNo) {
		return sd.selectOneShopByShopNo(shopNo);
	}
	
	//========================== 예찬 끝
	
	
	// 주영 시작 ==========================
	@Override
	public Map<String, String> selectOneShop(String memberId) {
		return sd.selectOneShop(memberId);
	}
	
	@Override
	public Map<String, String> selectShopByShopNo(int shopNo) {
		return sd.selectShopByShopNo(shopNo);
	}

	@Override
	public int updateShopInfo(Map<String, String> param) {
		return sd.updateShopInfo(param);
	}

	@Override
	public int selectShopNameCheck(Map<String, String> param) {
		return sd.selectShopNameCheck(param);
	}

	@Override
	public int updateShopName(Map<String, String> param) {
		return sd.updateShopName(param);
	}

	@Override
	public int updateShopImg(Shop s) {
		return sd.updateShopImg(s);
	}

	@Override
	public List<ShopInquriy> selectShopInquiry(int shopNo) {
		return sd.selectShopInquiry(shopNo);
	}

	@Override
	public int insertShopInquriy(Map<String, String> param) {
		return sd.insertShopInquriy(param);
	}

	@Override
	public int deleteShopInquriy(int deleteCommentBtn) {
		return sd.deleteShopInquriy(deleteCommentBtn);
	}

	@Override
	public int selectTotalInpuiry(int shopNo) {
		return sd.selectTotalInpuiry(shopNo);
	}
	@Override
	public int insertInquiryComment(Map<String, String> param) {
		return sd.insertInquiryComment(param);
	}
	@Override
	public List<Map<String, Object>> selectMyWishList(String memberId) {
		return sd.selectMyWishList(memberId);
	}
	@Override
	public int selectMyWishListTotalContents(String memberId) {
		return sd.selectMyWishListTotalContents(memberId);
	}







	
	
	//========================== 주영 끝
	
	
	// 현규 시작 ==========================
	
	
	
	//========================== 현규 끝
	
}
