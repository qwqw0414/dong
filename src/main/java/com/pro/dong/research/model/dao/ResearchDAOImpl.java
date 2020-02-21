package com.pro.dong.research.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
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

	@Override
	public int insertHallOfFame(Map<String, String> param) {
		return sst.insert("research.insertHallOfFame", param);
	}

	@Override
	public int HallOfFameTotalContents() {
		return sst.selectOne("research.HallOfFameTotalContents");
	}

	@Override
	public List<Map<String, String>> loadHallOfFame(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("research.loadHallOfFame", null, rowBounds);
	}
	
}
