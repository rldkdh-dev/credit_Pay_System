<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.io.*, java.lang.*, java.util.*, mobile.DataModel, service.SupportIssue , kr.co.infinisoft.pg.common.*"%>
<%    
    String strTID = request.getParameter("TID");
    String strType = request.getParameter("type");  // 0 : 매출전표, 거래확인서, 3 : 구매동의서(안심수기), -1 : Error
    String strTarget = request.getParameter("target") == null ? "popupIssue" : request.getParameter("target");
    
    boolean hideTopBar = MMSUtil.isNullOrEmpty(request.getParameter("hideTopBar")) ? false : "true".equalsIgnoreCase(request.getParameter("hideTopBar"));
    boolean hideButton  = MMSUtil.isNullOrEmpty(request.getParameter("hideButton")) ? false : "true".equalsIgnoreCase(request.getParameter("hideButton"));
    String param = "" + (hideTopBar ? "&hideTopBar=" + hideTopBar : "") + (hideButton ? "&hideButton=" + hideButton : "") ;

    String mid = "null";
    String svc_cd = "null";
    String state_cd = "null";

    String join_type = "null";
    String rcpt_cl = "null";

    DataModel map = new DataModel();
    map.put("TID", strTID);
    map.put("id_cl", "x");
    
    if("0".equals(strType) || "2".equals(strType)) {
      // tb_trans 정보
      SupportIssue si = new SupportIssue();
      List tlstRtn = si.getTransDetail(map);
      ArrayList taLst = (ArrayList)tlstRtn;
      
      if(taLst.size() > 0) {
        DataModel tmap = (DataModel)taLst.get(0);
        mid = tmap.getStr("mid");
        svc_cd = tmap.getStr("svc_cd");
        state_cd = tmap.getStr("state_cd");

        if("0".equals(strType)) {
          List mlstRtn = si.getMIDInfo(mid);
          ArrayList maLst = (ArrayList)mlstRtn;
          
          if(maLst.size() > 0) {
            DataModel mmap = (DataModel)maLst.get(0);
            join_type = mmap.getStr("join_type");
            rcpt_cl = mmap.getStr("rcpt_cl");
          } else {
            strType = "-1";
          }
        }
      } else {
        strType = "-1";
      }
    }
    // 안심수기 구매동의서
    else if("3".equals(strType)) {
    	// tb_trans 정보
        SupportIssue si = new SupportIssue();
        List tlstRtn = si.getTransDetail(map);
        ArrayList taLst = (ArrayList)tlstRtn;
        
        if(taLst.size() > 0) {
          DataModel tmap = (DataModel)taLst.get(0);
          mid = tmap.getStr("mid");
          svc_cd = tmap.getStr("svc_cd");
          
        } else {
          strType = "-1";
        }
    }
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script type="text/javascript">
<!--
  var url = "";
  var width = 500;
  //var height = 950;
  var height = 1000;


  if('<%= strType %>' == '0') {
    if('<%= svc_cd %>' == '01' && '<%= rcpt_cl %>' == '0') {
        if('<%= join_type%>' == '1') {
      
            url = "CardIssue.jsp";
        }
        else  {

            url = "CardIssue.jsp";  // 1개 형식으로 통일
        }
    }else if(('<%= svc_cd %>' == '16' && '<%= rcpt_cl %>' == '0') || ('<%= svc_cd %>' == '17' && '<%= rcpt_cl %>' == '0') ||
        	('<%= svc_cd %>' == '18' && '<%= rcpt_cl %>' == '0') || ('<%= svc_cd %>' == '18' && '<%= rcpt_cl %>' == '0')){
   	 url = "TransIssue.jsp";
    }
    else {
            //height = 745;
            width = 482;
            height = 1000;
            url = "TransIssue.jsp";
    }
  }
  // 안심수기결제 - 구매동의서
  else if('<%= strType %>' == '3') {
	  width = 495;
      height = 553;
	  url = "CardBuyAgree.jsp";
  }
  else {
    width=680;
    height=650;

    url="IssueError.jsp";
  }

  if('<%= strType %>' != '-1') url = url+"?TID=" + "<%= strTID %>" + "&svcCd="+"<%= svc_cd%>"+"<%= param %>";

  window.resizeTo(width+35,height+35);  // 여백
  window.open(url,"<%= strTarget %>");
//-->
</script>
</head>
<body>
</body>
</html>