package com.pro.dong.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public @Data class Member implements Serializable{

	private static final long serialVersionUID = 1L;
	private String memberId;
	private String password;
	private String memberName;
	private String gender;
	private String birth;
	private String phone;
	private String email;
	private Date enrollDate;
	private String sido;
	private String sigungu;
	private String dong;
	private String isValid;
	private String isAdmin;
	private int point;
	
}
