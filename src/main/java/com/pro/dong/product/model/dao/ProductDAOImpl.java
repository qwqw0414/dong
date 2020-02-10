package com.pro.dong.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.dong.product.model.vo.Category;
import com.pro.dong.product.model.vo.Product;
import com.pro.dong.product.model.vo.ProductAttachment;
import com.pro.dong.shop.model.vo.Shop;

@Repository
public class ProductDAOImpl implements ProductDAO{

	@Autowired
	SqlSessionTemplate sst;
	
	//민호 시작 ==========================

	//==========================민호 끝
		
	//하진 시작 ==========================
	@Override
	public List<Category> selectCategory() {
		return sst.selectList("product.selectCategory");
	}

	
	
	
	//========================== 하진 끝
		
	//근호 시작 ==========================

	//========================== 근호 끝
		
	//지은 시작 ==========================

	//========================== 지은 끝
		
	//예찬 시작 ==========================
	@Override
	public List<Category> selectCategory(Category category) {
		return sst.selectList("product.selectCategory1", category);
	}
	@Override
	public Shop selectOneShop(String memberId) {
		return sst.selectOne("product.selectOneShop", memberId);
	}
	@Override
	public int insertProduct(Product product) {
		return sst.insert("product.insertProduct", product);
	}
	@Override
	public int insertAttachment(ProductAttachment pa) {
		return sst.insert("product.insertAttachment", pa);
	}
	@Override
	public List<Map<String, String>> selectProductListTop10(String categoryId) {

		RowBounds rowBounds = new RowBounds(0,10);
		return sst.selectList("product.selectProductListTop10", categoryId, rowBounds);
	}
	
	@Override
	public List<Map<String, String>> selectProduct(int cPage, int numPerPage, Map<String, String> param) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("product.selectProduct", param, rowBounds);
	}
	@Override
	public int countProduct(Map<String, String> param) {
		return sst.selectOne("product.countProduct", param);
	}
	//========================== 예찬 끝























		
	//주영 시작 ==========================
		
	//========================== 주영 끝
		
	//현규 시작 ==========================

	//========================== 현규 끝
}
