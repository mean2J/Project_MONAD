<%@page import="java.util.ArrayList"%>
<%@page import="com.jeong.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="../error/error_view.jsp"%>
<%
	MemberDAO dao = MemberDAO.getInstance();
	ArrayList<MemberVO> list = new ArrayList<MemberVO>();
	ArrayList<MemberVO> reqlist = (ArrayList<MemberVO>) request.getAttribute("list");
	if (reqlist == null) {
		list = dao.selectAllMember();
	} else {
		list = reqlist;
	}
%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
th {
	background-color: #B2CCFF;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="../css/bootstrap.css">
<script type="text/javascript">
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
<title>예약조회</title>
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
<body>
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
	<h3>&nbsp;&nbsp;&nbsp;&nbsp;Reservatioin Admin</h3>
	<hr>
	<br>
	<br>

	<br>
	<div class="container">
		<div class="row">
			<form action="findidProc.jsp" method="post">
				<select name="how">

					<option value="0">선택하기</option>
					<option value="id">아이디</option>
					<option value="time">예약시간</option>

				</select>&nbsp; <input type="text" size="20" name="obj"> <input
					type="submit" value="검색">
			</form>
			<br>
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">예약번호</th>
						<th style="background-color: #eeeeee; text-align: center;">인원수</th>
						<th style="background-color: #eeeeee; text-align: center;">예약
							날짜</th>
						<th style="background-color: #eeeeee; text-align: center;">예약
							시간</th>
						<th style="background-color: #eeeeee; text-align: center;">좌석
							번호</th>
						<th style="background-color: #eeeeee; text-align: center;">ID</th>
						<th style="background-color: #eeeeee; text-align: center;">도착
							예상 시간</th>
						<th style="background-color: #eeeeee; text-align: center;">삭제</Th>

					</tr>
				</thead>
				<tbody>
					<%
						
							for (int i = 0; i < list.size(); i++) {
							session.setAttribute("customer_id", list.get(i).getCustomer_id());
							session.setAttribute("date", list.get(i).getDate());
					%>
					<tr>
						<td><%=list.get(i).getOid()%></td>
						<td><%=list.get(i).getCovers()%></td>
						<td><%=list.get(i).getDate().substring(0, 3) + " " + list.get(i).getDate().substring(3, list.get(i).getDate().length())%></td>
						<td><%=list.get(i).getTime()%></td>
						<td><%=list.get(i).getTable_id()%></td>
						<td><a onclick = "window.open('../reservation/customerDetail.jsp?id=<%=list.get(i).getCustomer_id()%>','new',
			                  'width=500, height=360, resizable=no, scrollbars=no, status=no, location=no, directories=no')"
						><%=list.get(i).getCustomer_id()%></td>
						<td><%=list.get(i).getArrivalTime()%></td>
						<td><button class="btn btn-primary pull-center"
								onclick="javascript:location.href='deleteProc.jsp?id=<%=list.get(i).getCustomer_id()%>&date=<%=list.get(i).getDate()%>'"
								type="button">삭제</button></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		<br> <br> <br> <br> <br>
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
					src="../user/facebook.png" width="35" height="35"></a> <br>
				<img src="../user/MONAD_typo.jpg" width="300" height="200">
			</div>
		</div>
</body>
</html>