package com.pro.dong.stomp.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.dong.stomp.model.vo.ChatRoom;
import com.pro.dong.stomp.model.vo.Msg;

@Repository
public class StompDAOImpl implements StompDAO{

	@Autowired
	SqlSessionTemplate sst;

	@Override
	public String findChatIdByMemberId(String memberId) {
		return sst.selectOne("stomp.findChatIdByMemberId", memberId);
	}

	@Override
	public int insertChatRoom(ChatRoom chatRoom) {
		return sst.insert("stomp.insertChatRoom", chatRoom);
	}

	@Override
	public int updateLastCheck(Msg fromMessage) {
		return sst.update("stomp.updateLastCheck", fromMessage);	
	}

	@Override
	public int insertChatLog(Msg fromMessage) {
		return sst.insert("stomp.insertChatLog", fromMessage);
	}

	@Override
	public int deleteChatRoom(String chatId) {
		return sst.update("stomp.deleteChatRoom", chatId);
	}

	@Override
	public List<Map<String, String>> findRecentList() {
		return sst.selectList("stomp.findRecentList");
	}

	@Override
	public List<Msg> findChatListByChatId(String chatId) {
		return sst.selectList("stomp.findChatListByChatId", chatId);
	}
}
