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

import com.pro.dong.product.model.dao.ProductDAO;
import com.pro.dong.product.model.vo.Category;
import com.pro.dong.product.model.vo.Like;
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

	//==========================민호 끝
		
	//하진 시작 ==========================
	@Override
	public List<Category> selectCategory() {
		return pd.selectCategory();
	}

	
	
	
	
	//========================== 하진 끝
		
	//근호 시작 ==========================

	//========================== 근호 끝
		
	//지은 시작 ==========================

	//========================== 지은 끝
		
	//예찬 시작 ==========================
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
	//========================== 예찬 끝





	

































		
	//주영 시작 ==========================
		
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
