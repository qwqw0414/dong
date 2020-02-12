package com.pro.dong.chat.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;
import com.pro.dong.chat.model.service.ChatServcie;

@Controller
public class ChatCotroller {

	static Logger log = LoggerFactory.getLogger(ChatCotroller.class);
	static Gson gson = new Gson();
	
	@Autowired
	ChatServcie cs;
	
}
