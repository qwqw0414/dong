package com.pro.dong.stomp.model.service;

import java.util.List;
import java.util.Map;

import com.pro.dong.stomp.model.vo.Msg;
import com.pro.dong.stomp.model.vo.ChatRoom;

public interface StompService {

	String findChatIdByMemberId(String memberId);

	int insertChatRoom(List<ChatRoom> list);

	int insertChatLog(Msg fromMessage);

	int deleteChatRoom(String chatId);

	int updateLastCheck(Msg fromMessage);

	
	//관리자용
	List<Map<String, String>> findRecentList();

	List<Msg> findChatListByChatId(String chatId);

}