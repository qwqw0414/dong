package com.pro.dong.test.model.dao;

import java.util.List;

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

	@Override
	public int insert(String text) {
		return sqlSession.insert("test.insert",text);
	}

	@Override
	public List<Test> selectAll() {
		return sqlSession.selectList("test.selectAll");
	}
	
}
