<%@page import="com.jeong.model.MemberVO"%>
<%@page import="com.jeong.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	
	String id = (String)request.getParameter("id");

	MemberDAO dao = MemberDAO.getInstance();
	
	MemberVO vo = new MemberVO();
	
	vo = dao.getUserInfo(id);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
		<img src="../user/MONAD_typo.jpg" width="300" height="200">
	</div>
	
<div class="container" align="center">
	<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">이름</th>
						<th style="background-color: #eeeeee; text-align: center;">아이디</th>
						<th style="background-color: #eeeeee; text-align: center;">연락처</th>
						<th style="background-color: #eeeeee; text-align: center;">이메일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>&nbsp;&nbsp;<%=vo.getName()%>&nbsp;&nbsp;</td>
						<td>&nbsp;&nbsp;<%=vo.getId()%>&nbsp;&nbsp;</td>
						<td>&nbsp;<%=vo.getPhone1()%>-<%=vo.getPhone2()%>-<%=vo.getPhone3()%>&nbsp;</td>
						<td>&nbsp;<%=vo.getEmail1()%>@<%=vo.getEmail2()%>&nbsp;</td>
					</tr>
				</tbody>
			</table>
			</div>
</body>
</html>