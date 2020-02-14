package com.pro.dong.product.model.vo;

import java.sql.Date;

import lombok.Data;

public @Data class OrderList {

	private int orderNo;
	private int productNo;
	private String memberId;
	private String sido;
	private String sigungu;
	private String dong;
	private String address;
	private long price;
	private String type;
	private String checkSend;
	private String checkReceive;
	private Date orderDate;
}
