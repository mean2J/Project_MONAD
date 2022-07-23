function checkPkt() {
	if(document.anv_pkt.amount.value == 0) {
		alert("수량을 입력하세요");
		return;
	}
	
	if(document.anv_pkt.size.value == 1) {
		alert("사이즈를 선택해주세요");
		return;
	}
	
	if(confirm("결제하시겠습니까?")) {
		document.anv_pkt.submit();
	} else {
		alert("결제를 취소하였습니다");
		return;
	}
}

function checkBasket() {
	if(document.anv_pkt.amount.value == 0) {
		alert("수량을 입력하세요");
		return;
	}
	
	if(document.anv_pkt.size.value == 1) {
		alert("사이즈를 선택해주세요");
		return;
	}
	
	if(confirm("장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?")) {
		location.href="basket.jsp";
	} else {
		return;
	}
}