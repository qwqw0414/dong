package com.pro.dong.test.model.service;

import java.util.List;

import com.pro.dong.test.model.vo.Test;

public interface TestService {

	Test selectOne();

	int insert(String text);

	List<Test> selectAll();

}
