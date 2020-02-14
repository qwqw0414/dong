package com.pro.dong.stomp.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ChatRoom implements Serializable{
	private static final long serialVersionUID = 1L;
	private String chatId;
    private String memberId;
    private long lastCheck;
    private String status;
    private Date startDate;
    private Date endDate;
}
