package com.pro.dong.stomp.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pro.dong.stomp.model.dao.StompDAO;
import com.pro.dong.stomp.model.vo.ChatRoom;
import com.pro.dong.stomp.model.vo.Msg;

@Service
@Transactional(rollbackFor=Exception.class)
public class StompServiceImpl implements StompService {

	Logger log = LoggerFactory.getLogger(getClass());
	@Autowired
	StompDAO stompDao;

	@Override
	public String findChatIdByMemberId(String memberId) {
		return stompDao.findChatIdByMemberId(memberId);
	}

	@Override
	public int insertChatRoom(List<ChatRoom> list) {
		int result = 0;
		for(ChatRoom chatRoom: list){
			result += stompDao.insertChatRoom(chatRoom);
		}
		return result;
	}
	
	@Override
	public int updateLastCheck(Msg fromMessage) {
		return stompDao.updateLastCheck(fromMessage);
	}

	@Override
	public int insertChatLog(Msg fromMessage) {
		//메세지 입력시 lastCheck컬럼값도 갱신
		updateLastCheck(fromMessage);
		return stompDao.insertChatLog(fromMessage);
	}

	@Override
	public int deleteChatRoom(String chatId) {
		return stompDao.deleteChatRoom(chatId);
	}

	@Override
	public List<Map<String, String>> findRecentList() {
		return stompDao.findRecentList();
	}

	@Override
	public List<Msg> findChatListByChatId(String chatId) {
		return stompDao.findChatListByChatId(chatId);
	}

	@Override
	public String findChatIdByMemberId2(Map<String, String> param) {
		return stompDao.findChatIdByMemberId2(param);
	}

	@Override
	public List<Map<String, String>> findRecentList2(String memberId) {
		
		List<Map<String, String>> list = new ArrayList<>();
		Map<String, String> param = new HashMap<>();
		List<String> chatId = stompDao.findChatId(memberId);
		
		param.put("memberId", memberId);
		
		if(chatId != null) {
			for(String i : chatId) {
				Map<String, String> map = new HashMap<>();
				
				param.put("chatId", i);
				
				map.put("CHATID", i);
				map.put("MEMBERID", stompDao.findMemberId(param));
				map.put("MSG", stompDao.findMsg(param));
				map.put("CNT", stompDao.countNoRead(param)+"");
				
				log.debug(map.toString());
				param.remove("chatId");
				
				list.add(map);
			}
			
		}
		
		return list;
	}

	@Override
	public String findSendId(Map<String, String> param) {
		return stompDao.findSendId(param);
	}

	@Override
	public int selectShopNoByMemberId(String memberId) {
		return stompDao.selectShopNoByMemberId(memberId);
	}

	
}
