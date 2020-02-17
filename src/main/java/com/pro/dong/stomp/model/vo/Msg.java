package com.pro.dong.stomp.model.vo;

import java.io.Serializable;

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
public class Msg implements Serializable{
	private static final long serialVersionUID = 1L;
	private long chatNo;
    private String chatId;
    private String memberId;
    private String msg;
    private long time;
    private MsgType type;
}
