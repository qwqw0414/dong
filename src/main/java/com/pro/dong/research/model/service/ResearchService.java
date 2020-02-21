package com.pro.dong.research.model.service;

import java.util.List;
import java.util.Map;

public interface ResearchService {

	List<Map<String, String>> selectTopAddr(Map<String, String> param);


	int insertHallOfFame(Map<String, String> param);

	int HallOfFameTotalContents();

	List<Map<String, String>> loadHallOfFame(int cPage, int numPerPage);

	int getThermometer(int shopNo);


}
