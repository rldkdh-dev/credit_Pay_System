<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 공통 파라미터 처리 파일 (계좌이체)
*	@ PROGRAM NAME		: bankParameter.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2018.01.15
*	@ PROGRAM CONTENTS	: 공통 파라미터 처리 파일 (계좌이체)
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*******************************************************************************/
%>
<%
	// 계좌이체에 사용하는 파라미터
	String hd_pre_msg_type  = CommonUtil.getDefaultStr(request.getParameter("hd_pre_msg_type"), "");
	String hd_msg_code      = CommonUtil.getDefaultStr(request.getParameter("hd_msg_code"), "");
	String hd_msg_type      = CommonUtil.getDefaultStr(request.getParameter("hd_msg_type"), "");
	String hd_ep_type       = CommonUtil.getDefaultStr(request.getParameter("hd_ep_type"), "");
	String hd_pi            = CommonUtil.getDefaultStr(request.getParameter("hd_pi"), "");
	String hd_approve_no    = CommonUtil.getDefaultStr(request.getParameter("hd_approve_no"), "");
	String hd_serial_no     = CommonUtil.getDefaultStr(request.getParameter("hd_serial_no"), "");
	String hd_firm_name     = CommonUtil.getDefaultStr(request.getParameter("hd_firm_name"), "");
	String tx_user_define   = CommonUtil.getDefaultStr(request.getParameter("tx_user_define"), "");
	String tx_user_key      = CommonUtil.getDefaultStr(request.getParameter("tx_user_key"), "");
	String tx_receipt_acnt  = CommonUtil.getDefaultStr(request.getParameter("tx_receipt_acnt"), "");
	String tx_receipt_bank  = CommonUtil.getDefaultStr(request.getParameter("tx_receipt_bank"), "");    
	String tx_amount        = CommonUtil.getDefaultStr(request.getParameter("tx_amount"), "");
	String hd_input_option  = CommonUtil.getDefaultStr(request.getParameter("hd_input_option"), "");
	String hd_ep_option     = CommonUtil.getDefaultStr(request.getParameter("hd_ep_option"), "");
	String hd_timeout_yn    = CommonUtil.getDefaultStr(request.getParameter("hd_timeout_yn"), "");
	String hd_timeout       = CommonUtil.getDefaultStr(request.getParameter("hd_timeout"), "");
	String tx_email_addr    = CommonUtil.getDefaultStr(request.getParameter("tx_email_addr"), "");
%>