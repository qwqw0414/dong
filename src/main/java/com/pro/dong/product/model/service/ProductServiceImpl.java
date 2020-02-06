package com.pro.dong.product.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.product.model.dao.ProductDAO;
import com.pro.dong.product.model.vo.Category;
import com.pro.dong.product.model.vo.Product;
import com.pro.dong.shop.model.vo.Shop;

@Service
public class ProductServiceImpl implements ProductService{

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
	@Override
	public int insertProduct(Product product) {
		return pd.insertProduct(product);
	}
	//========================== 예찬 끝










		
	//주영 시작 ==========================
		
	//========================== 주영 끝
		
	//현규 시작 ==========================

	//========================== 현규 끝
	
}
