package com.pro.dong.product.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.pro.dong.member.model.vo.Member;
import com.pro.dong.product.model.dao.ProductDAO;
import com.pro.dong.product.model.vo.Category;
import com.pro.dong.product.model.vo.Like;
import com.pro.dong.product.model.vo.OrderList;
import com.pro.dong.product.model.vo.Product;
import com.pro.dong.product.model.vo.ProductAttachment;
import com.pro.dong.product.model.vo.ProductComment;
import com.pro.dong.shop.model.vo.Shop;

@Service
public class ProductServiceImpl implements ProductService{

	static final Logger log = LoggerFactory.getLogger(ProductServiceImpl.class);
	
	@Autowired
	ProductDAO pd;
	
	//민호 시작 ==========================
	@Override
	public int submitPurchase(OrderList orderList) {
		return pd.submitPurchase(orderList);
	}
	@Override
	public int updateMemberPoint(OrderList orderList) {
		return pd.updateMemberPoint(orderList);
	}
	@Override
	public Member selectOneMember(String memberId) {
		return pd.selectOneMember(memberId);
	}
	//==========================민호 끝
		
	//하진 시작 ==========================
	@Override
	public List<Map<String, String>> productStatus(Map<String, String> param) {
		return pd.productStatus(param);
	}
	@Override
	public int deleteProduct(int productNo) {
		return pd.deleteProduct(productNo);
	}
	
	//========================== 하진 끝
		
	//근호 시작 ==========================
	@Override
	public int incount(int productNo) {
		return pd.incount(productNo);
	}
	//========================== 근호 끝
		
	//지은 시작 ==========================
	@Override
	public Member selectShopMember(int productNo) {
		return pd.selectShopMember(productNo);
	}
	//========================== 지은 끝
		
	//예찬 시작 ==========================
	@Override
	public int deleteAttachment(String fileName) {
		return pd.deleteAttachment(fileName);
	}
	@Override
	public List<Category> selectCategory(Category category) {
		return pd.selectCategory(category);
	}	
	@Override
	public Shop selectOneShop(String memberId) {
		return pd.selectOneShop(memberId);
	}
	@Transactional(propagation=Propagation.REQUIRED,
			   isolation=Isolation.READ_COMMITTED,
			   rollbackFor=Exception.class)
	@Override
	public int insertProduct(Product product, List<ProductAttachment> attachList) {
		
		int result = pd.insertProduct(product);
		result = pd.insertStatus(product);
		String thumbnail = "Y";
		
		for(ProductAttachment pa : attachList) {
			pa.setThumbnail(thumbnail);
			pd.insertAttachment(pa);

			if("Y".equals(thumbnail)) thumbnail = "N";
		}
		
		return result;
	}
	@Override
	public List<Map<String, String>> selectProductListTop10(String categoryId) {
		return pd.selectProductListTop10(categoryId);
	}
	@Override
	public List<Map<String, String>> selectProduct(int cPage, int numPerPage, Map<String, String> param) {
		return pd.selectProduct(cPage, numPerPage, param);
	}
	@Override
	public int countProduct(Map<String, String> param) {
		return pd.countProduct(param);
	}
	@Override
	public Map<String, Object> selectOneProduct(int productNo) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("product", pd.selectOneProduct(productNo));
		map.put("attachment", pd.selectAttachment(productNo));
		
		return map;
	}
	@Override
	public int countLike(Like like) {
		return pd.countLike(like);
	}
	@Override
	public int insertLike(Like like) {
		return pd.insertLike(like);
	}
	@Override
	public int deleteLike(Like like) {
		return pd.deleteLike(like);
	}
	@Override
	public List<Map<String, String>> selectAd(Member member) {
		return pd.selectAd(member);
	}
	@Override
	public int filesUpdate(Map<String, String> param, String type) {
		int result = 0;
		
		if(type.equals("insert")) {
			result = pd.insertAttachment(param);
		}
		else if(type.equals("update")) {
			result = pd.updateAttachment(param);
		}
		else if(type.equals("delete")) {
			result = pd.deleteAttachment(param);
		}
		
		return result;
	}
	@Override
	public List<Map<String, String>> autocomplete(Map<String, String> param, int type) {
		
		List<Map<String, String>> list = null;
		
		if(type == 1)
			list = pd.autocomplete(param);
		else
			list = pd.autocompleteShop(param);
		
		return list;
	}
	//========================== 예찬 끝

	//주영 시작 ==========================
	@Override
	public List<Map<String, String>> loadProductReportCategory() {
		return pd.loadProductReportCategory();
	}
	@Override
	public int insertProductReport(Map<String, String> param) {
		return pd.insertProductReport(param);
	}
	@Override
	public List<Map<String, String>> selectProductByProductNo(int productNo) {
		return pd.selectProductByProductNo(productNo);
	}
	@Override
	public int delImg(String delImgName) {
		return pd.delImg(delImgName);
	}
	@Override
	public int deleteOldImgName(Map<String, String> param) {
		return pd.deleteOldImgName(param);
	}
	@Override
	public int insertNewImg(Map<String, String> param) {
		return pd.insertNewImg(param);
	}
	@Override
	public int productUpdateEnd(Map<String, String> param) {
		return pd.productUpdateEnd(param);
	}
	@Override
	public List<Map<String, String>> selectProductCategory(int productNo) {
		return pd.selectProductCategory(productNo);
	}
	@Override
	public List<Category> selectCategoryRef(String categoryRef) {
		return pd.selectCategoryRef(categoryRef);
	}
	//========================== 주영 끝
		
	//현규 시작 ==========================
	@Override
	public int insertProductComment(ProductComment pc) {
		return pd.insertProductComment(pc);
	}
	@Override
	public List<Map<String, String>> selectProductCommentList(int productNo, int cPage, int numPerPage) {
		return pd.selectProductCommentList(productNo, cPage, numPerPage);
	}
	@Override
	public int deleteLevel1(int commentNo) {
		return pd.deleteLevel1(commentNo);
	}
	@Override
	public int countComment(int boardNo) {
		return pd.countComment(boardNo);
	}
	@Override
	public int deleteLevel2(int commentNo) {
		return pd.deleteLevel2(commentNo);
	}
	//========================== 현규 끝
	

}
