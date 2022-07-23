<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="../error/error_view.jsp"%>
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
<title>MONAD 로그인</title>

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

<
style type ="text/css">.login_btn {
	width: 60px;
	height: 50px;
	background-color: skyblue;
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
		<br> <br> <img src="MONAD_circle.jpg" width="430"
			height="300" align="center"> <br> <br> <br>
		<!-- 로그인 폼 -->

		<div class="container">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<!-- 점보트론 -->
				<div class="jumbotron" style="padding-top: 20px;">

					<!-- 로그인 정보를 숨기면서 전송post -->
					<form method="post" action="login_ok.jsp">

						<!-- 아이디 입력 -->
						<div class="form-group">
							<input type="text" class="form-control" placeholder="아이디"
								name="id" maxlength="20">
						</div>


						<!-- 비밀번호 입력 -->
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호"
								name="pw" maxlength="20">
						</div>


						<!-- 로그인 버튼 -->
						<input type="submit" class="btn btn-primary form-control"
							value="로그인"> <br>

						<!-- 회원가입, id/pw 찾기  -->
						<div>
							<tr>
								<br>
								<td align="center"><input type="button" value="회원가입"
									onclick="location.href='join.jsp'"> &nbsp;&nbsp; <input
									type="button" value="ID찾기" onclick="location.href='findId.jsp'">
									&nbsp;&nbsp; <input type="button" value="PW찾기"
									onclick="location.href='findPw.jsp'"></td>
							</tr>
						</div>


					</form>
				</div>
			</div>
		</div>
	</div>

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
</body>
</html>