package com.pro.dong.research.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ResearchDAOImpl implements ResearchDAO{

	@Autowired
	SqlSessionTemplate sst;
	
}
