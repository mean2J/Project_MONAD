<%@page import="com.jeong.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="../error/error_view.jsp"%>
<!DOCTYPE html>
<%
	int rst = 0;

	String id = (String)request.getParameter("id");
	String date = (String)request.getParameter("date");
	MemberDAO dao = MemberDAO.getInstance();
	rst = dao.DeleteReservation(id, date);
%>
<%
	if (rst == 0) {
%>
<script type="text/javascript">
	alert("삭제에 실패하였습니다.");
	history.go(-1);
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("삭제되었습니다.");
	location.href = "memberlist.jsp";
</script>
<%
	}
%>