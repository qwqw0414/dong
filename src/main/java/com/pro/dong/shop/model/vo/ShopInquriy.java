package com.pro.dong.shop.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.Data;

public @Data class ShopInquriy implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int inquiryNo;
	private String memberId;
	private int shopNo;
	private String inquiryContent;
	private int inquiryLevel;
	private Date writerDate;
	private int inquiryRef;

}
