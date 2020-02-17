package com.pro.dong.stomp.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.dong.stomp.model.vo.ChatRoom;
import com.pro.dong.stomp.model.vo.Msg;

@Repository
public class StompDAOImpl implements StompDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public String findChatIdByMemberId(String memberId) {
		return sqlSession.selectOne("stomp.findChatIdByMemberId", memberId);
	}

	@Override
	public int insertChatRoom(ChatRoom chatRoom) {
		return sqlSession.insert("stomp.insertChatRoom", chatRoom);
	}

	@Override
	public int updateLastCheck(Msg fromMessage) {
		return sqlSession.update("stomp.updateLastCheck", fromMessage);	
	}

	@Override
	public int insertChatLog(Msg fromMessage) {
		return sqlSession.insert("stomp.insertChatLog", fromMessage);
	}

	@Override
	public int deleteChatRoom(String chatId) {
		return sqlSession.update("stomp.deleteChatRoom", chatId);
	}

	@Override
	public List<Map<String, String>> findRecentList() {
		return sqlSession.selectList("stomp.findRecentList");
	}

	@Override
	public List<Msg> findChatListByChatId(String chatId) {
		return sqlSession.selectList("stomp.findChatListByChatId", chatId);
	}

	@Override
	public String findChatIdByMemberId2(Map<String, String> param) {
		return sqlSession.selectOne("stomp.findChatIdByMemberId2", param);
	}

	@Override
	public List<Map<String, String>> findRecentList2(String memberId) {
		return sqlSession.selectList("stomp.findRecentList2", memberId);
	}

	@Override
	public List<String> findChatId(String memberId) {
		return sqlSession.selectList("stomp.findChatId", memberId);
	}

	@Override
	public String findMemberId(Map<String, String> param) {
		return sqlSession.selectOne("stomp.findMemberId", param);
	}

	@Override
	public String findMsg(Map<String, String> param) {
		return sqlSession.selectOne("stomp.findMsg", param);
	}

	@Override
	public int countNoRead(Map<String, String> param) {
		return sqlSession.selectOne("stomp.countNoRead", param);
	}

}
