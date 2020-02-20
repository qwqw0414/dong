package com.pro.dong.stomp.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.pro.dong.member.model.vo.Member;
import com.pro.dong.stomp.model.service.StompService;
import com.pro.dong.stomp.model.vo.ChatRoom;
import com.pro.dong.stomp.model.vo.Msg;

@Controller
public class StompController {
	
	static Logger log = LoggerFactory.getLogger(StompController.class);
	
    @Autowired
	StompService ss;
    
    @GetMapping("/ws/stomp.do")
    public String websocket(Model model, HttpSession session, int shopNo) {
    	
    	log.debug(shopNo+"");
    	
    	String sendId = ss.selectMemberIdByShopNo(shopNo);
    	
    	String memberId = ((Member)(session.getAttribute("memberLoggedIn"))).getMemberId();
    	String chatId = null;
    	
    	if(sendId.equals(memberId)) return "/";
    	
    	Map<String, String> param = new HashMap<>();
    	param.put("memberId", memberId);
    	param.put("sendId", sendId);
    	
    	chatId = ss.findChatIdByMemberId2(param);
    	
    	if(chatId == null) {
    		chatId = getRandomChatId(15);
    		
    		List<ChatRoom> list = new ArrayList<>();
    		list.add(new ChatRoom(chatId, sendId, 0, "Y", null, null));
    		list.add(new ChatRoom(chatId, memberId, 0, "Y", null, null));
    		ss.insertChatRoom(list);
    	}
    	else {
    		List<Msg> chatList = ss.findChatListByChatId(chatId);
    		if(chatList == null || chatList.size() == 0) chatList = null;
    		model.addAttribute("chatList", chatList);
    	}
    	
    	model.addAttribute("memberId", memberId);
    	model.addAttribute("sendId", sendId);
    	model.addAttribute("chatId", chatId);
    	
    	return "ws/chatView";
    }
    
	@MessageMapping("/chat/{chatId}")
	@SendTo(value={"/chat/{chatId}", "/chat/admin"})
	public Msg sendEcho(Msg fromMessage, 
						@DestinationVariable String chatId, 
						@Header("simpSessionId") String sessionId){
		log.info("fromMessage={}",fromMessage);
		log.info("chatId={}",chatId);
		log.info("sessionId={}",sessionId);
		
		ss.insertChatLog(fromMessage);

		return fromMessage; 
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

	@MessageMapping("/lastCheck")
	@SendTo(value={"/chat/chatList"})
	public Msg lastCheck(@RequestBody Msg fromMessage){
		log.info("fromMessage={}",fromMessage);
		
		ss.updateLastCheck(fromMessage);
		
		return fromMessage; 
	}
	
	@GetMapping("/ws/admin.do")
	public String admin(Model model, 
					  HttpSession session){
//		String memberId = Optional.ofNullable(memberLoggedIn).map(Member::getMemberId)
//															 .orElseThrow(IllegalStateException::new);
		String chatId = null;
		String memberId = ((Member)(session.getAttribute("memberLoggedIn"))).getMemberId();
//		List<Map<String, String>> recentList = ss.findRecentList();
		List<Map<String, String>> recentList = ss.findRecentList2(memberId);
		log.info("recentList={}",recentList);
		
		model.addAttribute("recentList", recentList);
		model.addAttribute("memberId", memberId);
		
		return "ws/chatList";
	}
	
	@GetMapping("/ws/{chatId}/adminChat.do")
	public String adminChat(@PathVariable("chatId") String chatId, Model model, HttpSession session){
		
		String memberId = ((Member)(session.getAttribute("memberLoggedIn"))).getMemberId();
		List<Msg> chatList = ss.findChatListByChatId(chatId);
		
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("chatId", chatId);
		String sendId = ss.findSendId(param);
		int shopNo = ss.selectShopNoByMemberId(sendId);
		
		model.addAttribute("chatList", chatList);
		model.addAttribute("memberId", memberId);
		model.addAttribute("sendId", sendId);
		model.addAttribute("shopNo", shopNo);
		log.info("chatList={}",chatList);
		return "ws/chatView";
	}
	
}
