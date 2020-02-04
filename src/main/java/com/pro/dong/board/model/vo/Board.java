package com.pro.dong.board.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.Data;

public @Data class Board implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int boardNo;
	private String memberId;
	private String categoryId;
	private String boardTitle;
	private String boardContents;
	private Date writeDate;
	private int readCount;
}
