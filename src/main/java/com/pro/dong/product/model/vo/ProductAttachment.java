package com.pro.dong.product.model.vo;

import java.io.Serializable;

public class ProductAttachment implements Serializable{

	private static final long serialVersionUID = 1L;
	private int attachmentNo;
	private int productNo;
	private String photo;
	
	public ProductAttachment() {
		
	}

	public ProductAttachment(int attachmentNo, int productNo, String photo) {
		super();
		this.attachmentNo = attachmentNo;
		this.productNo = productNo;
		this.photo = photo;
	}

	public int getAttachmentNo() {
		return attachmentNo;
	}

	public void setAttachmentNo(int attachmentNo) {
		this.attachmentNo = attachmentNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "ProductAttachment [attachmentNo=" + attachmentNo + ", productNo=" + productNo + ", photo=" + photo
				+ "]";
	}
	
	
}
