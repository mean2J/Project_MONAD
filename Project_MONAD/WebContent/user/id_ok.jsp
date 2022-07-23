<%@ page import="java.sql.*"%>
<%@ page import="com.jeong.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="../error/error_view.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String callCom = request.getParameter("callCom");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String birth1 = request.getParameter("birth1");
	String birth2 = request.getParameter("birth2");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");

	MemberDAO dao = MemberDAO.getInstance();

	MemberVO vo = new MemberVO(name, callCom, phone1, phone2, phone3, birth1, birth2, email1, email2);

	String result = dao.forgetId(vo);

	if (result.equals("NotMember")) {
%>
<!-- location.href 대신 go 해보기 -->
<script>
		alert("아이디를 찾을 수 없습니다.");
		history.go(-1);
	</script>
<%
	} else {
%>
<script>
		alert("회원님의 아이디는 <%=result%>입니다.");
		location.href = "login.jsp";
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