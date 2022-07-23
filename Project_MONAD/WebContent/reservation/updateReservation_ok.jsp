
<%@ page import="java.sql.*"%>
<%@ page import="com.jeong.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");

	String id = (String) session.getAttribute("user_id");
	String name = (String) session.getAttribute("user_name");

	String covers = request.getParameter("covers");
	String date1 = request.getParameter("date1");
	String date2 = request.getParameter("date2");
	String time = request.getParameter("time");
	String table_id = request.getParameter("table_id");

	String date = date1 + date2;
	String customer_id = id;
	String arrivalTime = "";
	if (time.equals("1")) {
		arrivalTime = "10";
	} else if (time.equals("2")) {
		arrivalTime = "12";
	} else if (time.equals("3")) {
		arrivalTime = "14";
	} else if (time.equals("4")) {
		arrivalTime = "16";
	} else if (time.equals("5")) {
		arrivalTime = "18";
	} else {
		arrivalTime = "20";
	}

	int oid = 0;
	if (request.getParameter("oid") != null) {
		oid = Integer.parseInt(request.getParameter("oid"));
	}

	MemberDAO dao = MemberDAO.getInstance();

	//기존의 정보를 받기 위한 메소드
	MemberVO vo_origin = new MemberVO();
	vo_origin = dao.getUpdateReservationInfo(customer_id, date);
	
	//선택한 날짜에 고객이 예약을 했는지? 했으면 0 안 했으면 1
	int resultda = dao.reservationCheckDate(date, id);
	//선택한 시간과 날짜에 고객이름이 있는지? 있으면 0 없으면 1
	int resultti = dao.reservationCheckTime(time, date, id);
	//선택한 시간과 날짜에 테이블이 예약되었는지? 되었으면 0 안 되었 1
	int resultta = dao.reservationCheckTable(table_id, time, date);
	//예약이 하나 이상이면 1 아니면 0
	// 이거 해보기 중복 예약 삭제하기 위해

	//예약가능하면 1 예약 불가하면 0
	// 이미 해당 시간에 예약이 있을 경우
	// 전에 했던 예약이랑 날짜가 겹치는 것
	if (resultda == 0) {
		if (resultti == 0 && resultta == 1) {
			MemberVO vo = new MemberVO(oid, covers, date, time, table_id, customer_id, arrivalTime);

			//업데이트
			int check = dao.updateReservation(vo);
			//업데이트 성공
			if (check == 1) {
				int delete = dao.DeleteUpdateReservation(customer_id, vo_origin.getOid());

				if (delete == 1) {
%>
<script>
	alert("예약 수정이 완료되었습니다.");
	location.href = "../user/mypage.jsp";
</script>
<%
	}
			}
		} else if (resultti == 0 && resultta == 0) {
%>
<script>
	alert("선택하신 자리는 이미 예약이 되어있습니다.");
	history.go(-1);
</script>
<%
	} else if (resultti == 1 && resultta == 1) {
			//누른거 수정할 정보
			MemberVO vo = new MemberVO(oid, covers, date, time, table_id, customer_id, arrivalTime);
			//누른거 말고 기존꺼 정보들	

			//업데이트 누른거에 새로운 정보들
			int check = dao.updateReservation(vo);
			//업데이트 성공
			if (check == 1) {
				int delete = dao.DeleteUpdateReservation(customer_id, vo_origin.getOid());

				if (delete == 1) {
%>
<script>
	alert("예약 수정이 완료되었습니다.");
	location.href = "../user/mypage.jsp";
</script>
<%
	}
			}
		} else {
%>
<script>
	alert("선택하신 자리는 이미 예약이 되어있습니다.");
	history.go(-1);
</script>
<%
	}
		
		//새로운 예약
	} else {
		if (resultti == 1 && resultta == 1) {
			MemberVO vo = new MemberVO(oid, covers, date, time, table_id, customer_id, arrivalTime);

			int check = dao.updateReservation(vo);

			if (check == 1) { // 예약이 완료
%>
<script>
	alert("예약정보 수정이 완료되었습니다.");
	location.href = "../user/mypage.jsp";
</script>
<%
	} else {
%>
<script>
	alert("예약정보 수정을 실패하였습니다.");
	history.go(-1);
</script>
<%
	}
		} else if (resultti == 0 && resultta == 1) {
%>
<script>
	alert("선택하신 시간의 예약이 마감되었습니다.");
	history.go(-1);
</script>
<%
	} else if (resultti == 0 && resultta == 0) {
%>
<script>
	alert("선택하신 시간의 예약이 마감되었습니다.");
	history.go(-1);
</script>
<%
	} else {
%>
<script>
	alert("선택하신 자리는 이미 예약되었습니다.");
	history.go(-1);
</script>
<%
	}
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>