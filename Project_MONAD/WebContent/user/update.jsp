<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.jeong.model.*"%>
<%@ page errorPage="../error/error_view.jsp"%>
<%
	String id = (String) session.getAttribute("user_id");
	String name = (String) session.getAttribute("user_name");
	MemberDAO dao = MemberDAO.getInstance();

	MemberVO vo = dao.getUserInfo(id);
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

<title>회원정보수정</title>
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
	<br>
	<div align="center">
		<img src="MONAD_circle.jpg" width="430" height="300" align="center">
	</div>
	<br>
	<br>
	<h3>
		&nbsp;&nbsp;&nbsp;<%=name%>(<%=id%>)님 회원정보 수정
	</h3>
	<hr>
	<br>
	<div>
		<br>


		<!-- 정보수정 -->
		<div class="container">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<!-- 점보트론 -->
				<div class="jumbotron" style="padding-top: 20px;">


					<!-- 로그인 정보를 숨기면서 전송post -->
					<form method="post" action="update_ok.jsp" name="update_form">
						<h3 style="text-align: center;">회원정보수정</h3>


						<!-- 비밀번호 -->
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호"
								name="pw" maxlength="20">
						</div>


						<!-- 비밀번호 확인-->
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호 확인"
								name="pw_check" maxlength="20">
						</div>


						<!-- 핸드폰 번호(통신사) -->
						<div class="form-group">
							<tr>
								<td rowspan="2" align="center">핸드폰 번호</td>
								<td><input type="radio" name="callCom" value="skt">SKT
									<input type="radio" name="callCom" value="kt">KT <input
									type="radio" name="callCom" value="lg">U+</td>
							</tr>
						</div>


						<!-- 핸드폰 번호 -->
						<div class="form-group">
							<tr>
								<td><select name="phone1">
										<option value=1>선택해주세요</option>
										<option value="02">02</option>
										<option value="031">031</option>
										<option value="010">010</option>
								</select> - <input type="text" name="phone2" size="5"
									value="<%=vo.getPhone2()%>"> - <input type="text"
									name="phone3" size="5" value="<%=vo.getPhone3()%>"></td>
							</tr>
						</div>


						<!-- 이메일 -->
						<div clss="form-group">이메일</div>
						<div class="form-group">
							<tr>
								<td><input type="text" name="email1" size="10"
									value="<%=vo.getEmail1()%>"> @ <select name="email2">
										<option value=1>선택해주세요</option>
										<option value="naver.com">naver.com</option>
										<option value="daum.net">daum.net</option>
										<option value="gmail.com">gmail.com</option>
								</select></td>
							</tr>
						</div>


						<!-- 주소 -->
						<div clss="form-group">주소</div>
						<div class="form-group">
							<tr>
								<td><select name="address1">
										<option value=1>선택해주세요</option>
										<option value="서울시">서울시</option>
										<option value="경기도">경기도</option>
										<option value="강원도">강원도</option>
								</select> <input type="text" name="address2" placeholder="도로명 주소를 입력해주세요"
									value="<%=vo.getAddress2()%>"></td>
							</tr>
							<tr>
								<td><input type="text" name="address3"
									placeholder="상세 주소를 입력하세요" size="30"
									value="<%=vo.getAddress3()%>"></td>
							</tr>
						</div>


						<!-- 전송 -->
						<input type="button" class="btn btn-primary form-control"
							value="수정" onclick="updateConfirm()"> &nbsp; &nbsp;
						&nbsp; <input type="reset" class="btn btn-primary form-control"
							value="취소" onclick="location.href='main.jsp'">

					</form>
				</div>
			</div>
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
					src="insta.png" width="80" height="50">
				</a>&nbsp; <a href="https://www.facebook.com/monadcoffee/"> <img
					src="facebook.png" width="35" height="35"></a> <br> <img
					src="../user/MONAD_typo.jpg" width="300" height="200">
			</div>
		</div>
		<!-- 애니매이션 담당 JQUERY -->
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<!-- 부트스트랩 JS  -->
		<script src="js/bootstrap.js"></script>
	</div>
</body>
</html>