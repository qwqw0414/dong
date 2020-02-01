package com.pro.dong.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Address implements Serializable{
	private static final long serialVersionUID = 1L;
	private String memberId;
	private String sido;
	private String sigungu;
	private String dong;
}
