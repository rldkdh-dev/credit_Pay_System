<%@page contentType="text/html; charset=UTF-8"
		import="acp.pg.ACPLib
				, kr.co.seeroo.spclib.SPCLib
				, org.json.simple.JSONObject
				, org.json.simple.JSONValue
				, java.net.URLDecoder,org.apache.commons.lang.StringUtils,java.util.*" %><% // acp.pg.ACPLib 패키지 포함(메시지 생성 사용)
	//-------------------------------------------------------------------------
	// (2) accpreq.jsp : 취합된 결제 정보를 암호화 하고, 결제 창에 카드사 결제 화면을 로드합니다.
	//-------------------------------------------------------------------------
	request.setCharacterEncoding("UTF-8");
	
	final String pgID = "PGID14F495EBD4C"; 							// PG사 고유 아이디
	
	String encData = request.getParameter("encData"); 				// 스크립트에 의해 전달되는 암호화된 데이터
	String jsonData = request.getParameter("jsonData"); 			// 스크립트에 의해 전달되는 평문 JSONString 데이터
	String serverMode = request.getParameter("serverMode");			// 서버 모드 ("TRUE": 상용, "FALSE": 개발)
	String isOnlyAppcard = request.getParameter("isOnlyAppcard");	// 앱카드 바로결제 여부 ("TRUE": 앱카드 바로결제, "FALSE": 앱카드/ISP 결제 선택)
	
	String decData = "";
	String key = "";
	String encData2 = "";
	String signature = ACPLib.getVersion(); 		// 전문 생성 라이브러리 버전 정보
	String affiliateBizNo = "";
	//String seedKey = (String) request.getSession().getAttribute("seedKey");	// 세션에 저장되어 있는 seedKey
	String seedKey = request.getParameter("seedKey");    // seedKey
	System.out.println("**** accpreq seedKey ["+seedKey+"]");
	
	JSONObject json1 = null;
	JSONObject json2 = null;
	JSONObject combJson = null;
	String xid = "";
	
	try {		
		// 1. 암호화된 데이터는 복호화 후 JSON 형태로 파싱합니다.
		decData = SPCLib.decSEED(seedKey, encData);
		
		Object obj1 = JSONValue.parse(decData);
		json1 = (JSONObject) obj1;
		
		// 2. 평문 JSONString 데이터는 JSON 형태로 파싱합니다.
		Object obj2 = JSONValue.parse(URLDecoder.decode(jsonData, "UTF-8"));
		json2 = (JSONObject) obj2;
		
		affiliateBizNo = (String) json1.get("affiliateBizNo");
		
		// 3. 결제 정보를 모두 취합하여 JSONString 으로 만듭니다.
		combJson = new JSONObject();
		combJson.put("cardsaName", json1.get("cardsaName"));			// 01.카드사명
		combJson.put("currency", json1.get("currency"));				// 03.통화코드
		combJson.put("affiliateName", json1.get("affiliateName"));		// 04.가맹점명
		combJson.put("affiliateBizNo", json1.get("affiliateBizNo"));	// 05.가맹점 사업자번호
		combJson.put("affiliateTranIP", json1.get("affiliateTranIP"));	// 06.CLIENT_IP
		combJson.put("affiliateType", json1.get("affiliateType"));		// 07.가맹점 유형
		combJson.put("affiliateCode", json1.get("affiliateCode"));		// 08.가맹점 코드	
		combJson.put("returnURL", json1.get("returnURL"));				// 09.RETURN URL
		combJson.put("pgCPcode", json1.get("pgCPcode"));				// 10.PG사 관리 CP 코드
		combJson.put("pgReqDate", json1.get("pgReqDate"));				// 11.PG사 요청일자
		combJson.put("pgReqTime", json1.get("pgReqTime"));				// 12.PG사 요청시각
		combJson.put("payType", json1.get("payType"));					// 15.결제 타입
		combJson.put("pgBizNo", json1.get("pgBizNo"));					// 16.PG사업자번호
		combJson.put("tranUserID", json1.get("tranUserID"));			// 17.거래 사용자 정보
		combJson.put("merchantKB", json1.get("merchantKB"));			// 24.대표 가맹점 ID
		combJson.put("orderNo", json1.get("orderNo"));					// 28. 가맹점 고유 거래식별번호(주문번호)
		combJson.put("isLiquidity", json1.get("isLiquidity"));			// 29. 환금성 상품 여부
		
		combJson.put("amount", json2.get("amount"));					// 02.결제금액
		combJson.put("savePayOption", json2.get("savePayOption"));		// 13.세이브결제 옵션 처리	
		combJson.put("easyPayOption", json2.get("easyPayOption"));		// 14.간편결제 옵션 처리
		combJson.put("nointInf", json2.get("nointInf"));				// 18.무이자 할부 정보
		combJson.put("quotaInf", json2.get("quotaInf"));				// 19.일반할부개월수 정보
		combJson.put("noIntFlag1", json2.get("noIntFlag1"));			// 20.무이자 또는 공백 표시
		combJson.put("noIntFlag2", json2.get("noIntFlag2"));			// 21.유무이자 할부 디스플레이 정보
		combJson.put("kbSavePointree", json2.get("kbSavePointree"));	// 22.KB 세이브포인트리 연동
		combJson.put("fixPayFlag", json2.get("fixPayFlag"));			// 23.복합결제 연동 플래그
		
		// 4. JSONString 으로 만든 데이터를 암호화합니다.
		String[] ret = ACPLib.getACPReqV1(combJson.toJSONString()); 	// 인증 데이터 생성
		String rcd = ret[0];
		
		if("ACPR0000".equals(rcd)) {	// 인증 데이터 생성 성공
			key = ret[1];		// 암호화 키
			encData2 = ret[2]; 	// 암호화 된 데이터
			//request.getSession().setAttribute("xid", ret[3]);	// xid 세션에 저장
			xid=ret[3];
		} else {							// 예외처리
			System.out.println("인증 데이터 암호화에 실패하였습니다.. 결과코드 [" + rcd + "]");
			out.print("<script>parent.window.opener.onACPAYError(2001); self.close();</script>");
			return;
		}
	} catch(Exception e) {		// 예외처리		
		e.printStackTrace();	
		out.print("<script>parent.window.opener.onACPAYError(2002); self.close();</script>");
		return;
	}
	
	String succUrl = "";
	String failUrl = "";
	if (request.getServerPort() == 80 || request.getServerPort() == 443) {
        succUrl = request.getScheme() + "://" + request.getServerName() +"/ipay/card/kb/accpres.jsp?xid="+xid;
        failUrl = request.getScheme() + "://" + request.getServerName() +"/ipay/card/kb/accperr.jsp";
    } else {
        succUrl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort()+"/ipay/card/kb/accpres.jsp?xid="+xid;
        failUrl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort()+"/ipay/card/kb/accperr.jsp";
    } 
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Expires" content="1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-Cache" />
<title>K-MOTION 앱카드 결제</title>
<style type="text/css">
	body { margin: 0; padding: 0; margin: 0 auto 0 auto; overflow: hidden; }
</style>
<script type="text/javascript">

	var server_url = 'TRUE' == ('<%=serverMode%>').toUpperCase()
			? 'https://customer.kbcard.com/CXCACZZC0001.cms'			// 상용서버
			: 'https://dmobileapps.kbcard.com:15000/CXHSPTSC0012.cms';	// 개발서버
			
	var isClosing = true;	// 팝업창 닫기 'X' 버튼 처리

	window.onload = function() {
		if(window.attachEvent) {
			window.attachEvent('onunload', function(){
				if(isClosing) onCancel();
			});
		} else if(document.addEventListener) {
			window.onbeforeunload = function(){
				if(isClosing) onCancel();
			};
		} else {
			document.addEventListener('unload', function(){
				if(isClosing) onCancel();
			}, false);	
		}
		
		var f = document.form_accpreq;
		f.action = server_url;
		f.submit();
	};

	function onSuccess(resCode, resMsg, apprNo) {
		isClosing = false;

		try {
			if(!window.closed) { setTimeout(function(){top.window.close();},0); }
			if(window.opener) { window.opener.onACPAYResult(resCode, resMsg, apprNo); }
		} catch(e) {}
	}

	function onISP() {
		isClosing = false;

		try {
			if(!window.closed) { setTimeout(function(){top.window.close();},0); }
			if(window.opener) { window.opener.goISP();self.close(); }
		} catch(e) {}
	}

	function onCancel() {
		isClosing = false;

		try {
			if(!window.closed) { setTimeout(function(){top.window.close();},0); }
			if(window.opener) { window.opener.onACPAYCancel(); }
		} catch(e) {}
	}

	function onError(code) {
		isClosing = false;

		try {
			if(!window.closed) { setTimeout(function(){top.window.close();},0); }
			if(window.opener) { window.opener.onACPAYError(code); }
		} catch(e) {}
	}
	
</script>
</head>
<body>
	<iframe name="kbframe" id="kbframe" src="" width="500" height="500" frameBorder="0"></iframe>
	<form name="form_accpreq" target="kbframe" method="post" >
		<input type="hidden" id="pgID" name="pgID" value="<%=pgID%>" />
		<input type="hidden" id="key" name="key" value="<%=key%>" />
		<input type="hidden" id="data" name="data" value="<%=encData2%>" />
		<input type="hidden" id="isOnlyAppcard" name="isOnlyAppcard" value="<%=isOnlyAppcard%>" />
		<input type="hidden" id="successURL" name="successURL" value="<%=succUrl%>" />
        <input type="hidden" id="failureURL" name="failureURL" value="<%=failUrl%>" />
		<input type="hidden" id="affiliateBizNo" name="affiliateBizNo" value="<%=affiliateBizNo%>" />
	</form>
</body>
</html>