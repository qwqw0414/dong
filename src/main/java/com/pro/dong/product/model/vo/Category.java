package com.pro.dong.product.model.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class Category implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String categoryId;
	private String categoryName;
	private int categoryLevel;
	private String categoryRef;
}
