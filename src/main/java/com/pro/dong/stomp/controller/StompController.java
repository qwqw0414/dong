package com.pro.dong.stomp.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pro.dong.stomp.model.service.StompService;

@Controller
@RequestMapping("/stomp")
public class StompController {

	static Logger log = LoggerFactory.getLogger(StompController.class);
	
	@Autowired
	StompService ss;
	
	@RequestMapping("/chatList.do")
	public void chatList() {
		
	}
	
}
