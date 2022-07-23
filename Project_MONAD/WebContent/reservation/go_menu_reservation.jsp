<%@ page import="java.sql.*"%>
<%@ page import="com.jeong.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="../error/error_view.jsp"%>

<!-- 회원전용과 관리자 전용으로 페이지 두개로 나눠보기 -->

<%
	String id = (String) session.getAttribute("user_id");
	String name = (String) session.getAttribute("user_name");

	MemberDAO dao = MemberDAO.getInstance();

	String jobCheck = dao.getUserInfo(id).getJob();

	if (jobCheck.equals("client")) {
%>

<script>
   		alert("하루에 한 번 예약가능합니다.\n영업시간 : 10:00 ~ 22:00");
   		location.href="../reservation/menu_reservation.jsp";
   </script>

<%
	} else if (jobCheck.equals("admin")) {
%>

<script>
   		alert("관리자 <%=name%>님 (<%=id%>) 환영합니다.");
		location.href = "../reservation/memberlist.jsp";
</script>

<%
	} else {
%>
<script>
	alert("로그인이 필요합니다.");
	location.href = "../user/start_ok.jsp";
</script>

<%
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>