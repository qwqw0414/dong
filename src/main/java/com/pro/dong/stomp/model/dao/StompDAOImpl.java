package com.pro.dong.stomp.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StompDAOImpl implements StompDAO{

	@Autowired
	SqlSessionTemplate sst;
}
