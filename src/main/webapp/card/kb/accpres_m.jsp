<%@page contentType="text/html; charset=UTF-8"
        import="acp.pg.ACPLib" %>
<% // acp.pg.ACPLib 패키지 포함(메시지 해석 사용)
    //-------------------------------------------------------------------------
    // (5) accpres.jsp : 결제 인증 후 전달받은 전문 데이터를 복호화 하며, 결제 결과를 전달합니다
    //-------------------------------------------------------------------------
    request.setCharacterEncoding("UTF-8");

    String xid = "";
    String accres = request.getParameter("accres");     // 암호화된 결과값
    
    String rcd = "";
    String tkey = "";
    String decData = "";
    String[] res = null;
    
    String noint = "";
    String quota = "";
    String cardCode = "";
    String cardPrefix = "";
    String coName = "";
    String paySetFlag = "";
    String usingPoint = "";
    String orderNo = "";
    
    try {
        xid = (String) session.getAttribute("xid");     // 거래식별번호(쇼핑몰생성)
        
        res = ACPLib.getACPResV1(xid, accres); // (C) - XID기반으로 거래 정보 복호화
        
        rcd = res[0];       // 결과코드
        tkey = res[1];      // 01.거래키 (OTC 번호 21자리)
        decData = res[2];   // 기타 거래 정보
        
        // 거래 실패
        if(tkey == null || "".equals(tkey)) {
            System.out.println("거래키를 정상적으로 수신하지 못했습니다..");
            out.print("<script>window.parent.onACPAYError(3001);</script>");
            return;
        }
        
        noint = ACPLib.getValue(decData, "noint");              // 02.무이자 할부값 (무이자: “1”, 일반: “0”)
        quota = ACPLib.getValue(decData, "quota");              // 03.선택한 할부 개월수 (일시불: “00”, 3개월: “03”)
        cardCode = ACPLib.getValue(decData, "cardCode");        // 04.카드 코드값
        cardPrefix = ACPLib.getValue(decData, "cardPrefix");    // 05.카드번호 앞 6자리
        coName = ACPLib.getValue(decData, "coName");            // 06.카드 제휴명
        paySetFlag = ACPLib.getValue(decData, "paySetFlag");    // 07.복합결제 사용여부
        usingPoint = ACPLib.getValue(decData, "usingPoint");    // 08.복합결제 사용포인트
        orderNo = ACPLib.getValue(decData, "orderNo");          // 09.가맹점 고유 거래식별번호(주문번호)
        
        // 결제 응답 파라미터 출력
        System.out.println("###################################################");
        System.out.println("rcd(결과코드) [" + rcd + "]");
        System.out.println("tkey(OTC번호) [" + tkey + "]");
        System.out.println("noint(무이자여부) [" + noint + "]");
        System.out.println("quota(할부개월수) [" + quota + "]");
        System.out.println("cardCode(카드사제휴코드) [" + cardCode + "]");
        System.out.println("cardPrefix(카드번호 앞6자리) [" + cardPrefix + "]");
        System.out.println("coName(카드제휴명) [" + coName + "]");
        System.out.println("paySetFlag(포인트리 사용여부) [" + paySetFlag + "]");
        System.out.println("usingPoint(사용 포인트리) [" + usingPoint + "]");
        System.out.println("orderNo(주문번호) [" + orderNo + "]");
        System.out.println("###################################################");
    } catch(Exception e) { // 예외처리
        e.printStackTrace();
        out.print("<script>window.parent.onACPAYError(3002);</script>");
        return;
    }
    
    // 라이브러리 버전 확인
    String signature = ACPLib.getVersion();
    
    // TODO: 복호화 된 데이터로 VAN사 승인 전문 요청
    
    // 결제 결과를 shopMW2.jsp 로 전달하기 위한 코드
    String resultCode = "0000";    
%>
<script type="text/javascript">
    window.onload = function() {
        // 결제 결과 전달
        var appPayFrm = window.parent.tranMgr;

        appPayFrm.KVP_ENCDATA.value = '<%=tkey%>';
        appPayFrm.KVP_NOINT.value = '<%=noint%>';
        appPayFrm.KVP_QUOTA.value = '<%=quota%>';
        appPayFrm.KVP_CARDCODE.value = '<%=cardCode%>';
        window.parent.onACPAYResult('<%=resultCode%>');
    };
</script>