package com.pro.dong.stomp.model.service;

import java.util.List;
import java.util.Map;

import com.pro.dong.stomp.model.vo.ChatRoom;
import com.pro.dong.stomp.model.vo.Msg;


public interface StompService {

	String findChatIdByMemberId(String memberId);

	int insertChatRoom(List<ChatRoom> list);

	int insertChatLog(Msg fromMessage);

	int deleteChatRoom(String chatId);

	int updateLastCheck(Msg fromMessage);

	
	//관리자용
	List<Map<String, String>> findRecentList();

	List<Msg> findChatListByChatId(String chatId);

	String findChatIdByMemberId2(Map<String, String> param);

	List<Map<String, String>> findRecentList2(String memberId);

	String findSendId(Map<String, String> param);

	int selectShopNoByMemberId(String memberId);

}
