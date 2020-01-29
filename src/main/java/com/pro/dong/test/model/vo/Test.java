package com.pro.dong.test.model.vo;

import java.io.Serializable;

public class Test implements Serializable {

	private static final long serialVersionUID = 1L;
	private String testId;
	private String testName;
	private String testVal;

	public Test() {

	}

	public Test(String testId, String testName, String testVal) {
		super();
		this.testId = testId;
		this.testName = testName;
		this.testVal = testVal;
	}

	public String getTestId() {
		return testId;
	}

	public void setTestId(String testId) {
		this.testId = testId;
	}

	public String getTestName() {
		return testName;
	}

	public void setTestName(String testName) {
		this.testName = testName;
	}

	public String getTestVal() {
		return testVal;
	}

	public void setTestVal(String testVal) {
		this.testVal = testVal;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Test [testId=" + testId + ", testName=" + testName + ", testVal=" + testVal + "]";
	}

}
