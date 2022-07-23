function joinConfirm() {
	//이름
	if(document.reg_form.name.value == 0) {
		alert("이름은 필수사항입니다.");
		reg_form.name.focus();
		return;
	}
	
	//아이디
	if(document.reg_form.id.value == 0) {
		alert("아이디는 필수사항입니다.");
		reg_form.id.focus(); //마우스 커서를 아이디 태그 안에다가 둔다는 메서드
		return; //메서드의 강제 종료를 의미
	}

	//id 길이
	if(document.reg_form.id.value.length < 4) {
		alert("아이디는 4글자 이상이여야 합니다.");
		reg_form.id.focus();
		return;
	}
	
	if(document.reg_form.id.value.length >16) {
		alert("아이디는 15글자 이하이여야 합니다.");
		reg_form.id.focus();
		return;
	}
	
	//비밀번호
	if(document.reg_form.pw.value == 0) {
		alert("비밀번호는 필수사항입니다.");
		reg_form.pw.focus();
		return;
	}

	//비밀번호 중복확인
	if(document.reg_form.pw.value != document.reg_form.pw_check.value) {
		alert("비밀번호를 확인해주세요");
		reg_form.pw_check.focus();
		return;
	}
	//통신사 
	if(document.reg_form.callCom.value == 0) {
		alert("통신사를 선택해주세요.");
		reg_form.callCom.focus();
		return;
	}
	
	//핸드폰 번호
	if(document.reg_form.phone1.value == 1) {
		alert("핸드폰 번호는 필수입니다.");
		reg_form.phone1.focus();
		return;
	}
	
	if(document.reg_form.phone2.value == 0) {
		alert("핸드폰 번호는 필수입니다.");
		reg_form.phone2.focus();
		return;
	}
	
	if(document.reg_form.phone3.value == 0) {
		alert("핸드폰 번호는 필수입니다.");
		reg_form.phone3.focus();
		return;
	}
	
	//주민등록번호
	if(document.reg_form.birth1.value == 0) {
		alert("주민등록번호는 필수입니다.");
		reg_form.birth2.focus();
		return;
	}
	
	if(document.reg_form.birth2.value == 0) {
		alert("주민등록번호 끝자리를 입력해주세요");
		reg_form.birth2.focus();
		return;
	}
	
	//이메일
	if(document.reg_form.email1.value == 0) {
		alert("이메일은 필수입니다.");
		reg_form.email1.focus();
		return;
	}
	
	if(document.reg_form.email2.value == 1) {
		alert("이메일은 필수입니다.");
		reg_form.email2.focus();
		return;
	}

	
	//주소
	if(document.reg_form.address1.value == 1) {
		alert("지역을 선택해주세요.");
		reg_form.address1.focus();
		return;
	}
	
	if(document.reg_form.address2.value == 0) {
		alert("도로명 주소를 입력해주세요.");
		reg_form.address2.focus();
		return;
	}

	if(document.reg_form.address3.value == 0) {
		alert("상세 주소를 입력해주세요.");
		reg_form.address3.focus();
		return;
	}
	
	if(document.reg_form.job.value == 0) {
		alert("회원 정보를 선택해주세요.");
		reg_form.job.focus();
		return;
	}
	
	//확인창
	if(confirm("회원가입을 하시겠습니까?")) { //예 버튼을 선택했을 경우
		document.reg_form.submit(); //form 태그를 날려주는 명령문
	} else {
		alert("회원가입에 실패하셨습니다.");
		return; //아니오 버튼을 눌렀을 경우
	}
}

function findIdConfirm() {
	if(document.find_Id.name.value == 0) {
		alert("이름은 필수사항입니다.");
		find_Id.name.focus();
		return;
	}
	
	//통신사 //radio 버튼 체크?
	if(document.find_Id.callCom.value == 0) {
		alert("통신사를 선택해주세요.");
		find_Id.callCom.focus();
		return;
	}
	
	//핸드폰 번호
	if(document.find_Id.phone1.value == 1 ) {
		alert("핸드폰 번호는 필수입니다.");
		find_Id.phone1.focus();
		return;
	}
	
	if(document.find_Id.phone2.value == 0) {
		alert("핸드폰 번호는 필수입니다.");
		find_Id.phone2.focus();
		return;
	}
	
	if(document.find_Id.phone3.value == 0) {
		alert("핸드폰 번호는 필수입니다.");
		find_Id.phone3.focus();
		return;
	}
	
	//주민등록번호
	if(document.find_Id.birth1.value == 0) {
		alert("주민등록번호는 필수입니다.");
		find_Id.birth2.focus();
		return;
	}
	
	if(document.find_Id.birth2.value == 0) {
		alert("주민등록번호 끝자리를 입력해주세요");
		find_Id.birth2.focus();
		return;
	}
	
	//이메일
	if(document.find_Id.email1.value == 0) {
		alert("이메일은 필수입니다.");
		find_Id.email1.focus();
		return;
	}
	
	if(document.find_Id.email2.value == 1) {
		alert("이메일은 필수입니다.");
		find_Id.email2.focus();
		return;
	}

	//확인창
	if(confirm("정보를 제대로 입력하셨습니까?")) { //예 버튼을 선택했을 경우
		document.find_Id.submit(); //form 태그를 날려주는 명령문
	} else {
		alert("아이디 찾기를 취소하셨습니다");
		return; //아니오 버튼을 눌렀을 경우
	}
}

function findPwConfirm() {
	if(document.find_Pw.name.value == 0) {
		alert("이름은 필수사항입니다.");
		find_Pw.name.focus();
		return;
	}
	
	//아이디
	if(document.find_Pw.id.value == 0) {
		alert("아이디은 필수사항입니다.");
		find_Pw.id.focus();
		return;
	}
	
	//통신사
	if(document.find_Pw.callCom.value == 0) {
		alert("통신사를 선택해주세요.");
		find_Pw.callCom.focus();
		return;
	}
	
	//핸드폰 번호
	if(document.find_Pw.phone1.value == 1 ) {
		alert("핸드폰 번호는 필수입니다.");
		find_Pw.phone1.focus();
		return;
	}
	
	if(document.find_Pw.phone2.value == 0) {
		alert("핸드폰 번호는 필수입니다.");
		find_Pw.phone2.focus();
		return;
	}
	
	if(document.find_Pw.phone3.value == 0) {
		alert("핸드폰 번호는 필수입니다.");
		find_Pw.phone3.focus();
		return;
	}
	
	//주민등록번호
	if(document.find_Pw.birth1.value == 0) {
		alert("주민등록번호는 필수입니다.");
		find_Pw.birth1.focus();
		return;
	}
	
	if(document.find_Pw.birth2.value == 0) {
		alert("주민등록번호 끝자리를 입력해주세요");
		find_Pw.birth2.focus();
		return;
	}
	
	//이메일
	if(document.find_Pw.email1.value == 0) {
		alert("이메일은 필수입니다.");
		find_Pw.email1.focus();
		return;
	}
	
	if(document.find_Pw.email2.value == 1) {
		alert("이메일은 필수입니다.");
		find_Pw.email2.focus();
		return;
	}

	//확인창
	if(confirm("정보를 제대로 입력하셨습니까?")) { //예 버튼을 선택했을 경우
		document.find_Pw.submit(); //form 태그를 날려주는 명령문
	} else {
		alert("비밀번호 찾기를 취소하셨습니다");
		return; //아니오 버튼을 눌렀을 경우
	}
}

function updateConfirm() {
	//비밀번호
	if(document.update_form.pw.value == 0) {
		alert("비밀번호는 필수사항입니다.");
		update_form.pw.focus();
		return;
	}

	//비밀번호 중복확인
	if(document.update_form.pw.value != document.update_form.pw_check.value) {
		alert("비밀번호를 확인해주세요");
		update_form.pw_check.focus();
		return;
	}
	
	//통신사
	if(document.update_form.callCom.value == 0) {
		alert("통신사를 선택해주세요.");
		update_form.callCom.focus();
		return;
	}
	
	//핸드폰 번호
	if(document.update_form.phone1.value == 1 ) {
		alert("핸드폰 번호는 필수입니다.");
		update_form.phone1.focus();
		return;
	}
	
	if(document.update_form.phone2.value == 0) {
		alert("핸드폰 번호는 필수입니다.");
		update_form.phone2.focus();
		return;
	}
	
	if(document.update_form.phone3.value == 0) {
		alert("핸드폰 번호는 필수입니다.");
		update_form.phone3.focus();
		return;
	}

	//이메일
	if(document.update_form.email1.value == 0) {
		alert("이메일은 필수입니다.");
		update_form.email1.focus();
		return;
	}
	
	if(document.update_form.email2.value == 1) {
		alert("이메일은 필수입니다.");
		update_form.email2.focus();
		return;
	}
	
	//주소
	if(document.update_form.address1.value == 1) {
		alert("지역을 선택해주세요.");
		update_form.address1.focus();
		return;
	}
	
	if(document.update_form.address2.value == 0) {
		alert("도로명 주소를 입력해주세요.");
		update_form.address2.focus();
		return;
	}

	if(document.update_form.address3.value == 0) {
		alert("상세 주소를 입력해주세요.");
		update_form.address3.focus();
		return;
	}

	//확인창
	if(confirm("정보를 제대로 입력하셨습니까?")) { //예 버튼을 선택했을 경우
		document.update_form.submit(); //form 태그를 날려주는 명령문
	} else {
		alert("정보수정을 취소하셨습니다");
		return; //아니오 버튼을 눌렀을 경우
	}
}

function reservationConfirm(){
	//예약인원
	if(document.reservation_form.covers.value == 0) {
		alert("인원수를 선택해주세요.");
		reservation_form.covers.focus();
		return;
	}

	//날짜(월)
	if(document.reservation_form.date1.value == 0) {
		alert("날짜(월)를 선택해주세요.");
		reservation_form.date1.focus();
		return;
	}
	
	//날짜(일)
	if(document.reservation_form.date2.value == 0) {
		alert("날짜(일)를 선택해주세요.");
		reservation_form.date2.focus();
		return;
	}
	
	//예약시간
	if(document.reservation_form.time.value == 0 ) {
		alert("예약시간을 선택해주세요.");
		reservation_form.time.focus();
		return;
	}

	//좌석 갯수
	count = 0;
	
	for(i=0; i<10;i++){
		 if(document.reservation_form.table_id[i].checked==true) {
			 count++;
		} 
	}
	
	//예약하기
	if(count == 0 || count > 1) {
		alert("한 좌석을 선택해주세요.");
		reservation_form.table_id.focus();
		return;
	}

	
	//예약하기 인원수 문제 (3인이상 2인 불가)
	if((document.reservation_form.table_id[0].checked == true ||
			document.reservation_form.table_id[1].checked == true ||
			document.reservation_form.table_id[2].checked == true ||
			document.reservation_form.table_id[3].checked == true) && document.reservation_form.covers.value > 2) {
		alert("선택하신 좌석은 2인석입니다. 다시 선택해주세요.");
		reservation_form.table_id.focus();
		return;
	}

	//예약하기 인원수 문제 (2인이하일 경우 4인 불가)
	if((document.reservation_form.table_id[4].checked == true ||
			document.reservation_form.table_id[5].checked == true ||
			document.reservation_form.table_id[6].checked == true ||
			document.reservation_form.table_id[7].checked == true
			|| document.reservation_form.table_id[8].checked == true
			|| document.reservation_form.table_id[9].checked == true) && document.reservation_form.covers.value < 3) {
		alert("선택하신 좌석은 4인석입니다. 2인석 선택을 부탁드립니다.");
		reservation_form.table_id.focus();
		return;
	}
	
	//확인창
	if(confirm("선택하신 정보로 예약하시겠습니까? 노쇼시 다음 예약 주문시에 수수료 10%가 추가됩니다.")) { //예 버튼을 선택했을 경우
		document.reservation_form.submit(); //form 태그를 날려주는 명령문
	} else {
		alert("예약을 취소하셨습니다");
		return; //아니오 버튼을 눌렀을 경우
	}
}

function updateReservation(){
	//예약인원
	if(document.updateReservation_form.covers.value == 0) {
		alert("인원수를 선택해주세요.");
		updateReservation_form.covers.focus();
		return;
	}

	//날짜(월)
	if(document.updateReservation_form.date1.value == 0) {
		alert("날짜(월)를 선택해주세요.");
		updateReservation_form.date1.focus();
		return;
	}
	
	//날짜(일)
	if(document.updateReservation_form.date2.value == 0) {
		alert("날짜(일)를 선택해주세요.");
		updateReservation_form.date2.focus();
		return;
	}
	
	//예약시간
	if(document.updateReservation_form.time.value == 0 ) {
		alert("예약시간을 선택해주세요.");
		updateReservation_form.time.focus();
		return;
	}

	//좌석 갯수
	count = 0;
	
	for(i=0; i<10;i++){
		 if(document.updateReservation_form.table_id[i].checked==true) {
			 count++;
		} 
	}
	
	//예약하기
	if(count == 0) {
		alert("좌석을 선택해주세요.");
		updateReservation_form.table_id.focus();
		return;
	}
	
	
	//예약하기 인원수 문제 (3인이상 2인 불가)
	if((document.updateReservation_form.table_id[0].checked == true ||
			document.updateReservation_form.table_id[1].checked == true ||
			document.updateReservation_form.table_id[2].checked == true ||
			document.updateReservation_form.table_id[3].checked == true) && document.updateReservation_form.covers.value > 2) {
		alert("선택하신 좌석은 2인석입니다. 다시 선택해주세요.");
		updateReservation_form.table_id.focus();
		return;
	}

	//예약하기 인원수 문제 (2인이하일 경우 4인 불가)
	if((document.updateReservation_form.table_id[4].checked == true ||
			document.updateReservation_form.table_id[5].checked == true ||
			document.updateReservation_form.table_id[6].checked == true ||
			document.updateReservation_form.table_id[7].checked == true
			|| document.updateReservation_form.table_id[8].checked == true
			|| document.updateReservation_form.table_id[9].checked == true) && document.updateReservation_form.covers.value < 3) {
		alert("선택하신 좌석은 4인석입니다. 2인석 선택을 부탁드립니다.");
		updateReservation_form.table_id.focus();
		return;
	}
	
	//확인창
	if(confirm("선택하신 정보로 수정하시겠습니까? 노쇼시 다음 예약 주문시에 수수료 10%가 추가됩니다.")) { //예 버튼을 선택했을 경우
		document.updateReservation_form.submit(); //form 태그를 날려주는 명령문
	} else {
		alert("수정을 취소하셨습니다");
		return; //아니오 버튼을 눌렀을 경우
	}
}

