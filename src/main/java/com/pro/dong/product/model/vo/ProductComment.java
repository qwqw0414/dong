package com.pro.dong.product.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.Data;

public @Data class ProductComment implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int commentNo;
	private int productNo;
	private String memberId;
	private String contents;
	private int commentLevel;
	private int commentRef;
	private Date writeDate;
}
