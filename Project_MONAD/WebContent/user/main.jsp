<%@page import="com.jeong.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="../error/error_view.jsp"%>
<%
	String id = (String) session.getAttribute("user_id");
	String name = (String) session.getAttribute("user_name");

	String job = "";

	MemberDAO dao = MemberDAO.getInstance();

	int memberCheck = dao.userConfirm(id);

	if (memberCheck == 1) {
		job = dao.getMemberInfo(id).getJob();
	}

	if (id.equals(null) || id.equals("*")) {
%>

<script>
	alert("로그인이 필요합니다.");
	location.href = "../user/login.jsp";
</script>

<%
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="../css/bootstrap.css">

<!-- 자바스크립트를 이용한 로그아웃 처리 (인터넷 창을 닫았을 경우 )  -->

<script language="javascript">
	// 윈도우 창을 닫을 때 로그아웃 처리
	function closePage(event) {
		if (event.clientY < 0) {
			session.invalidate(); // 모든 세션정보 삭제
			response.sendRedirect("start.jsp"); // 로그인 화면으로 이동
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
			response.sendRedirect("start.jsp"); // 로그인 화면으로 이동

		}

		// 윈도우 창이 닫힐 경우
		if (event.keyCode == 505) {
			alert(document.body.onBeforeUnload);
			session.invalidate(); // 모든 세션정보 삭제
			response.sendRedirect("start.jsp"); // 로그인 화면으로 이동
		}
	}
</script>


<title>MONAD</title>
<style type="text/css">
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
<body onbeforeunload="closePage(event)" oncontextmenu="return false">
	<!-- 네비게이션  -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expaned="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="../user/main.jsp">MONAD</a>
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
		<img src="MONAD_circle.jpg" width="430" height="300" align="center">
	</div>
	<br>
	<h3>
		&nbsp;&nbsp;<%=name%>(<%=id%>)님
	</h3>
	<hr>
	<div align="right">
		<!-- 정보수정은 나중에 -->
		<%
			if (job.equals("admin")) {
		%>
		<a href="../membership/membership.jsp">[Membership]</a>
		&nbsp;&nbsp;&nbsp; <a href="update.jsp">[Edit]</a> &nbsp;&nbsp;&nbsp;
		<a href="logout.jsp">[Logout]</a> &nbsp;&nbsp;&nbsp;<br>
		<%
			} else {
		%>
		<a href="mypage.jsp">[Mypage]</a> &nbsp;&nbsp;&nbsp; <a
			href="../membership/membership.jsp">[Membership]</a>
		&nbsp;&nbsp;&nbsp; <a href="update.jsp">[Edit]</a> &nbsp;&nbsp;&nbsp;
		<a href="logout.jsp">[Logout]</a> &nbsp;&nbsp;&nbsp;<br>
		<%
			}
		%>
	</div>
	<hr>
	<div align="center">
		<video src="../image/MONAD_Video.mp4" height="500" width="700"
			muted="muted" autoplay="autoplay" loop="loop"></video>
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
				src="insta.png" width="80" height="50">
			</a> &nbsp; <a href="https://www.facebook.com/monadcoffee/"> <img
				src="facebook.png" width="35" height="35"></a> <br> <img
				src="../user/MONAD_typo.jpg" width="300" height="200">
		</div>
	</div>

	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>
