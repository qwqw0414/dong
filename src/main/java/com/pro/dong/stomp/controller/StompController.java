package com.pro.dong.stomp.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.pro.dong.member.model.vo.Member;
import com.pro.dong.stomp.model.service.StompService;
import com.pro.dong.stomp.model.vo.ChatRoom;
import com.pro.dong.stomp.model.vo.Msg;

@Controller
@RequestMapping("/stomp")
public class StompController {

	static Logger log = LoggerFactory.getLogger(StompController.class);
	
	@Autowired
	StompService ss;
	
	@RequestMapping("/chatList.do")
	public void chatList(Model model, HttpSession session, 
						 @SessionAttribute(value="memberLoggedIn", required=false)Member memberLoggedIn,
						 @RequestAttribute("memberId")String sendMemberId) {
		
		String memberId = Optional.ofNullable(memberLoggedIn).map(Member::getMemberId).orElse(session.getId());
		log.debug(memberId);

		String chatId = null;
		
		//chatId조회
		//1.memberId로 등록한 chatroom존재여부 검사. 있는 경우 chatId 리턴.
		chatId = ss.findChatIdByMemberId(memberId);
		
		//2.로그인을 하지 않았거나, 로그인을 해도 최초접속인 경우 chatId를 발급하고 db에 저장한다.
		if(chatId == null){
			chatId = getRandomChatId(15);//chat_randomToken -> jdbcType=char(20byte)
			
			List<ChatRoom> list = new ArrayList<>();
			list.add(new ChatRoom(chatId, "qwqw0414", 0, "Y", null, null));
			list.add(new ChatRoom(chatId, memberId, 0, "Y", null, null));
			ss.insertChatRoom(list);
		}
		//chatId가 존재하는 경우, 채팅내역 조회
		else{
			List<Msg> chatList = ss.findChatListByChatId(chatId);
			model.addAttribute("chatList", chatList);
		}
		
		log.info("memberId=[{}], chatId=[{}]",memberId, chatId);
		
		model.addAttribute("memberId", memberId);
		model.addAttribute("chatId", chatId);
	}
	
	
	private String getRandomChatId(int len){
		Random rnd = new Random();
		StringBuffer buf =new StringBuffer();
		buf.append("chat_");
		for(int i=0;i<len;i++){
		    if(rnd.nextBoolean()){
		    	boolean isCap = rnd.nextBoolean();
		        buf.append((char)((int)(rnd.nextInt(26))+(isCap?65:97)));
		    }
		    else{
		        buf.append((rnd.nextInt(10))); 
		    }
		}
		return buf.toString();
	}
	
	@GetMapping("/{chatId}/adminChat.do")
	public String adminChat(@PathVariable("chatId") String chatId, Model model){
		
		List<Msg> chatList = ss.findChatListByChatId(chatId);
		model.addAttribute("chatList", chatList);
		
		log.info("chatList={}",chatList);
		return "ws/adminChat";
	}
	
	@GetMapping("/ws/admin.do")
	public void admin(Model model, 
					  HttpSession session, 
					  @SessionAttribute(value="memberLoggedIn", required=false) Member memberLoggedIn){
		String memberId = Optional.ofNullable(memberLoggedIn).map(Member::getMemberId)
															 .orElseThrow(IllegalStateException::new);
		String chatId = null;
		
		if(!"qwqw0414".equals(memberId)) throw new IllegalStateException("로그인 후 이용하세요.");
		
		List<Map<String, String>> recentList = ss.findRecentList();
		log.info("recentList={}",recentList);
		
		model.addAttribute("recentList", recentList);
		
	}
}
