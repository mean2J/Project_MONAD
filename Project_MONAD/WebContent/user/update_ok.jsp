<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jeong.model.*"%>
<%@ page import="java.sql.*"%>
<%@ page errorPage="../error/error_view.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("user_id");

	String pw = request.getParameter("pw");
	String callCom = request.getParameter("callCom");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address3 = request.getParameter("address3");

	MemberDAO dao = MemberDAO.getInstance();

	MemberVO vo = new MemberVO();
	vo.MemberVOUpdate(id, pw, callCom, phone1, phone2, phone3, email1, email2, address1, address2, address3);

	int check = dao.updateUser(vo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		if (check == 1) { //회원정보를 성공적으로 바꿨을 경우
			//id와 name은 회원정보로 수정할 수 없으므로 세션에 다시 넣지 않아도 된다.
	%>
	<script>
		alert("회원정보 수정이 완료되었습니다.");
		location.href = "main.jsp";
	</script>
	<%
		} else { //회원정보 수정을 실패했을 경우
	%>
	<script>
		alert("회원정보 수정을 실패하였습니다. 다시 시도해주세요");
		history.go(-1);
	</script>
	<%
		}
	%>

</body>
</html>