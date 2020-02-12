package com.pro.dong.chat.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.chat.model.dao.ChatDAO;

@Service
public class ChatServiceImpl implements ChatServcie{

	@Autowired
	ChatDAO cd;
	
}
