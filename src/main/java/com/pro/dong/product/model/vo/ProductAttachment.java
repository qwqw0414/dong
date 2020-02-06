package com.pro.dong.product.model.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class ProductAttachment implements Serializable{

	private static final long serialVersionUID = 1L;
	private int attachmentNo;
	private int productNo;
	private String photo;
	
}
