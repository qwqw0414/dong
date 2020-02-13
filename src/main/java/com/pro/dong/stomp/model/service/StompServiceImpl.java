package com.pro.dong.stomp.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.dong.stomp.model.dao.StompDAO;
import com.pro.dong.stomp.model.vo.ChatRoom;
import com.pro.dong.stomp.model.vo.Msg;

@Service
public class StompServiceImpl implements StompService{

	@Autowired
	StompDAO sd;

	@Override
	public String findChatIdByMemberId(String memberId) {
		return sd.findChatIdByMemberId(memberId);
	}

	@Override
	public int insertChatRoom(List<ChatRoom> list) {
		int result = 0;
		for(ChatRoom chatRoom: list){
			result += sd.insertChatRoom(chatRoom);
		}
		return result;
	}
	
	@Override
	public int updateLastCheck(Msg fromMessage) {
		return sd.updateLastCheck(fromMessage);
	}

	@Override
	public int insertChatLog(Msg fromMessage) {
		//메세지 입력시 lastCheck컬럼값도 갱신
		updateLastCheck(fromMessage);
		return sd.insertChatLog(fromMessage);
	}

	@Override
	public int deleteChatRoom(String chatId) {
		return sd.deleteChatRoom(chatId);
	}

	@Override
	public List<Map<String, String>> findRecentList() {
		return sd.findRecentList();
	}

	@Override
	public List<Msg> findChatListByChatId(String chatId) {
		return sd.findChatListByChatId(chatId);
	}
}
