package com.jeong.model;

public class MemberVO {

	private String name;
	private String id;
	private String pw;
	private String tempPw;
	private String callCom;
	private String phone1;
	private String phone2;
	private String phone3;
	private String birth1;
	private String birth2;
	private String email1;
	private String email2;
	private String address1;
	private String address2;
	private String address3;
	private int oid;
	private String covers;
	private String date;
	private String time;
	private String table_id;
	private String customer_id;
	private String arrivalTime;
	private String job;
	private String oNum;
	private int bbsID;
	private String bbsTitle;
	private String userID;
	private String bbsDate;
	private String bbsContent;
	private int bbsAvailable;
	private int bbsIDn;
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public int getBbsAvailable() {
		return bbsAvailable;
	}
	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}
	public int getBbsIDn() {
		return bbsIDn;
	}
	public void setBbsIDn(int bbsIDn) {
		this.bbsIDn = bbsIDn;
	}
	public String getBbsTitlen() {
		return bbsTitlen;
	}
	public void setBbsTitlen(String bbsTitlen) {
		this.bbsTitlen = bbsTitlen;
	}
	public String getUserIDn() {
		return userIDn;
	}
	public void setUserIDn(String userIDn) {
		this.userIDn = userIDn;
	}
	public String getBbsDaten() {
		return bbsDaten;
	}
	public void setBbsDaten(String bbsDaten) {
		this.bbsDaten = bbsDaten;
	}
	public String getBbsContentn() {
		return bbsContentn;
	}
	public void setBbsContentn(String bbsContentn) {
		this.bbsContentn = bbsContentn;
	}
	public int getBbsAvailablen() {
		return bbsAvailablen;
	}
	public void setBbsAvailablen(int bbsAvailablen) {
		this.bbsAvailablen = bbsAvailablen;
	}

	private String bbsTitlen;
	private String userIDn;
	private String bbsDaten;
	private String bbsContentn;
	private int bbsAvailablen;
	
	public String getoNum() {
		return oNum;
	}
	public void setoNum(String oNum) {
		this.oNum = oNum;
	}
	public String getTempPw() {
		return tempPw;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public void setTempPw(String tempPw) {
		this.tempPw = tempPw;
	}
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public String getCovers() {
		return covers;
	}
	public void setCovers(String covers) {
		this.covers = covers;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getTable_id() {
		return table_id;
	}
	public void setTable_id(String table_id) {
		this.table_id = table_id;
	}
	public String getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}
	public String getArrivalTime() {
		return arrivalTime;
	}
	public void setArrivalTime(String arrivalTime) {
		this.arrivalTime = arrivalTime;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getCallCom() {
		return callCom;
	}
	public void setCallCom(String callCom) {
		this.callCom = callCom;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getPhone3() {
		return phone3;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}
	public String getBirth1() {
		return birth1;
	}
	public void setBirth1(String birth1) {
		this.birth1 = birth1;
	}
	public String getBirth2() {
		return birth2;
	}
	public void setBirth2(String birth2) {
		this.birth2 = birth2;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getAddress3() {
		return address3;
	}
	public void setAddress3(String address3) {
		this.address3 = address3;
	}
	
	//회원가입을 위한 생성자 오버라이딩
	public MemberVO(String name, String id, String pw, String callCom, String phone1, String phone2, String phone3,
			String birth1, String birth2, String email1, String email2, String address1, String address2,
			String address3, String job) {
		super();
		this.name = name;
		this.id = id;
		this.pw = pw;
		this.callCom = callCom;
		this.phone1 = phone1;
		this.phone2 = phone2;
		this.phone3 = phone3;
		this.birth1 = birth1;
		this.birth2 = birth2;
		this.email1 = email1;
		this.email2 = email2;
		this.address1 = address1;
		this.address2 = address2;
		this.address3 = address3;
		this.job = job;
	}
	
	public MemberVO() {

	}
	
	//id찾기 를 위한 생성자 오버라이딩
	public MemberVO(String name, String callCom, String phone1, String phone2, String phone3, String birth1, String birth2, String email1, String email2) {
		super();
		this.name = name;
		this.callCom = callCom;
		this.phone1 = phone1;
		this.phone2 = phone2;
		this.phone3 = phone3;
		this.birth1 = birth1;
		this.birth2 = birth2;
		this.email1 = email1;
		this.email2 = email2;
	}
	
	//pw찾기를 위한 생성자 오버라이딩
	public MemberVO(String name, String id, String callCom, String phone1, String phone2, String phone3, String birth1, String birth2, String email1, String email2, String tempPw) {
		super();
		this.name = name;
		this.id = id;
		this.callCom = callCom;
		this.phone1 = phone1;
		this.phone2 = phone2;
		this.phone3 = phone3;
		this.birth1 = birth1;
		this.birth2 = birth2;
		this.email1 = email1;
		this.email2 = email2;
		this.tempPw = tempPw;
	}
	
	//update 하기 위한 생성자 오버라이딩

	 public void MemberVOUpdate(String id, String pw, String callCom, String phone1, String
	 phone2, String phone3, String email1, String email2, String address1, String
	 address2, String address3) 
	 { 
		 this.id = id; this.pw = pw;
		 this.callCom = callCom; this.phone1 = phone1; this.phone2 = phone2;
		 this.phone3 = phone3; this.email1 = email1; this.email2 = email2;
		 this.address1 = address1; this.address2 = address2; this.address3 = address3;
	 }

	//reservation 하기 위한 생성자 오버라이딩
	public MemberVO(int oid, String covers, String date, String time, String table_id, String customer_id, String arrivalTime) {
		super();
		this.oid = oid;
		this.covers = covers;
		this.date = date;
		this.time = time;
		this.table_id = table_id;
		this.customer_id = customer_id;
		this.arrivalTime = arrivalTime;
	}
	//reservation 하기 위한 생성자 오버라이딩
	public MemberVO(String covers, String date, String time, String table_id, String customer_id, String arrivalTime) {
		super();
		this.covers = covers;
		this.date = date;
		this.time = time;
		this.table_id = table_id;
		this.customer_id = customer_id;
		this.arrivalTime = arrivalTime;
	}
	
	//customer 테이블에 넣을 생성자 오버라이딩
	public MemberVO(String name, String id, String phone3, String oNum){
		super();
		this.name = name;
		this.id = id;
		this.phone3 = phone3;
		this.oNum = oNum;
	}
}
