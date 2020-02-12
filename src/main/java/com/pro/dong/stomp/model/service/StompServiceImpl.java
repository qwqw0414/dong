package com.pro.dong.stomp.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.stomp.model.dao.StompDAO;

@Service
public class StompServiceImpl implements StompService{

	@Autowired
	StompDAO sd;
}
