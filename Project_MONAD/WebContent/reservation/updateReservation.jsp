<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String id = (String) session.getAttribute("user_id");
	String name = (String) session.getAttribute("user_name");
	
	int oid = 0;
	if (request.getParameter("oid") != null) {
		oid = Integer.parseInt(request.getParameter("oid"));
	}
	
	if (id.equals(null) || id.equals("*")) {
%>

<script>
	alert("로그인이 필요합니다.");
	location.href = "start.jsp";
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
<link rel="stylesheet" href="../css/bootstrap.min.css">
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
<title>예약하기 (Client)</title>
<style type="text/css">
div#side_1 {
	width: 400px;
	height: 1500px;
	/* background-color: yellow; */
	float: left;
}

div#side_2 {
	width: 1680px;
	height: 1500px;
	/* background-color: green; */
	float: center;
}

div#total {
	display: flex
}

div#side_3 {
	width: 700px;
	height: 200px;
	/* background-color: yellow; */
	text-align: center;
	flex: 1
}

div#side_4 {
	width: 700px;
	height: 200px;
	text-align: center;
	/* background-color: green; */
	flex: 3
}

div#side_5 {
	width: 700px;
	height: 200px;
	/* background-color: blue; */
	text-align: center;
	flex: 1
}
</style>

<script type="text/javascript" src="../js/anv.js"></script>


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
	<div align="center">
		<img src="../user/MONAD_circle.jpg" width="430" height="300"
			align="center">
	</div>
	<br>
	<br>
	<h3>
		&nbsp;&nbsp;&nbsp;<%=name%>(<%=id%>)님 예약 수정하기
	</h3>
	<hr>

	<br>

	<%--<div id = "main" align="center"> --%>
	<div>
		<div id="side_1" align="center">

			<form action="updateReservation_ok.jsp?oid=<%=oid %>" method="post"
				name="updateReservation_form">
				<table align="center" boarder="1">
					<tr>
						<td>예약인원</td>
						<td>&nbsp;&nbsp;<select name="covers">
								<option value="0">인원수</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
						</select></td>
					</tr>
					<tr>
						<td><br></td>
					</tr>
					<tr>
						<td>날짜</td>
						<td>&nbsp;&nbsp;<select name="date1">
								<option value="0">월</option>
								<option value="jan">1</option>
								<option value="feb">2</option>
								<option value="mar">3</option>
								<option value="apr">4</option>
								<option value="may">5</option>
								<option value="jun">6</option>
								<option value="jul">7</option>
								<option value="agu">8</option>
								<option value="sep">9</option>
								<option value="oct">10</option>
								<option value="nov">11</option>
								<option value="dec">12</option>
						</select> &nbsp;&nbsp;&nbsp;&nbsp;<select name="date2">
								<option value="0">일</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">14</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
								<option value="19">19</option>
								<option value="20">20</option>
								<option value="21">21</option>
								<option value="22">22</option>
								<option value="23">23</option>
								<option value="24">24</option>
								<option value="25">25</option>
								<option value="26">26</option>
								<option value="27">27</option>
								<option value="28">28</option>
								<option value="29">29</option>
								<option value="30">30</option>
								<option value="31">31</option>
						</select></td>
					</tr>
					<tr>
						<td><br></td>
					</tr>
					<tr>
						<td>예약시간</td>
						<td>&nbsp;&nbsp;<select name="time">
								<option value="0">예약 시간</option>
								<option value="1">10:00 ~ 12:00 (1 Time)</option>
								<option value="2">12:00 ~ 14:00 (2 Time)</option>
								<option value="3">14:00 ~ 16:00 (3 Time)</option>
								<option value="4">16:00 ~ 18:00 (4 Time)</option>
								<option value="5">18:00 ~ 20:00 (5 Time)</option>
								<option value="6">20:00 ~ 22:00 (6 Time)</option>

						</select></td>
					</tr>
					<tr>
						<td><br></td>
					</tr>
					<tr>
						<td>좌석선택</td>
						<td>&nbsp;&nbsp;
							<table align="center">
								<tr>
									<td>[2인석]&nbsp;<input type="checkbox" name="table_id"
										value="1"></td>
									<td><input type="checkbox" name="table_id" value="2"></td>
									<td><input type="checkbox" name="table_id" value="3"></td>
									<td><input type="checkbox" name="table_id" value="4"></td>
								</tr>

								<tr>
									<td>[4인석]&nbsp;<input type="checkbox" name="table_id"
										value="5"></td>
									<td><input type="checkbox" name="table_id" value="6"></td>
									<td><input type="checkbox" name="table_id" value="7"></td>
									<td><input type="checkbox" name="table_id" value="8"></td>
								</tr>

								<tr>
									<td>[4인석]&nbsp;</td>
									<td><input type="checkbox" name="table_id" value="9"></td>
									<td><input type="checkbox" name="table_id" value="10"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<br> <br> <input type="button" value="수정하기"
					onclick="updateReservation()"> &nbsp; &nbsp; &nbsp; <input
					type="reset" value="취소" onclick="location.href='../user/main.jsp'">
			</form>
		</div>
		<div id="side_2" align="center">

			<video src="../reservation/menu.mp4" height="500" width="700"
				muted="muted" autoplay="autoplay" loop="loop"></video>
			<br> <br> <img src="menu1.JPG" width="1250" height="700">
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<hr>
	<div id="total">
		<div id="side_3">
			<div align="center">COMPANY INFO.</div>
			<br> <br>
			<div>
				회사명 : 모나드 커피로스터스<br> 대표 : 김홍우<br> 주소 : 서울 금천구 금하로24길 5<br>
				TEL : 02-6014-0892
			</div>
		</div>
		<div id="side_4">
			<div align="center">MEMBERS INFO.</div>
			<br> <br> NAME : 정준영, 장현진, 장정민, 이규혁 <br> CLASS :
			WED123
		</div>
		<div id="side_5">
			SNS<br> <br> <a
				href="https://www.instagram.com/monadcoffee/"> <img
				src="../user/insta.png" width="80" height="50">
			</a>&nbsp; <a href="https://www.facebook.com/monadcoffee/"> <img
				src="../user/facebook.png" width="35" height="35"></a> <br> <img
				src="../user/MONAD_typo.jpg" width="300" height="200">
		</div>
	</div>
</body>
</html>