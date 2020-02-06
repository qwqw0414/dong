package com.pro.dong.product.model.service;

import java.util.List;

import com.pro.dong.product.model.vo.Category;
import com.pro.dong.product.model.vo.Product;
import com.pro.dong.shop.model.vo.Shop;

public interface ProductService {

	//민호 시작 ==========================

	//==========================민호 끝
		
	//하진 시작 ==========================
	List<Category> selectCategory();

	
	
	
	
	//========================== 하진 끝
		
	//근호 시작 ==========================

	//========================== 근호 끝
		
	//지은 시작 ==========================

	//========================== 지은 끝
		
	//예찬 시작 ==========================
	List<Category> selectCategory(Category category);	
	Shop selectOneShop(String memberId);
	int insertProduct(Product product);
	//========================== 예찬 끝










		
	//주영 시작 ==========================
		
	//========================== 주영 끝
		
	//현규 시작 ==========================

	//========================== 현규 끝
	
}
