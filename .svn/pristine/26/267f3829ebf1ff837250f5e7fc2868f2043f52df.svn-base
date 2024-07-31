<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="mobile.Insurance"%>
<%@ page import="mobile.DataModel"%>
<%@ page import="util.CommonUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="kr.co.infinisoft.pg.common.SeedUtil"%>
<%@ page import="mobile.MailMessage"%> 
<%@ page import="mobile.MailSendBean"%>

<%

	String seq = CommonUtil.getDefaultStr(request.getParameter("seq"), "");

	try{
		
		//복호화
		seq = SeedUtil.getConceal(seq);
		
	}catch(Exception e){
		out.println("<script>alert('잘못된 호출입니다.');</script>");
		return;
	}
	
	if (seq.equals("")) {
		out.println("<script>alert('잘못된 호출입니다.');</script>");
		return;
	}
	
	Insurance insurance = new Insurance();
	DataModel param = new DataModel();
	param.put("seq", seq);
	
	List<DataModel> aList = insurance.getInsuranceSendList(param);
	
	if(aList.size() > 0){
		DataModel map = (DataModel)aList.get(0);
		
		if(!map.getStrNull("recv_yn").equals("Y")){
			insurance.updateInsuranceSendRecv(param);
		}
		
		List<DataModel> aList2 = insurance.getInsuranceList(map);
		
		if(aList2.size() > 0){
			DataModel map2 = (DataModel)aList2.get(0);
			
			map.put("co_no", map2.getStrNull("co_no"));
			map.put("pg_cd", map2.getStrNull("pg_cd"));
			map.put("limit_cl", map2.getStrNull("limit_cl"));
			map.put("insurance_amt", map2.getStrNull("insurance_amt"));
			map.put("limit_amt", map2.getStrNull("limit_amt"));
			map.put("fr_dt", map2.getStrNull("fr_dt"));
			map.put("to_dt", map2.getStrNull("to_dt"));
			map.put("cash_amt", map2.getStrNull("cash_amt"));
			map.put("instmn", map2.getStrNull("instmn"));
			map.put("recv_email", map2.getStrNull("recv_email"));
			map.put("reg_dtm", map2.getStrNull("reg_dtm"));
			map.put("memo", map2.getStrNull("memo"));
			
		}
		
		DataModel useMap = insurance.getInsuranceServiceUseInfo(map);
	  	map.put("card_yn", useMap.getStrNull("card_yn"));	    		  	
	  	map.put("accnt_yn", useMap.getStrNull("accnt_yn"));
	  	map.put("vbank_yn", useMap.getStrNull("vbank_yn"));
	  	map.put("recpt_yn", useMap.getStrNull("recpt_yn"));
	  	map.put("card_keyin_yn", useMap.getStrNull("card_keyin_yn"));
	  	map.put("card_ars_yn", useMap.getStrNull("card_ars_yn"));
	  	map.put("sms_keyin_yn", useMap.getStrNull("sms_keyin_yn"));
	  	map.put("sms_auth_yn", useMap.getStrNull("sms_auth_yn"));
	  	map.put("card_auto_yn", useMap.getStrNull("card_auto_yn"));
	  	map.put("card_auth_yn", useMap.getStrNull("card_auth_yn"));
	  	
	  	out.print(insurance.getTemplate(map));
	  	
	  	try{
	  		
	  		if(!map.getStrNull("recv_yn").equals("Y")){
		  		MailSendBean mailSendBean = new MailSendBean();
		  		MailMessage mailMessage = new MailMessage();
				mailMessage.setSubject("인피니소프트_보증보험("+map.getStrNull("co_nm")+") 갱신 요청이 접수되었습니다.");
				mailMessage.setToAddr("sales@infinisoft.co.kr");
				mailMessage.setContent(insurance.getTemplate02(map)+"");
				mailSendBean.doSendMail(mailMessage);
				
				//테스트
				mailMessage.setToAddr("stardory@infinisoft.co.kr");
				mailSendBean.doSendMail(mailMessage);
	  		}
			
	  	}catch(Exception e){
	  		
	  	}
		
	}

%>
