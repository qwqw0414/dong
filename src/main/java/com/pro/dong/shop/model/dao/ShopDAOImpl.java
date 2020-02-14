package com.pro.dong.shop.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
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
	@Override
	public int isFollowing(Map<String, String> param) {
		return sst.selectOne("shop.isFollowing", param);
	}
	@Override
	public int shopUnfollow(Map<String, String> param) {
		return sst.delete("shop.shopUnfollow", param);
	}
	@Override
	public int shopFollow(Map<String, String> param) {
		return sst.insert("shop.shopfollow", param);
	}
	@Override
	public int selectselectFollowListCount(String follow) {
		return sst.selectOne("shop.selectselectFollowListCount",follow);
	}
	@Override
	public List<Map<String, String>> selectFollowList(String follow, int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("shop.selectFollowList", follow, rowBounds);
	}
	@Override
	public int selectselectFollowerListCount(String follower) {
		return sst.selectOne("shop.selectselectFollowerListCount", follower);
	}
	@Override
	public List<Map<String, String>> selectFollowerList(String follower, int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("shop.selectFollowerList",follower, rowBounds);
	}
	//========================== 민호 끝
	
	
	// 하진 시작 ==========================
	@Override
	public List<Map<String, String>> loadMyProductList(String memberId, int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("shop.loadMyProductList",memberId,rowBounds);
	}
	@Override
	public int totalCountMyProduct(String memberId) {
		return sst.selectOne("shop.totalCountMyProduct",memberId);
	}
	@Override
	public int productUpdate(String productNo) {
		return sst.update("shop.productUpdate",productNo);
	}
	@Override
	public int productDelete(String productNo) {
		return sst.delete("shop.productDelete",productNo);
	}
	@Override
	public int saleStatus(Map<String, String> param) {
		return sst.update("shop.saleStatus",param);
	}
	//========================== 하진 끝
	
	
	// 근호 시작 ==========================
	
	
	
	//========================== 근호 끝
	
	
	// 지은 시작 ==========================
	
	@Override
	public int selectOpenDate(String memberId) {
		return sst.selectOne("shop.selectOpenDate", memberId);
	}
	
	@Override
	public int shopInCount(int shopNo) {
		return sst.update("shop.shopInCount", shopNo);
	}
	//========================== 지은 끝
	
	
	// 예찬 시작 ==========================
	@Override
	public List<Shop> searchShop(Map<String,String> param) {
		return sst.selectList("shop.searchShop", param);
	}
	@Override
	public Shop selectOneShopByShopNo(int shopNo) {
		return sst.selectOne("shop.selectOneShopByShopNo", shopNo);
	}
	
	
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

	@Override
	public int insertShopInquriy(Map<String, String> param) {
		return sst.insert("shop.insertShopInquriy", param);
	}

	@Override
	public int deleteShopInquriy(int deleteCommentBtn) {
		return sst.delete("shop.deleteShopInquriy", deleteCommentBtn);
	}

	@Override
	public int selectTotalInpuiry(int shopNo) {
		return sst.selectOne("shop.selectTotalInpuiry", shopNo);
	}
	
	@Override
	public int insertInquiryComment(Map<String, String> param) {
		return sst.insert("shop.insertInquiryComment", param);
	}
	
	@Override
	public Map<String, String> selectShopByShopNo(int shopNo) {
		return sst.selectOne("shop.selectShopByShopNo", shopNo);
	}
	
	@Override
	public List<Map<String, Object>> selectMyWishList(String memberId, int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("shop.selectMyWishList", memberId, rowBounds);
	}
	@Override
	public int selectMyWishListTotalContents(String memberId) {
		return sst.selectOne("shop.selectMyWishListTotalContents", memberId);
	}
	
	@Override
	public int deleteWishProduct(Map<String, String> param) {
		return sst.delete("shop.deleteWishProduct", param);
	}
	
	@Override
	public int deleteShopInquriyComment(int deleteCommentBtn) {
		return sst.delete("shop.deleteShopInquriyComment", deleteCommentBtn);
	}
	
	
	
	
	
	
	
	//========================== 주영 끝
	
	
	// 현규 시작 ==========================
	
	
	
	//========================== 현규 끝
	
}
