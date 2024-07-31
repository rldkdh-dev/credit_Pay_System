<%@page contentType="text/html; charset=UTF-8"
        import="acp.pg.ACPLib" %>
<% // acp.pg.ACPLib 패키지 포함(메시지 생성 사용)
	//-------------------------------------------------------------------------
    // (3) accpreqMW.jsp : 취합된 결제 정보를 암호화 하고, 결제 창에 카드사 결제 화면을 로드합니다.
    //-------------------------------------------------------------------------
    request.setCharacterEncoding("UTF-8");
        
    final String pgID = "PGID14F495EBD4C";                          // PG사 고유 아이디

    String key = request.getParameter("key");                       // 암호화된 인증키 값
    String encData = request.getParameter("encData");               // 암호화된 결제 정보
    String accpresURL = request.getParameter("accpresURL");         // accpres.jsp 절대 경로
    String resultURL = request.getParameter("resultURL");           // result.jsp 절대 경로
    String serverMode = request.getParameter("serverMode");         // 서버모드 ("TRUE": 상용, "FALSE": 개발)
    String isOnlyAppcard = request.getParameter("isOnlyAppcard");   // KB앱카드 바로결제 여부 ("TRUE": 앱카드 직결제, "FALSE": 앱카드/ISP 결제 선택)
    String affiliateBizNo = request.getParameter("affiliateBizNo"); // 가맹점 사업자 번호
%>
<script type="text/javascript">
    window.onload = function() {
        var server_url = 'TRUE' == ('<%=serverMode%>').toUpperCase()
                ? 'https://customer.kbcard.com/CXCACZZC0001.cms'            // 상용서버
                : 'https://dmobileapps.kbcard.com:15000/CXHSPTSC0012.cms';  // 개발서버
                
        document.frmPop.action = server_url;
        document.frmPop.submit();
    };
</script>
<form id="frmPop" name="frmPop" method="post">
    <input type="hidden" name="key" id="key" value="<%=key%>" />
    <input type="hidden" name="data" id="data" value="<%=encData%>" />
    <input type="hidden" name="pgID" id="pgID" value="<%=pgID%>" />
    <input type="hidden" name="accpresURL" id="accpresURL" value="<%=accpresURL%>" />
    <input type="hidden" name="resultURL" id="resultURL" value="<%=resultURL%>" />
    <input type="hidden" name="isOnlyAppcard" id="isOnlyAppcard" value="<%=isOnlyAppcard%>" />
    <input type="hidden" id="affiliateBizNo" name="affiliateBizNo" value="<%=affiliateBizNo%>" />
</form>
