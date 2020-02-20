package com.pro.dong.research.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ResearchDAOImpl implements ResearchDAO{

	@Autowired
	SqlSessionTemplate sst;

	@Override
	public List<Map<String, String>> selectTopAddr(Map<String, String> param) {
		return sst.selectList("research.selectTopAddr", param);
	}
	
}
