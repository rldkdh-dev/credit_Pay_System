<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.lang.*, java.util.*, service.Mail, mobile.DataModel, service.SupportIssue, service.ReceiptMail, kr.co.infinisoft.pg.common.mail.MailMessage"%>
<%
    String tid = request.getParameter("TID");
    String svccd = request.getParameter("SvcCd");
    String statecd = request.getParameter("StateCd");
    String email = request.getParameter("e_mail");
    String URL = null;
    String subUrl = "/ipay/issue/TransIssueForm.jsp";
    String subject = null;
    String svcNm = "";
    DataModel dm = null;   // 현금영수증 정보조회
    String rcpt_flg = "";   // 현금영수증 구분
    String rcpt_tid = null; // 현금영수증 TID
    SupportIssue si = new SupportIssue();
    
    if("01".equals(svccd)){ // 신용카드
    	subUrl = "/ipay/issue/CardIssueForm.jsp";
    	svcNm="신용카드";
    }else if("02".equals(svccd)){    // 계좌이체
    	svcNm="계좌이체";
    }else if("03".equals(svccd)){   // 가상계좌
    	svcNm="가상계좌";
    }else if("04".equals(svccd)){   // 현금
    	svcNm="현금";
    	dm = si.getCashReceiptInfo(tid);
    	if(dm !=null && !dm.isEmpty()){
            System.out.println("**** dm "+dm.toString());
            rcpt_flg = dm.getStr("REQ_FLG");
            rcpt_tid = dm.getStr("TID");
            if("1".equals(rcpt_flg) || "2".equals(rcpt_flg) ){
               subUrl = "/ipay/issue/TaxSaveForm.jsp";
            }
        }
    }else if("16".equals(svccd)){
    	svcNm="카카오페이";   	
    }else if("17".equals(svccd)){
    	svcNm="L.Pay";
    }else if("18".equals(svccd)){
    	svcNm="PAYCO";
    }else if("19".equals(svccd)){
    	svcNm="SSGPAY";
    }else if("20".equals(svccd)){
    	svcNm="네이버페이";
    }else if("12".equals(svccd)){
        svcNm="계좌간편결제";
    }
    if (request.getServerPort() == 80 || request.getServerPort() == 443) {
        URL = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort() +subUrl;
    } else {
        URL = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort() +subUrl;
    }   
           
    if("0".equals(statecd)){
        subject = "[이노페이] "+svcNm+" 결제 내역 확인";
    }else{
        subject = "[이노페이] "+svcNm+" 취소 내역 확인";
    }
    
           
    ReceiptMail rm = new ReceiptMail(URL);
    String rtn = null;
    Mail sup = new Mail();
    MailMessage msg = new MailMessage();
    
    try{
        rtn = rm.getResource(tid, svccd);
        System.out.println("rtn ["+rtn+"]");
                
        msg.setToAddr(email);
//        msg.setFromAddr("pg@infinisoft.co.kr");
        msg.setSubject(subject);
        msg.setContent(rtn);
        // For TEST
        //sup.sendAuth(msg);
        // For Live
        sup.send(msg);
        
        System.out.println("ReceiptMail send OK ["+tid+"]["+email+"]");
%>
    <script type="text/javascript">
        alert('<%=email%>'+'로 발송되었습니다.');
    </script>
<%        
    }catch(Exception e){
        System.out.println("ReceiptMail send Exception ["+tid+"]["+email+"]");
%>
    <script type="text/javascript">
        alert('발송에 실패했습니다.');
    </script>
<%      
    }
%>