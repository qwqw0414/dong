package com.pro.dong.test.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.test.model.dao.TestDAO;
import com.pro.dong.test.model.vo.Test;

@Service
public class TestServiceImpl implements TestService{

	@Autowired
	TestDAO testDAO;

	@Override
	public Test selectOne() {
		return testDAO.selectOne();
	}

	@Override
	public int insert(String text) {
		return testDAO.insert(text);
	}

	@Override
	public List<Test> selectAll() {
		return testDAO.selectAll();
	}
	
}
