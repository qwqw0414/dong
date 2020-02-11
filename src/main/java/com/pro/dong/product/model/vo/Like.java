package com.pro.dong.product.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.Data;

public @Data class Like implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private int likeNo;
	private String memberId;
	private int productNo;
	private Date regDate;
}
