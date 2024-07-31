<%@page contentType="text/html; charset=UTF-8"
		import="kr.co.seeroo.spclib.SPCLib
				, org.json.simple.JSONObject"%><%
				
	//-----------------------------------------------------------------------------------------------------------------------
	// ※ 연동 시 주의사항
	// 1. 본 예제는 세션을 이용하여 암/복호화 키를 관리하도록 되어 있습니다. 멀티 서버의 경우 서버간 세션 공유가 불가할 수 있으며, 세션 공유가 불가한 경우 DB등 서버에서 관리가 가능한 방법으로 처리해 주시기 바랍니다.	
	// 2. 본 예제에 세팅된 데이터는 샘플이므로 실제 연동 시 각 항목에 맞는 값을 세팅해 주시기 바랍니다.
	//-----------------------------------------------------------------------------------------------------------------------
	
	//-------------------------------------------------------------------------
	// (1) shop.jsp : 테스트 쇼핑몰 페이지 입니다.
	//-------------------------------------------------------------------------
	
	request.setCharacterEncoding("UTF-8");
	
	final String pgID = "PGID14F495EBD4C"; 	// PG사 고유 아이디
	
	// 1. 사용자 입력값을 제외한 결제에 필요한 정보를 서버로부터 가져옵니다.
	String cardsa_name = "KB국민카드";		// 01.카드사명
	//String amount = "";					// 02.결제금액
	String currency = "410";				// 03.통화코드
	String aff_name = "테스트가맹점";				// 04.가맹점명
	String aff_biz_no = "1234567890";		// 05.가맹점 사업자번호
	String aff_tran_ip = "192.168.0.1";		// 06.CLIENT_IP
	String aff_type = "M";					// 07.가맹점 유형
	String aff_code = "1234";				// 08.가맹점 코드	
	String return_url = "";					// 09.RETURN URL
	String pg_cp_code = "CP1234";			// 10.PG사 관리 CP 코드
	String pg_req_date = "20140402";		// 11.PG사 요청일자 (yyyyMMdd)
	String pg_req_time = "133012";			// 12.PG사 요청시각 (HHmmss)
	//String save_pay_option = "";			// 13.세이브결제 옵션 처리	
	//String easy_pay_option = "";			// 14.간편결제 옵션 처리
	String pay_type = "1";					// 15.결제 타입
	String pg_biz_no = "0987654321";		// 16.PG사업자번호
	String tran_user_id = "kbcard123";		// 17.거래 사용자 정보
	//String noint_inf = "";				// 18.무이자 할부 정보
	//String quota_inf = "";				// 19.일반할부개월수 정보
	//String noInt_flag1 = "";				// 20.무이자 또는 공백 표시
	//String noInt_flag2 = "";				// 21.유무이자 할부 디스플레이 정보
	//String kb_savepointree = "";			// 22.KB 세이브포인트리 연동
	//String fixPayflag = "";				// 23.복합결제 연동 플래그
	String merchant_kb = pgID;				// 24.대표 가맹점 ID
	//String server_mode = "";				// 25. 서버 모드 ("TRUE": 상용, "FALSE": 개발)
	//String accpreq_url = "";				// 26. accpreq.jsp 경로
	//String is_only_appcard = "";			// 27. KB앱카드 바로결제 여부 ("TRUE": 앱카드 바로결제, "FALSE": 앱카드/ISP 결제 선택)
	String order_no = "123456789012345";	// 28. 가맹점 고유 거래식별번호(주문번호)
	String is_liquidity = "N";				// 29. 환금성 상품 여부 ("Y": 환금성 상품, "N" 또는 "": 환금성 상품 아님)
	
	// 2. 사용자 입력값은 평문(JSONString)으로 전달합니다. (아래는 샘플이므로 상황에 맞게 암호화할 데이터와 평문으로 전달될 데이터를 구분해 주시기 바랍니다.)
	
	// JSON 매핑 후 암호화
	JSONObject json = new JSONObject();
	json.put("cardsaName", cardsa_name);
	json.put("currency", currency);
	json.put("affiliateName", aff_name);
	json.put("affiliateBizNo", aff_biz_no);
	json.put("affiliateTranIP", aff_tran_ip);
	json.put("affiliateType", aff_type);
	json.put("affiliateCode", aff_code);	
	json.put("returnURL", return_url);
	json.put("pgCPcode", pg_cp_code);
	json.put("pgReqDate", pg_req_date);
	json.put("pgReqTime", pg_req_time);
	json.put("payType", pay_type);
	json.put("pgBizNo", pg_biz_no);
	json.put("tranUserID", tran_user_id);
	json.put("merchantKB", merchant_kb);
	json.put("orderNo", order_no);
	json.put("isLiquidity", is_liquidity);
	
	String encData = "";
	try {
		// 암복호화에 필요한 seedKey 생성 (16자리 문자열)
		// 생성형식 : aff_biz_no 뒤 4자리 +  pg_req_date 뒤 6자리 + pg_req_time 6자리로
		String seedKey = aff_biz_no.substring(6, 10) + pg_req_date.substring(2, 8) + pg_req_time;
		
		// seedKey 세션 저장
		request.getSession().setAttribute("seedKey", seedKey);
		
		// 데이터 암호화
		encData = SPCLib.encSEED(seedKey, json.toJSONString());
	} catch(Exception e) {	// 예외처리
		e.printStackTrace();
		out.print("<script>alert('인증 데이터 처리에 실패 하였습니다. 다시 시도해 주십시오.(2001)');</script>");
		return;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>PG 결제 테스트 - PC Online</title>

<script type="text/javascript" src="https://srcode.net/tcode/js/json2.js"></script>
<script type="text/javascript" src="https://srcode.net/tcode/js/acpay2.js"></script>
<script type="text/javascript">

	// 결제 요청 
	function doOrder() {
		var f = document.form_acp_payment;
		
		var param = {
			amount			: f.amount.value 			// 02.결제금액
			, savePayOption	: f.save_pay_option.value	// 13.세이브결제 옵션 처리
			, easyPayOption	: f.easy_pay_option.value	// 14.간편결제 옵션 처리
			, nointInf		: f.noint_inf.value			// 18.무이자 할부 정보
			, quotaInf		: f.quota_inf.value			// 19.일반할부개월수 정보
			, noIntFlag1	: f.noint_flag1.value		// 20.무이자 또는 공백 표시
			, noIntFlag2	: f.noint_flag2.value		// 21.유무이자 할부 디스플레이 정보
			, kbSavePointree: f.kb_savepointree.value	// 22.KB 세이브포인트리 연동
			, fixPayFlag	: f.fixpayflag.value		// 23.복합결제 연동 플래그
		};
		
		var data = JSON.stringify(param);
		data = encodeURIComponent(data);

		doACPAY4('<%=encData%>'					// 암호화된 결제 정보
				, data 							// 사용자의 선택에 의한 결제 정보 (JSONString)
				, f.server_mode.value			// 25. 서버 모드
				, f.accpreq_url.value			// 26. accpreq.jsp 경로
				, f.is_only_appcard.value		// 27. 앱카드 바로결제 여부
		);
	}

	// 결제창에서 ISP 결제 선택 시 호출
	function goISP() {
		doACPAY2_Cancel();
		
		setTimeout(function(){
			// ISP 결제 모듈을 호출하셔야 합니다.
			alert('ISP 결제 모듈 호출!!');
		}, 300);
	}

	// 사용자가 결제창을 닫았을 경우 호출
	function onACPAYCancel() {
		doACPAY2_Cancel();
		
		setTimeout(function(){
			alert('결제가 취소 되었습니다.');
		}, 300);
	}

	// 결제(승인) 결과 호출
	function onACPAYResult(resultCode) {
		doACPAY2_Cancel();
		
		setTimeout(function(){
			if('0000' == resultCode) {
				alert('결제가 완료되었습니다.');
			} else {
				alert('결제에 실패하였습니다. (' + resultCode + ')');
			}
		}, 300);
	}

	// 결제 도중 오류 발생 시 호출
	function onACPAYError(code) {
		doACPAY2_Cancel();
		
		setTimeout(function(){
			switch(code) {
				case 1001: alert('팝업 차단 설정 해제 후 다시 결제를 해 주십시오.(1001)'); 		break;	// 팝업 차단 설정이 되어 있는 경우
				case 2001: alert('인증 데이터 처리에 실패 하였습니다. 다시 시도해 주십시오.(2001)'); break;	// 인증 데이터 암호화 실패
				case 2002: alert('인증 데이터 처리에 실패 하였습니다. 다시 시도해 주십시오.(2002)'); break;	// 인증 데이터 암호화 실패
				case 3001: alert('거래키 발급에 실패하였습니다. 다시 시도해 주십시오.(3001)'); 	break;	// 거래키 발급 실패
				case 3002: alert('인증 데이터 처리에 실패하였습니다. 다시 시도해 주십시오.(3002)'); 	break;	// 인증 데이터 복호화 실패
				case 9101: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9101)'); 	break;	// 결제 코드 발급 실패 - 시스템 오류
				case 9102: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9102)'); 	break;	// 결제 코드 발급 실패 - acpKey 복호화 오류
				case 9103: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9103)'); 	break;	// 결제 코드 발급 실패 - acpKey 타임아웃
				case 9104: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9104)'); 	break;	// 결제 코드 발급 실패 - acpReq 복호화 오류
				case 9105: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9105)'); 	break;	// 결제 코드 발급 실패 - Hash mac 불일치
				case 9106: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9106)'); 	break;	// 결제 코드 발급 실패 - acpReq json 형식 오류
				case 9199: alert('거래 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9199)'); 	break;	// 거래 코드 발급 실패 - 시스템 오류
				case 9201: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9201)'); 	break;	// 거래키 요청 실패 - 시스템 오류
				case 9202: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9202)'); 	break;	// 거래키 요청 실패 - 유효하지 않은 pollingToken (pollingToken 복호화 오류) 
				case 9203: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9203)'); 	break;	// 거래키 요청 실패 - 유효하지 않은 pollingToken (pollingToken 타임아웃)
				case 9204: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9204)'); 	break;	// 거래키 요청 실패 - 해당 결제코드가 유효하지 않습니다. (결제코드가 존재하지 않음)
				case 9205: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9205)'); 	break;	// 거래키 요청 실패 - 유효하지 않은 pollingToken (결제코드 불일치)
				case 9206: alert('결제 인증 시간이 만료되었습니다. 다시 시도해 주십시오.(9206)'); 	break;	// 거래키 요청 실패 - 해당 결제코드의 거래시간이 만료 (결제코드 타임아웃)
				case 9207: alert('이미 결제된 코드입니다. 다시 시도해 주십시오.(9207)'); 		break;	// 거래키 요청 실패 - 해당 결제코드는 처리완료 되었습니다. (이미 결제 완료 처리됨)
				case 9299: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9299)'); 	break;	// 거래키 요청 실패 - 시스템 오류
				default: alert('결제 도중 오류가 발생하였습니다. 다시 시도해 주십시오.('+code+')');	break;	// 기타 오류
			}
		}, 300);
	}
</script>
</head>
<body>
	<form id="form_acp_payment" name="form_acp_payment" method="post" action="./shop2.jsp">
		<input type="hidden" id="encData" name="encData" value="<%=encData%>"/>
		<table>
<%-- 			<tr><td>01.카드사명</td><td><input type="text" id="cardsa_name" name="cardsa_name" value="KB국민카드" />&nbsp;Ex) KB국민카드: “KB”</td></tr> --%>
			<tr><td>02.결제금액</td><td><input type="text" id="amount" name="amount" value="1004" />&nbsp;Ex) 1,004원: “1004”</td></tr>
<%--			<tr><td>03.통화코드</td><td><input type="text" id="currency" name="currency" value="410" />&nbsp;통화코드 - 한화 : “410”, 달러 : “840”</td></tr>--%>
<%--			<tr><td>04.가맹점명</td><td><input type="text" id="aff_name" name="aff_name" value="테스트가맹점" />&nbsp;가맹점 명</td></tr>--%>
<%--			<tr><td>05.가맹점 사업자번호</td><td><input type="text" id="aff_biz_no" name="aff_biz_no" value="1234567890" />&nbsp;가맹점 사업자 번호 (‘-‘ 제외)</td></tr>--%>
<%--			<tr><td>06.CLIENT IP</td><td><input type="text" id="aff_tran_ip" name="aff_tran_ip" value="192.168.0.1" />&nbsp;CLIENT IP Ex) “192.168.0.1”</td></tr>--%>
<%--			<tr><td>07.가맹점 유형</td><td><input type="text" id="aff_type" name="aff_type" value="M" />&nbsp;가맹점 유형 - KB: “M”</td></tr>--%>
<%--			<tr><td>08.가맹점 코드</td><td><input type="text" id="aff_code" name="aff_code" value="1234" />&nbsp;가맹점 코드(번호): 카드사에서 부여한 코드</td></tr>--%>
<%--			<tr><td>09.returnURL</td><td><input type="text" id="return_url" name="return_url" value="" />&nbsp;RETURN URL: PC 온라인 결제 시에는 공란 Ex) PC온라인 결제 시 공란 “”</td></tr>--%>
<%--			<tr><td>10.PG사 관리 CP코드</td>	<td><input type="text" id="pg_cp_code" name="pg_cp_code" value="CP1234" />&nbsp;PG사 관리 CP 코드: PG사 내부 관리용 코드 Ex) “CP1234”</td></tr>--%>
<%--			<tr><td>11.PG사 요청일자</td><td><input type="text" id="pg_req_date" name="pg_req_date" value="20131114" />&nbsp;PG사 요청일자 (yyyyMMdd) Ex) 2013년11월14일: “20131114”</td></tr>--%>
<%--			<tr><td>12.PG사 요청시각</td><td><input type="text" id="pg_req_time" name="pg_req_time" value="133012" />&nbsp;PG사 요청일시 (hhMMss) Ex) 13시30분13초: “133012”</td></tr>--%>
			<tr><td>13.세이브결제 옵션처리</td><td><input type="text" id="save_pay_option" name="save_pay_option" value="" />&nbsp;세이브결제 옵션 처리: 공란(“”) 처리</td></tr>
			<tr><td>14.간편결제 옵션처리</td><td><input type="text" id="easy_pay_option" name="easy_pay_option" value="" />&nbsp;간편결제 옵션 처리: 공란(“”) 처리</td></tr>
<%--			<tr><td>15.결제 방식</td><td><input type="text" id="pay_type" name="pay_type" value="1" />&nbsp;결제방식 - PC온라인(“1”), 모바일(“2”), 오프라인(“3”)</td></tr>--%>
<%--			<tr><td>16.PG사 사업자 번호</td><td><input type="text" id="pg_biz_no" name="pg_biz_no" value="0987654321" />&nbsp;PG 사업자 번호 (‘-‘ 제외)</td></tr>--%>
<%--			<tr><td>17.거래 사용자 정보</td><td><input type="text" id="tran_user_id" name="tran_user_id" value="kbcard123" />&nbsp;거래 사용자 아이디: 사용자 아이디 (회원 아이디) Ex) “kbcard123”</td></tr>--%>
			<tr><td>18.무이자 할부 정보</td><td><input type="text" id="noint_inf" name="noint_inf" value="ALL" />&nbsp;무이자 할부 정보 - 무이자 없음: “NONE”, 전체 무이자: “ALL”, 할부 정의: “(카드코드)-(할부정보)” Ex) 국민카드 3,6,9개월 무이자 할부 가능: “0204-03:06:09”</td></tr>
			<tr><td>19.일반할부개월수 정보</td><td><input type="text" id="quota_inf" name="quota_inf" value="00:02:03" />&nbsp;일반 할부 개월 정보 - 할부 없음: “NONE”, 일시불, 3,4,5,6,7개월: “00:03:04:05:06:07” Ex) 일시불, 2개월, 3개월 할부 가능: “00:02:03”</td></tr>
			<tr><td>20.무이자 또는 공백 표시</td><td><input type="text" id="noint_flag1" name="noint_flag1" value="NOINT" />&nbsp;무이자 또는 공백 표시 - 무이자: “NOINT”, 없음: “TRUE”</td></tr>
			<tr><td>21.유무이자 할부 디스플레이 정보</td><td><input type="text" id="noint_flag2" name="noint_flag2" value="FALSE" />&nbsp;유무이자 할부 Display 정보 - 미표기: “TRUE”, 표기: “FALSE”</td></tr>
			<tr><td>22.KB 세이브포인트리 연동</td><td><input type="text" id="kb_savepointree" name="kb_savepointree" value="FALSE" />&nbsp;KB 세이브 포인트리 연동 - 호출: “TRUE”, 비호출: “FALSE”</td></tr>
			<tr><td>23.복합결제 연동 플래그</td><td><input type="text" id="fixpayflag" name="fixpayflag" value="TRUE" />&nbsp;복합결제 연동 Flag: 앱카드 앱에서 포인트리 사용 필드 표시 - 표시: “TRUE”, 미표시: “FALSE”</td></tr>
<%--			<tr><td>24.쇼핑몰 대표 가맹점ID</td><td><input type="text" id="merchant_kb" name="merchant_kb" value="" />&nbsp;대표 가맹점ID: 배포된 모듈에 포함되어 있는 PGID 15자리 (모듈 배포 시 발급) Ex) “PGID123A4567B89”</td></tr>--%>
 			<tr><td>25.서버 모드</td>	<td><input type="text" id="server_mode" name="server_mode" value="FALSE" />&nbsp;서버 모드 - 상용서버: “TRUE”, 개발서버: “FALSE”</td></tr> 
			<tr><td>26.accpreq.jsp 경로</td><td><input type="text" id="accpreq_url" name="accpreq_url" value="./accpreq.jsp" />&nbsp;accpreq.jsp 경로: 상대경로 - “./accpreq.jsp” ※ 가맹점과 동일 서버에 위치</td></tr>
			<tr><td>27.KB앱카드 바로결제 여부</td><td><input type="text" id="is_only_appcard" name="is_only_appcard" value="FALSE" />&nbsp;KB앱카드 바로결제 여부 -결제방법 선택 없이 KB앱카드 결제: “TRUE” - 결제방법 선택 가능 (KB앱카드, ISP): “FALSE” ※ 기본값: “FALSE”</td></tr>
			
			<tr><td></td><td><br/><input type="button" value="결제하기" onclick="doOrder();" /> </td></tr>
		</table>
</form>
</body>
</html>