/**
*   ISP Mobile 연동 
*   작성자 : 홍민우
*	작성일 : 2014.03.27
*/
var tempform;
var xmlHttp;
var androidapps =  "http://mobile.vpay.co.kr/jsp/MISP/andown.jsp";
var iphoneapps  =  "http://itunes.apple.com/kr/app/id369125087?mt=8";

function initISP_M(){
	//install_notice_on();
	var bankCd = document.tranMgr.formBankCd.value;
	var issuerCd = '';
	var fnNo = selectFnNo(bankCd);
	
	if(bankCd == "01"){
		bankCd = "0100";
	}else if(bankCd == "02"){
		bankCd = "0204";
	}else if(bankCd == "15"){	// 우리
		bankCd = "0700";
	}else if(bankCd == "13"){	// 수협
		bankCd = "1800";
	}else if(bankCd == "22"){	// 전북
		bankCd = "1600";
	}else if(bankCd == "21"){	// 광주
		bankCd = "1500";
	}else if(bankCd == "14"){	// 신협
		bankCd = "0100";
		issuerCd = 'SHJ';
	}else if(bankCd == "23"){	// 제주
		bankCd = "0100";
		issuerCd = 'JEJU';
	}else if(bankCd == "24"){	// 산은
		bankCd = "0100";
		issuerCd = 'KDB';
	}else if(bankCd == "32"){	// 우체국
		bankCd = "0100";
		issuerCd = 'PT';
	}else if(bankCd == "33"){	// 저축은행
		bankCd = "0100";
		issuerCd = 'BK';
	}else if(bankCd == "35"){	// 새마을금고
		bankCd = "0100";
		issuerCd = 'SM';
	}else if(bankCd == "36"){	// 중국은행
		bankCd = "0100";
		issuerCd = 'CN';
	}else if(bankCd == "37"){	// 교보증권
		bankCd = "0100";
		issuerCd = 'KBS';
	}else if(bankCd == "38"){	// 유안타증권
		bankCd = "0100";
		issuerCd = 'YTS';
	}else if(bankCd == "39"){	// 동부증권
		bankCd = "0100";
		issuerCd = 'DBS';
	}else if(bankCd == "40"){	// KB증권
		bankCd = "0100";
		issuerCd = 'HS';
	}else if(bankCd == "41"){	// 유진투자증권
		bankCd = "0100";
		issuerCd = 'EGIS';
	}else if(bankCd == "42"){	// 미래에셋증권
		bankCd = "0100";
		issuerCd = 'MRAS';
	}else if(bankCd == "43"){	// SK증권
		bankCd = "0100";
		issuerCd = 'SK';
	}else if(bankCd == "44"){	// NH투자증권
		bankCd = "0100";
		issuerCd = 'NHS';
	}else if(bankCd == "45"){	// 케이뱅크
		bankCd = "0100";
		issuerCd = 'KBK';
	}else if(bankCd == "46"){	// 카카오뱅크
		bankCd = "0204";
		issuerCd = 'KA';
	}else{
		bankCd = "0100";
	}
	document.tranMgr.MerchantNo_ispm.value = fnNo;
	document.tranMgr.bankCd_ispm.value = bankCd;
	document.tranMgr.issuerCode.value = issuerCd;
	
	goISPM_data();
}
// 모바일 디바이스 구분
function OScheck(){
	var OSname;
	if (navigator.appVersion.indexOf("iPhone OS") != -1){
		OSname="IPHONE";
	}
	if (navigator.appVersion.indexOf("Android") != -1){
		OSname="ANDROID";
	}
	return OSname;
}
// 동적 화면 표시
function displayStatus(msg) {
	if (document.getElementById('contents')) {
		document.getElementById('contents').innerHTML = msg;
	}	
}
// 모바일 ISP APP 설치 팝업
function initISP_link(){	
	if(OSchekc() == "IPHONE"){
		window.open(iphoneapps,"popup","toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=800,height=800");
	}else{
		window.open(androidapps,"popup","toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=800,height=800");
	}
}
// 카드선택 단계 이동
function goBack() {
	document.tranMgr.action = "../card/index_card_m.jsp";
	document.tranMgr.submit();
}
// ISP APP 필요 데이타 저장.
function setISPM_data(){
	var bankCd = document.tranMgr.formBankCd.value;
	var fnNo = selectFnNo(bankCd);
	
	if(bankCd == "01"){
		bankCd = "0100";
	}else if(bankCd == "02"){
		bankCd = "0204";
	}else if(bankCd == "15"){
		bankCd = "0700";
	}else if(bankCd == "13"){
		bankCd = "1800";
	}else if(bankCd == "22"){
		bankCd = "1600";
	}else if(bankCd == "21"){
		bankCd = "1500";
	}else{
		bankCd = "0100";
	}
	document.tranMgr.MerchantNo_ispm.value = fnNo;
	document.tranMgr.bankCd_ispm.value = bankCd;
	goISPM_data();
}
//ISP APP 데이타 전송 서블릿 요청 
function goISPM_data(){
	document.tranMgr.action = "../card/isp/sendMISPTrans.jsp";
	document.tranMgr.submit();
}
//ISP APP 호출
function goISPAPP(){
	var urlISP = "ispmobile://TID="+document.tranMgr.TID.value;
	location.href = urlISP;
}
//ISP 종료
function exitISPM(){
	alert("ISP APP 인증이 완료되었습니다.");
	window.open('about:blank', '_self').close();
}