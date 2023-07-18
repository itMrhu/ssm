package com.model;

public class Student {
	private String id,stuname,ssm,python,java,status;

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getStuname() {
		return stuname;
	}

	public void setStuname(String stuname) {
		this.stuname = stuname;
	}

	public String getSsm() {
		return ssm;
	}

	public void setSsm(String ssm) {
		this.ssm = ssm;
	}

	public String getPython() {
		return python;
	}

	public void setPython(String python) {
		this.python = python;
	}

	public String getJava() {
		return java;
	}

	public void setJava(String java) {
		this.java = java;
	}

	@Override
	public String toString() {
		return "Student [id=" + id + ", stuname=" + stuname + ", ssm=" + ssm + ", python=" + python + ", java=" + java
				+ ", status=" + status + "]";
	}

	
}
