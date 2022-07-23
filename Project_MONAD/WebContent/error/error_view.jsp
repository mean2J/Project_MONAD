<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 이 페이지는 에러 페이지로 사용될 것이기 때문에 속성을 true 로 바꿔준다 -->
<%@ page isErrorPage="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ErrorPage</title>
</head>
<body>
	<!-- 에러가 발생했을 때 사용자에게 보여줄 에러페이지 -->
		<hr>
		<script>
			alert("로그인 후에 이용해주세요.")
			location.href="../user/login.jsp";
		</script>
		
</body>
</html>