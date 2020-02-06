package com.pro.dong.member.model.vo;

import java.io.Serializable;

import lombok.Data;

public @Data class MemberVaild implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String memberId;
	private String isAdmin;
	private String isValid;
}
