package com.pro.dong.test.model.dao;

import java.util.List;

import com.pro.dong.test.model.vo.Test;

public interface TestDAO {

	Test selectOne();

	int insert(String text);

	List<Test> selectAll();

}
