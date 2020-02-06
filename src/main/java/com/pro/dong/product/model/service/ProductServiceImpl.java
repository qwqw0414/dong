package com.pro.dong.product.model.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.pro.dong.product.model.dao.ProductDAO;
import com.pro.dong.product.model.vo.Category;
import com.pro.dong.product.model.vo.Product;
import com.pro.dong.product.model.vo.ProductAttachment;
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
		
		log.debug("111");
		int result = pd.insertProduct(product);
		for(ProductAttachment pa : attachList) {
			log.debug(pa.toString());
			pd.insertAttachment(pa);
		}
		return result;
	}
	//========================== 예찬 끝










		
	//주영 시작 ==========================
		
	//========================== 주영 끝
		
	//현규 시작 ==========================

	//========================== 현규 끝
	
}
