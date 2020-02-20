package com.pro.dong.research.model.dao;

import java.util.List;
import java.util.Map;

public interface ResearchDAO {

	List<Map<String, String>> selectTopAddr(Map<String, String> param);

}
