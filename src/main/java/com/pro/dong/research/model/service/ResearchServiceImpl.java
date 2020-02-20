package com.pro.dong.research.model.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.research.model.dao.ResearchDAO;

@Service
public class ResearchServiceImpl implements ResearchService{

	@Autowired
	ResearchDAO rd;
}
