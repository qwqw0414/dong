package com.pro.dong.product.model.service;

import java.util.List;
import java.util.Map;

import com.pro.dong.board.model.vo.BoardComment;
import com.pro.dong.member.model.vo.Member;
import com.pro.dong.product.model.vo.Category;
import com.pro.dong.product.model.vo.Like;
import com.pro.dong.product.model.vo.OrderList;
import com.pro.dong.product.model.vo.Product;
import com.pro.dong.product.model.vo.ProductAttachment;
import com.pro.dong.product.model.vo.ProductComment;
import com.pro.dong.shop.model.vo.Shop;

public interface ProductService {

	//민호 시작 ==========================
	int submitPurchase(OrderList orderList);
	int updateMemberPoint(OrderList orderList);
	Member selectOneMember(String memberId);
	//==========================민호 끝
		
	//하진 시작 ==========================
	List<Map<String, String>> productStatus(Map<String, String> param);
	int deleteProduct(int productNo);
	//========================== 하진 끝
		
	//근호 시작 ==========================
	int incount(int productNo);

	//========================== 근호 끝
		
	//지은 시작 ==========================
	Member selectShopMember(int productNo);

	//========================== 지은 끝
		
	//예찬 시작 ==========================
	List<Category> selectCategory(Category category);	
	Shop selectOneShop(String memberId);
	int insertProduct(Product product, List<ProductAttachment> attachList);
	List<Map<String, String>> selectProductListTop10(String categoryId);
	List<Map<String, String>> selectProduct(int cPage, int numPerPage, Map<String, String> param);
	int countProduct(Map<String, String> param);
	Map<String, Object> selectOneProduct(int productNo);
	int countLike(Like like);
	int insertLike(Like like);
	int deleteLike(Like like);
	List<Map<String, String>> selectAd(Member member);
	int filesUpdate(Map<String, String> param, String type);
	int deleteAttachment(String fileName);
	List<Map<String, String>> autocomplete(Map<String, String> param, int type);
	//========================== 예찬 끝

	//주영 시작 ==========================
	List<Map<String, String>> loadProductReportCategory();
	int insertProductReport(Map<String, String> param);
	List<Map<String, String>> selectProductByProductNo(int productNo);
	int delImg(String delImgName);
	int deleteOldImgName(Map<String, String> param);
	int insertNewImg(Map<String, String> param);
	int productUpdateEnd(Map<String, String> param);
	List<Map<String, String>> selectProductCategory(int productNo);
	List<Category> selectCategoryRef(String categoryRef);
	//========================== 주영 끝
		
	//현규 시작 ==========================
	int insertProductComment(ProductComment pc);
	List<Map<String, String>> selectProductCommentList(int productNo, int cPage, int numPerPage);
	int deleteLevel1(int commentNo);
	int countComment(int boardNo);
	int deleteLevel2(int commentNo);
	//========================== 현규 끝
	
}
