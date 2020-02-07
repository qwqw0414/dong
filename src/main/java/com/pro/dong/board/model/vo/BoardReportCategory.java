package com.pro.dong.board.model.vo;

import java.io.Serializable;

import lombok.Data;

public @Data class BoardReportCategory implements Serializable{

	private static final long serialVersionUID = 1L;

	private String categoryId;
	private String reportType;
	
}
