<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jeong.model.*"%>
<%@ page errorPage="../error/error_view.jsp"%>

<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	MemberDAO dao = MemberDAO.getInstance();

	int result = dao.userCheck(id, pw);

	if (result == -1) { //로그인 실패
%>
<script>
	alert("MONAD 회원이 아닙니다.");
	history.go(-1);
</script>

<%
	} else if (result == 0) { //비밀번호가 틀린 경우
%>
<script>
	alert("비밀번호를 확인해주세요.");
	history.go(-1);
</script>

<%
	} else { //로그인 성공 
		MemberVO vo = dao.getMemberInfo(id);

		String name = vo.getName();

		session.setAttribute("user_id", id);
		session.setAttribute("user_name", name);

		response.sendRedirect("main.jsp");
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