package com.pro.dong.board.model.vo;

import java.io.Serializable;


import lombok.Data;

public @Data class BoardReport implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private int reportNo ;
	private String memberId;
	private String categoryId;
	private int boardNo;
	private String reportComment;
	private String status;
	
	
}
