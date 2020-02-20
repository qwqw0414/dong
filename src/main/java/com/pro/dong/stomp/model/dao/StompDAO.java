package com.pro.dong.stomp.model.dao;

import java.util.List;
import java.util.Map;

import com.pro.dong.stomp.model.vo.ChatRoom;
import com.pro.dong.stomp.model.vo.Msg;



public interface StompDAO {

	String findChatIdByMemberId(String memberId);

	int insertChatRoom(ChatRoom chatRoom);

	int insertChatLog(Msg fromMessage);

	int deleteChatRoom(String chatId);

	int updateLastCheck(Msg fromMessage);

	//관리자용
	List<Map<String, String>> findRecentList();

	List<Msg> findChatListByChatId(String chatId);

	String findChatIdByMemberId2(Map<String, String> param);

	List<Map<String, String>> findRecentList2(String memberId);

	List<String> findChatId(String memberId);

	String findMemberId(Map<String, String> param);

	String findMsg(Map<String, String> param);

	int countNoRead(Map<String, String> param);

	String findSendId(Map<String, String> param);

	int selectShopNoByMemberId(String memberId);

	String selectMemberIdByShopNo(int shopNo);

}
