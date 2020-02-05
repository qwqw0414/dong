package com.pro.dong.product.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.dong.product.model.vo.Category;

@Repository
public class ProductDAOImpl implements ProductDAO{

	@Autowired
	SqlSessionTemplate sst;
	
	//민호 시작 ==========================

	//==========================민호 끝
		
	//하진 시작 ==========================
	@Override
	public List<Category> selectCategory() {
		return sst.selectList("product,selectCategory");
	}
	
	
	
	//========================== 하진 끝
		
	//근호 시작 ==========================

	//========================== 근호 끝
		
	//지은 시작 ==========================

	//========================== 지은 끝
		
	//예찬 시작 ==========================
		
	//========================== 예찬 끝
		
	//주영 시작 ==========================
		
	//========================== 주영 끝
		
	//현규 시작 ==========================

	//========================== 현규 끝
}
