package com.ffc.entitites;

public class Comment {

	private int cmtid;
	private String cmt;
	private int pid;

	public Comment() {
		super();
	}

	public Comment(String cmt, int pid) {
		super();
		this.cmt = cmt;
		this.pid = pid;
	}

	public Comment(int cmtid, String cmt, int pid) {
		super();
		this.cmtid = cmtid;
		this.cmt = cmt;
		this.pid = pid;
	}

	public int getCmtid() {
		return cmtid;
	}

	public void setCmtid(int cmtid) {
		this.cmtid = cmtid;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getCmt() {
		return cmt;
	}

	public void setCmt(String cmt) {
		this.cmt = cmt;
	}

}