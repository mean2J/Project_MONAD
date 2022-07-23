<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jeong.model.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page errorPage="../error/error_view.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	//sresponse.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Notice Update</title>
</head>
<body>
	<%
	MemberDAO dao = MemberDAO.getInstance();
		String userID = null;
		if (session.getAttribute("user_id") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("user_id");//유저아이디에 해당 세션값을 넣어준다.
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = '../user/login.jsp'");
			script.println("</script>");
		}

		//글이 유효한지 판별
		int bbsIDn = 0;
		if (request.getParameter("bbsIDn") != null) {
			bbsIDn = Integer.parseInt(request.getParameter("bbsIDn"));
		}
		if (bbsIDn == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'bbs_notice.jsp'");
			script.println("</script>");
		}
		MemberVO vo = dao.getBbsNotice(bbsIDn);
		if (!userID.equals(vo.getUserIDn())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs_notice.jsp'");
			script.println("</script>");
		} else {
			if (request.getParameter("bbsTitlen") == null || request.getParameter("bbsContentn") == null
					|| request.getParameter("bbsTitlen").equals("")
					|| request.getParameter("bbsContentn").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				
				int result = dao.updateNotice(bbsIDn, request.getParameter("bbsTitlen"),
						request.getParameter("bbsContentn"));
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='bbs_notice.jsp'");
					//script.println("history.back()");
					script.println("</script>");
				}
			}
		}
	%>

</body>

</html>

