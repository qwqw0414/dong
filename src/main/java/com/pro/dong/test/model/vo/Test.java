package com.pro.dong.test.model.vo;

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
public class Test implements Serializable {

	private static final long serialVersionUID = 1L;
	private int testNo;
	private String testText;
	private Date testDate;
}
