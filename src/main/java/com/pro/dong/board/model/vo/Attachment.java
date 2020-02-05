package com.pro.dong.board.model.vo;

import java.io.Serializable;

import lombok.Data;

public @Data class Attachment implements Serializable{

	private static final long serialVersionUID = 1L;

	private int attachmentNo;
	private int boardNo;
	private String originalFileName;
	private String renamedFileName;
	private int downLoadCount;
	private char isPhoto;
}
