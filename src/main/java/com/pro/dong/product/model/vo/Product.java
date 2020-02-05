package com.pro.dong.product.model.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class Product implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int productNo;
	private int shopNo;
	private String categoryId;
	private String title;
	private int price;
	private String shipping;
	private String haggle;
	private String info;
	private int incount;
	private String sido;
	private String sigungu;
	private String dong;
	private String status;
	private String isTrade;
}
