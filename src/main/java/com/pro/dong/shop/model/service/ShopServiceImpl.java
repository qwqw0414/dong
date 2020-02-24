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
	@Override
	public int selectFollowListCount(String follow) {
		return sd.selectFollowListCount(follow);
	}
	@Override
	public List<Map<String, String>> selectFollowList(String follow, int cPage, int numPerPage) {
		return sd.selectFollowList(follow,cPage,numPerPage);
	}
	@Override
	public int selectFollowerListCount(String follower) {
		return sd.selectFollowerListCount(follower);
	}
	@Override
	public List<Map<String, String>> selectFollowerList(String follower, int cPage, int numPerPage) {
		return sd.selectFollowerList(follower,cPage,numPerPage);
	}
	@Override
	public List<Map<String, String>> loadReviewGrade() {
		return sd.loadReviewGrade();
	}
	@Override
	public Shop selectOneShopByShopName(String shopName) {
		return sd.selectOneShopByShopName(shopName);
	}
	@Override
	public int insertReview(Map<String, String> param) {
		return sd.insertReview(param);
	}
	@Override
	public List<Map<String, String>> loadShopReview(Map<String, String> param, int cPage, int numPerPage) {
		return sd.loadShopReview(param,cPage,numPerPage);
	}
	@Override
	public int selectShopReviewListCount(Map<String, String> param) {
		return sd.selectShopReviewListCount(param);
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
	@Override
	public int productUpdate(String productNo) {
		return sd.productUpdate(productNo);
	}
	@Override
	public int productDelete(String productNo) {
		return sd.productDelete(productNo);
	}
	@Override
	public int saleStatus(Map<String, String> param) {
		return sd.saleStatus(param);
	}
	@Override
	public int totalProductContents(Map<String, String> param) {
		return sd.totalProductContents(param);
	}
	@Override
	public List<Map<String, String>> loadMyProductManage(int cPage, int numPerPage, Map<String, String> param) {
		return sd.loadMyProductManage(cPage,numPerPage,param);
	}
	//========================== 하진 끝
	
	
	// 근호 시작 ==========================
	
	
	
	//========================== 근호 끝
	
	
	// 지은 시작 ==========================
	
	@Override
	public int selectOpenDate(String memberId) {
		return sd.selectOpenDate(memberId);
	}
	
	@Override
	public int shopInCount(int shopNo) {
		return sd.shopInCount(shopNo);
	}
	
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
	public List<Map<String, Object>> selectMyWishList(String memberId, int cPage, int numPerPage) {
		return sd.selectMyWishList(memberId, cPage, numPerPage);
	}
	
	@Override
	public int selectMyWishListTotalContents(String memberId) {
		return sd.selectMyWishListTotalContents(memberId);
	}
	
	@Override
	public int deleteWishProduct(Map<String, String> param) {
		return sd.deleteWishProduct(param);
	}
	@Override
	public int deleteShopInquriyComment(int deleteCommentBtn) {
		return sd.deleteShopInquriyComment(deleteCommentBtn);
	}

	
	
	
	
	







	
	
	//========================== 주영 끝
	
	
	// 현규 시작 ==========================
	
	
	
	//========================== 현규 끝
	
}
