package com.pro.dong.shop.model.service;

import java.util.List;
import java.util.Map;

import com.pro.dong.shop.model.vo.Shop;
import com.pro.dong.shop.model.vo.ShopInquriy;

public interface ShopService {

	// 민호 시작 ==========================
	int shopFollow(Map<String, String> param);
	int isFollowing(Map<String, String> param);
	int shopUnfollow(Map<String, String> param);
	int selectselectFollowListCount(String follow);
	List<Map<String, String>> selectFollowList(String follow, int cPage, int numPerPage);
	int selectselectFollowerListCount(String follower);
	List<Map<String, String>> selectFollowerList(String follower, int cPage, int numPerPage);
	//========================== 민호 끝
	
	
	// 하진 시작 ==========================
	List<Map<String, String>> loadMyProductList(String memberId, int cPage, int numPerPage);
	int totalCountMyProduct(String memberId);
	
	//========================== 하진 끝
	
	
	// 근호 시작 ==========================
	
	
	
	//========================== 근호 끝
	
	
	// 지은 시작 ==========================
	Map<String, String> shopInCount(int shopNo);
	
	int selectOpenDate(String memberId);
	
	//========================== 지은 끝
	
	
	// 예찬 시작 ==========================
	List<Shop> searchShop(Map<String,String> param);
	Shop selectOneShopByShopNo(int shopNo);
	
	//========================== 예찬 끝
	
	
	// 주영 시작 ==========================
	Map<String, String> selectOneShop(String memberId);

	int updateShopInfo(Map<String, String> param);

	int selectShopNameCheck(Map<String, String> param);

	int updateShopName(Map<String, String> param);

	int updateShopImg(Shop s);

	List<ShopInquriy> selectShopInquiry(int shopNo);

	int insertShopInquriy(Map<String, String> param);

	int deleteShopInquriy(int deleteCommentBtn);

	int selectTotalInpuiry(int shopNo);
	
	int insertInquiryComment(Map<String, String> param);
	
	Map<String, String> selectShopByShopNo(int shopNo);
	
	List<Map<String, Object>> selectMyWishList(String memberId, int cPage, int numPerPage);
	
	int selectMyWishListTotalContents(String memberId);
	
	int deleteWishProduct(Map<String, String> param);
	
	int deleteShopInquriyComment(int deleteCommentBtn);
	
	
	
	
	
	//========================== 주영 끝
	
	
	// 현규 시작 ==========================
	
	
	
	//========================== 현규 끝
	
}
