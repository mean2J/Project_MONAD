
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
	if(time.equals("1")) {
		arrivalTime = "10";
	} else if(time.equals("2")) {
		arrivalTime = "12";
	} else if(time.equals("3")) {
		arrivalTime ="14";
	} else if(time.equals("4")) {
		arrivalTime ="16";
	} else if(time.equals("5")) {
		arrivalTime ="18";
	} else {
		arrivalTime ="20";
	}

	MemberDAO dao = MemberDAO.getInstance();

	int resultda = dao.reservationCheckDate(date, id);
	int resultti = dao.reservationCheckTime(time, date, id);
	int resultta = dao.reservationCheckTable(table_id, time, date);

	//예약가능하면 1 예약 불가하면 0
	//선택한 날짜 가능, 자리 가능, 테이블 가능
	if (resultda == 1 && resultti == 1 && resultta == 1) { // 모두 예약가능
		MemberVO vo = new MemberVO(covers, date, time, table_id, customer_id, arrivalTime);

		int check = dao.reservationConfirm(vo);

		if (check == 1) { // 예약이 완료		

			// 기존 customer 인지 확인해보기
			// 예약을 한번이라도 했을 경우를 확인
			int customerCheck = dao.userCustomerConfirm(id);

			if (customerCheck == 1) { //이미 customer 테이블에 회원 정보가 존재할 경우 oNum 만 바꿔준다.
				String oNum = dao.getCustomerInfo(id).getoNum();

				int count = Integer.parseInt(oNum);
				count = count + 1;

				vo = new MemberVO(name, id, dao.getUserInfo(id).getPhone3(), Integer.toString(count));

				int updateCustomer = dao.updateCustomerUser(vo);

			} else { // 처음 예약했을 경우 oNum을 1로 설정해준다.
				vo = new MemberVO(name, id, dao.getUserInfo(id).getPhone3(), "1");

				int customer = dao.insertCustomer(vo);
			}
%>
<script>
	alert("예약이 완료되었습니다.");
	location.href = "../user/main.jsp";
</script>
<%
	}
	// 선택한 날짜 가능, 선택한 시간 가능, 선택한 자리 불가능
	} else if (resultda == 1 && resultti == 1 && resultta == 0) { // 날짜 다르고 시간 다르지만 테이블 번호가 같을때
		
%>
<script>
	alert("선택하신 자리는 이미 예약되었습니다.");
	history.go(-1);
</script>
<%
	// 선택한 날짜 가능 선택한 시간 불가능
	// 선택한 날짜와 시간은 가능하지만 자리가 없을 수도 있음
	} else if (resultda == 1 && resultti == 0) { // 날짜 다르고 같은 시간에 테이블번호 다를때
		
%>
<script>
	alert("선택하신 시간은 이미 예약이 마감되었습니다.");
	history.go(-1);
</script>
<%
	// 해당 날짜에 이미 예약이 되어있을 경우와 가능한데 위와 같은 경우도 포함
	} else { // 날짜 다르고 같은 시간에 테이블 번호도 같을때
	
%>
<script>
	alert("해당 날짜에 이미 예약이 되어있습니다.");
	history.go(-1);
</script>
<%

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