<%@ page import="java.sql.*"%>
<%@ page import="com.jeong.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String id = (String)session.getAttribute("user_id");

	if (id.equals("*")) {
%>
<!-- location.href 대신 go 해보기 -->
<script>
		location.href="../user/start.jsp";
	</script>
<%
	} else {
%>
<script>
	location.href = "../user/main.jsp";
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