<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="../error/error_view.jsp"%>

<%
	String id = (String)session.getAttribute("user_id");
%>
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
<title>Location</title>
<style type="text/css">
div#side_1 {
	width: 700px;
	height: 1000px;
	/* background-color: yellow; */
	float: right;
}

div#side_2 {
	width: 1150px;
	height: 1000px;
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
	<h3>&nbsp;&nbsp;&nbsp;&nbsp;Location</h3>
	<hr>
	<br>
	<br>

	<div>
		<div id="side_1" align="left">
			<br> <br> <br>
			<div>
				<h3>매장정보</h3>
			</div>
			<br>
			<div>
				<h4>02-6014-0892</h4>
			</div>
			<div>
				<h4>서울 금천구 금하로24길 5</h4>
			</div>
			<div>
				<h4>매일 09:30 ~ 22:30</h4>
			</div>

		</div>
		<div id="side_2" align="right">
			<table cellpadding="0" cellspacing="0" width="462" align="right">
				<tr>
					<td style="border: 1px solid #cecece;"><a
						href="https://v4.map.naver.com/?query=&searchCoord=&tab=1&lng=b776bf9a0c04e56f3278f91bd7e7c020&mapMode=0&mpx=42d8fa2564e23445ded3d7130057b739ffee9028346d8ea583edca6e4f2dcf4a251839ebe0d4a3679d1abe702e0d706b&pinId=36624404&lat=a980789b01f7f36a3fea3a0b67208751&dlevel=11&enc=b64&__pinOnly=false&menu=location&__fromRestorer=true&pinType=site"
						target="_blank"><img
							src="http://prt.map.naver.com/mashupmap/print?key=p1573375184573_941737154"
							width="690" height="510" alt="지도 크게 보기" title="지도 크게 보기"
							border="0" style="vertical-align: top;" /></a></td>
				</tr>
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td height="30" bgcolor="#f9f9f9" align="right"
									style="padding-left: 9px; border-left: 1px solid #cecece; border-bottom: 1px solid #cecece;">
									<span
									style="font-family: tahoma; font-size: 11px; color: #666;">2019.11.27</span>&nbsp;<span
									style="font-size: 11px; color: #e5e5e5;">|</span>&nbsp;<a
									style="font-family: dotum, sans-serif; font-size: 11px; color: #666; text-decoration: none; letter-spacing: -1px;"
									href="https://v4.map.naver.com/?query=&searchCoord=&tab=1&lng=b776bf9a0c04e56f3278f91bd7e7c020&mapMode=0&mpx=42d8fa2564e23445ded3d7130057b739ffee9028346d8ea583edca6e4f2dcf4a251839ebe0d4a3679d1abe702e0d706b&pinId=36624404&lat=a980789b01f7f36a3fea3a0b67208751&dlevel=11&enc=b64&__pinOnly=false&menu=location&__fromRestorer=true&pinType=site"
									target="_blank">지도 크게 보기</a>
								</td>
								<td width="98" bgcolor="#f9f9f9" align="right"
									style="text-align: right; padding-right: 9px; border-right: 1px solid #cecece; border-bottom: 1px solid #cecece;">
									<span style="float: right;"><span
										style="font-size: 9px; font-family: Verdana, sans-serif; color: #444;">&copy;&nbsp;</span>&nbsp;<a
										style="font-family: tahoma; font-size: 9px; font-weight: bold; color: #2db400; text-decoration: none;"
										href="https://www.navercorp.com" target="_blank">MONAD</a></span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div>

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
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>
