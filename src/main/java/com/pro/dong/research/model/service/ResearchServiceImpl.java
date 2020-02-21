package com.pro.dong.research.model.service;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.research.model.dao.ResearchDAO;

@Service
public class ResearchServiceImpl implements ResearchService{

	@Autowired
	ResearchDAO rd;

	@Override
	public List<Map<String, String>> selectTopAddr(Map<String, String> param) {
		return rd.selectTopAddr(param);
	}

	@Override

	public int insertHallOfFame(Map<String, String> param) {
		return rd.insertHallOfFame(param);
	}

	@Override
	public int HallOfFameTotalContents() {
		return rd.HallOfFameTotalContents();
	}

	@Override
	public List<Map<String, String>> loadHallOfFame(int cPage, int numPerPage) {
		return rd.loadHallOfFame(cPage,numPerPage);
	}
	public int getThermometer(int shopNo) {
		return rd.getThermometer(shopNo);

	}
}
