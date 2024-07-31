<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="mobile.Homepage"%>
<%@ page import="mobile.DataModel"%>
<%@ page import="util.CommonUtil"%>
<%@ page import="java.util.*"%>

<%
	request.setCharacterEncoding("UTF-8");

	Homepage homepage = new Homepage();
	DataModel req = new DataModel();
	
	String svc_cd = request.getParameter("svc_cd");
	String fr_dt = request.getParameter("fr_dt");
	fr_dt = fr_dt.replaceAll(" ", "");
	fr_dt = fr_dt.replaceAll("\\.", "");
	
	String fr_dt2 = request.getParameter("fr_dt2");
	fr_dt2 = fr_dt2.replaceAll(" ", "");
	fr_dt2 = fr_dt2.replaceAll("\\.", "");	
	
	String fr_dt3 = request.getParameter("fr_dt3");
	fr_dt3 = fr_dt3.replaceAll(" ", "");
	fr_dt3 = fr_dt3.replaceAll("\\.", "");
	
	String to_dt = request.getParameter("to_dt");
	to_dt = to_dt.replaceAll(" ", "");
	to_dt = to_dt.replaceAll("\\.", "");
	
	String to_dt2 = request.getParameter("to_dt2");
	to_dt2 = to_dt2.replaceAll(" ", "");
	to_dt2 = to_dt2.replaceAll("\\.", "");	
	
	String to_dt3 = request.getParameter("to_dt3");
	to_dt3 = to_dt3.replaceAll(" ", "");
	to_dt3 = to_dt3.replaceAll("\\.", "");	
	
	String ord_email = request.getParameter("ord_email");
	String app_no = request.getParameter("app_no");
	String card_no = request.getParameter("card_no");
	String vacct_no = request.getParameter("vacct_no");
	String goods_amt = request.getParameter("goods_amt");
	String accnt_no = request.getParameter("accnt_no");
	String ord_nm = request.getParameter("ord_nm");
	String goods_amt_bank = request.getParameter("goods_amt_bank");
	
	req.put("svc_cd", svc_cd);
	req.put("fr_dt", fr_dt);
	req.put("to_dt", to_dt);
	req.put("fr_dt2", fr_dt2);
	req.put("to_dt2", to_dt2);	
	req.put("fr_dt3", fr_dt3);
	req.put("to_dt3", to_dt3);
	req.put("ord_email", ord_email);
	req.put("app_no", app_no);
	req.put("card_no", card_no);
	req.put("vacct_no", vacct_no);
	req.put("goods_amt", goods_amt);
	req.put("accnt_no", accnt_no);
	req.put("ord_nm", ord_nm);
	req.put("goods_amt_bank", goods_amt_bank);

	List<DataModel> dataList = new ArrayList<DataModel>();
	if(svc_cd.equals("01")) {
		dataList = homepage.getTransList(req);	
	}else if(svc_cd.equals("02")) {
		dataList = homepage.getBankTransList(req);
	}
	else if (svc_cd.equals("03")) {
		dataList = homepage.getVacctTransList(req);
	}
	

%>

<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta name="format-detection" content="telephone=no"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link rel='stylesheet' type='text/css' href='common/font.css'>
		<link rel="stylesheet" type="text/css" href="common/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="common/dataTables.bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="common/rowGroup.bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="common/common.css" />
		<script type="text/javascript" src="common/jquery-2.1.4.min.js"></script>
		<script type="text/javascript" src="common/jquery.dataTables.min.js"></script>
		<script type="text/javascript" src="common/dataTables.bootstrap.js"></script>
		<script type="text/javascript" src="common/dataTables.rowGroup.min.js"></script>
		<script type="text/javascript" src="common/common.js"></script>
		<title>결제내역 조회결과</title>
	</head>
	<script>
	
	function serIssue(TID) {
		window.open("/ipay/issue/IssueLoader.jsp?TID="+TID+"&type=0", "popupIssue", "width=" + 414 + ",height=" + 702 +", scrollbars=yes, resizable=yes", false);
	}
	
	</script>
	<body>

		<div class="container">
			<% if(svc_cd.equals("01")) { %>
			<h1>신용카드 결제내역</h1>
			<% } else if(svc_cd.equals("02")) { %>
			<h1>계좌이체 결제내역</h1>
			<% } else if(svc_cd.equals("03")) { %>
			<h1>가상계좌 결제내역</h1>
			<% } %>
			<table class="table table-hover">
				<thead>
					<tr class="sticky">
						<th>날짜순</th>
						<th>상품명순</th>
						<th>금액순</th>
						<th style="display: none;">카드영수증</th>
						<% if(svc_cd.equals("01")) { %>
						<th>카드순</th>
						<% } %>
						<th style="display: none;">가맹점순</th>
						<th style="display: none;">가맹점연락처</th>
					</tr>
				</thead>
				<tbody>
					<%
					for(DataModel map : dataList) {
					%>
					<tr class="unit">
						<td class="p_date"><%=map.getStrNull("app_dt")%> <%=map.getFormattedTime("app_tm")%></td>
						<td class="p_name"><%=map.getStrNull("goods_nm")%></td>
						<td class="p_price"><%=CommonUtil.setComma(map.getStrNull("goods_amt"))%><span>원</span></td>
						<td class="btn_td"><a href="javascript:serIssue('<%=map.getStrNull("tid")%>');" class="btn_show">영수증</a></td>
						<% if(svc_cd.equals("01")) { %>
						<td class="normal"><span class="d_title">카드:</span><%=map.getStrNull("card_nm")%></td>
						<% } %>
						<td class="normal"><span class="d_title">가맹점:</span><%=map.getStrNull("co_nm")%></td>
						<td class="normal"><span class="d_title">연락처:</span><%=map.getStrNull("tel_no")%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</body>
</html>	