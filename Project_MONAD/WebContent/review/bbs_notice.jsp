<%@page import="com.jeong.model.MemberDAO"%>
<%@page import="com.jeong.model.MemberVO"%>
<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.jeong.model.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page errorPage="../error/error_view.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="../css/bootstrap.css">
<script language="javascript">
	// 윈도우 창을 닫을 때 로그아웃 처리
	function closePage(event) {
		if (event.clientY < 0) {
			session.invalidate(); // 모든 세션정보 삭제
			response.sendRedirect("start_ok.jsp"); // 로그인 화면으로 이동
		}

	}

	document.onkeydown = function() {
		// 새로고침 방지 ( Ctrl+R, Ctrl+N, F5 )
		if (event.ctrlKey == true
				&& (event.keyCode == 78 || event.keyCode == 82)
				|| event.keyCode == 116) {
			event.keyCode = 0;
			event.cancelBubble = true;
			event.returnValue = false;
		}

		// 창 닫기( Alt+F4 ) 방지 
		if (event.keyCode == 115) { // F4 눌렀을 시
			session.invalidate(); // 모든 세션정보 삭제
			response.sendRedirect("start_ok.jsp"); // 로그인 화면으로 이동

		}

		// 윈도우 창이 닫힐 경우
		if (event.keyCode == 505) {
			alert(document.body.onBeforeUnload);
			session.invalidate(); // 모든 세션정보 삭제
			response.sendRedirect("start_ok.jsp"); // 로그인 화면으로 이동
		}
	}
</script>
<title>Notice</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}

div#total {
	display: flex
}

div#side_1 {
	width: 700px;
	height: 200px;
	/* background-color: yellow; */
	text-align: center;
	flex: 1
}

div#side_2 {
	width: 700px;
	height: 200px;
	text-align: center;
	/* background-color: green; */
	flex: 3
}

div#side_3 {
	width: 700px;
	height: 200px;
	/* background-color: blue; */
	text-align: center;
	flex: 1
}
</style>
</head>
<body>
	<%
		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("user_id") != null) {
			userID = (String) session.getAttribute("user_id");
		}

		int pageNumbern = 1; //기본 페이지 넘버

		//페이지넘버값이 있을때
		if (request.getParameter("pageNumbern") != null) {
			pageNumbern = Integer.parseInt(request.getParameter("pageNumbern"));
		}
	%>


	<!-- 네비게이션  -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expaned="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="../user/start_ok.jsp">MONAD</a>
		</div>

		<div class="collapse navbar-collapse"
			id="#bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="../reservation/go_menu_reservation.jsp">Reservation</a></li>
				<li><a href="../review/bbs_notice.jsp">Notice</a></li>
				<li><a href="../notice/bbs.jsp">Review</a></li>
				<li><a href="../location/location.jsp">Location</a></li>
				<li><a href="../location/corporation.jsp">Corporation</a></li>
			</ul>

		</div>
	</nav>
	<br>
	<br>
	<div align="center">
		<img src="../user/MONAD_circle.jpg" width="430" height="300"
			align="center">
	</div>
	<br>
	<br>
	<h3>&nbsp;&nbsp;&nbsp;&nbsp;Notice</h3>
	<hr>
	<br>
	<br>

	<!-- 게시판 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">내용</th>
					</tr>
				</thead>
				<tbody>
					<%
						MemberDAO dao = MemberDAO.getInstance();
						ArrayList<MemberVO> list = dao.getListNotice(pageNumbern);
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%=list.get(i).getBbsIDn()%></td>
						<td><a href="view_notice.jsp?bbsIDn=<%=list.get(i).getBbsIDn()%>"><%=list.get(i).getBbsTitlen()%></a></td>
						<td><%=list.get(i).getUserIDn()%></td>
						<td><%=list.get(i).getBbsContentn().substring(0, 3)%>...</td>
					</tr>

					<%
						}
					%>

				</tbody>
			</table>
			<!-- 페이지 넘기기 -->
			<%
				if (pageNumbern != 1) {
			%>
			<a href="bbs_notice.jsp?pageNumbern=<%=pageNumbern - 1%>"
				class="btn btn-success btn-arrow-left">이전</a>
			<%
				}
				if (dao.nextPageNotice(pageNumbern)) {
			%>
			<a href="bbs_notice.jsp?pageNumbern=<%=pageNumbern + 1%>"
				class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>

			<!-- 회원만넘어가도록 -->
			<%
				//if logined userID라는 변수에 해당 아이디가 담기고 if not null
				if (session.getAttribute("user_id") != null && session.getAttribute("user_id") != "*") {
					
					String jobCheck = dao.getUserInfo(userID).getJob();

					if (jobCheck.equals("admin")) {
			%>
			<a href="write_notice.jsp" class="btn btn-primary pull-right">글쓰기</a>
			<%
				} else {
			%>

			<%
				}
				}
			%>

		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<hr>
	<div id="total">
		<div id="side_1">
			<div align="center">COMPANY INFO.</div>
			<br> <br>
			<div>
				회사명 : 모나드 커피로스터스<br> 대표 : 김홍우<br> 주소 : 서울 금천구 금하로24길 5<br>
				TEL : 02-6014-0892
			</div>
		</div>
		<div id="side_2">
			<div align="center">MEMBERS INFO.</div>
			<br> <br> NAME : 정준영, 장현진, 장정민, 이규혁 <br> CLASS :
			WED123
		</div>
		<div id="side_3">
			SNS<br> <br> <a
				href="https://www.instagram.com/monadcoffee/"> <img
				src="../user/insta.png" width="80" height="50">
			</a> &nbsp; <a href="https://www.facebook.com/monadcoffee/"> <img
				src="../user/facebook.png" width="35" height="35"></a> <br> <img
				src="../user/MONAD_typo.jpg" width="300" height="200">
		</div>
	</div>

	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>

</body>
</html>

