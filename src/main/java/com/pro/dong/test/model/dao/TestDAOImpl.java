package com.pro.dong.test.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.dong.test.model.vo.Test;

@Repository
public class TestDAOImpl implements TestDAO{

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public Test selectOne() {
		return sqlSession.selectOne("test.selectOne");
	}
	
}
