
<%@ page errorPage="../error/error_view.jsp"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.jeong.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String callCom = request.getParameter("callCom");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String birth1 = request.getParameter("birth1");
	String birth2 = request.getParameter("birth2");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address3 = request.getParameter("address3");
	String job = request.getParameter("job");

	MemberDAO dao = MemberDAO.getInstance();

	int result = dao.userConfirm(id);

	if (result == 1) { //id가 존재할 경우
%>
<script>
	alert("이미 사용중인 아이디입니다.");
	history.go(-1);
</script>
<%
	} else { //id가 없는 경우

		MemberVO vo = new MemberVO(name, id, pw, callCom, phone1, phone2, phone3, birth1, birth2, email1,
				email2, address1, address2, address3, job);

		int check = dao.insertUser(vo);

		if (check == 1) { // 회원가입 성공
%>
<%
	session.setAttribute("user_id", id);
			session.setAttribute("user_name", name);
%>
<script>
	alert("MONAD 회원이 되신 것을 축하합니다.");
	location.href = "main.jsp";
</script>
<%
	} else { //회원가입 실패
%>
<script>
	alert("회원가입에 실패하셨습니다. 다시 시도해주세요");
	history.go(-1);
</script>

<%
	}
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