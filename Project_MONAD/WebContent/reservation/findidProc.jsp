<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="com.jeong.model.*"%>
<%@ page errorPage="../error/error_view.jsp"%>
<%
	int index = 0;
	String req = null;
	String how = null;
	MemberDAO dao = MemberDAO.getInstance();
	req = (String) request.getParameter("obj");
	how = (String) request.getParameter("how");
	if (how.equals("id")) {
		index = 0;
	} else {
		index = 1;
	}
	ArrayList<MemberVO> list = dao.findInfo(req, index);
	request.setAttribute("list", list);
%>
<jsp:forward page="memberlist.jsp" />