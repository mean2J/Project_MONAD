<%@ page import="java.sql.*" %>
<%@ page import="com.jeong.model.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String callCom = request.getParameter("callCom");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String birth1 = request.getParameter("birth1");
	String birth2 = request.getParameter("birth2");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	
	MemberDAO dao = MemberDAO.getInstance();
	
	String value ="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()";
	String tempPw ="";
	int rand_num=0;
	for(int i = 0; i<10; i++) {
		rand_num = (int)Math.floor(Math.random() * value.length());
		tempPw += value.substring((int)rand_num, (int)rand_num+1);
	}
	
	MemberVO vo = new MemberVO(name, id, callCom, phone1, phone2, phone3, birth1, birth2, email1, email2, tempPw);
	
	int result = dao.forgetPw(vo);

	if (result == -1) {
%>
<!-- location.href 대신 go 해보기 -->
	<script>
		alert("회원이신지 확인해주세요.");
		history.go(-1);
	</script>
<%
	} else if(result == 1) {
%>
	<script>
		alert("회원님의 비밀번호가 <%=tempPw%>로 초기화되었습니다.\n다시 로그인해주세요.");
		location.href="login.jsp";
	</script>
<%
	} else {
%>
	<script>
		alert("다시 시도해주세요.");
		history.go(-1);
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