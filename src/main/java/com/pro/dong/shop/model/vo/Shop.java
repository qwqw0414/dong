package com.pro.dong.shop.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.Data;

public @Data class Shop implements Serializable{

	private static final long serialVersionUID = 1L;
	private int shopNo;
	private String memberId;
	private String shopName;
	private String shopInfo;
	private String image;
 	private Date openDate;
}
