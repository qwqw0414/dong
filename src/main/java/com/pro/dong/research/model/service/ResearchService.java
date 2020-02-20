package com.pro.dong.research.model.service;

import java.util.List;
import java.util.Map;

public interface ResearchService {

	List<Map<String, String>> selectTopAddr(Map<String, String> param);

}
