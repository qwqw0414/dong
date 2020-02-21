package com.pro.dong.research.model.dao;

import java.util.List;
import java.util.Map;

public interface ResearchDAO {

	List<Map<String, String>> selectTopAddr(Map<String, String> param);


	int insertHallOfFame(Map<String, String> param);

	int HallOfFameTotalContents();

	List<Map<String, String>> loadHallOfFame(int cPage, int numPerPage);

	int getThermometer(int shopNo);


}
