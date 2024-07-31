package service;

/**
 * ReceiptMail.java Class is Designed for providing 
 *
 * Copyright    Copyright (c) 2016
 * Company      Infinisoft Co.
 *
 * @Author      : 김봉민
 * @File        : service.ReceiptMail.java
 * @Version     : 1.0,
 * @See         : 
 * @Description : 
 * @Date        : 2017. 7. 7. - 오후 3:27:18
 * @ServiceID:
 * @VOID:
 * @Commnad:
 *
 **/

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpClientParams;
import org.apache.commons.httpclient.params.HttpConnectionParams;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ReceiptMail {
	private static final Logger logger = LoggerFactory.getLogger(ReceiptMail.class);
	private HttpClient client = null;
	private MultiThreadedHttpConnectionManager connectionManager = null;
	private String send_url = null;
	
	public ReceiptMail(String url) {
		this.send_url = url;
		connectionManager = new MultiThreadedHttpConnectionManager();
		
		HttpConnectionParams params = new HttpConnectionParams();
		params.setConnectionTimeout(10000);
		client = new HttpClient(new HttpClientParams(params) ,connectionManager);
	}

	public String getResource(String tid, String svc_cd){
		GetMethod get = null;
		String getUrl = null;
		String rtn = null;
		try{
			getUrl = send_url+"?TID="+tid+"&svcCd="+svc_cd;
			logger.info("getUrl {}", getUrl);
			get = new GetMethod(getUrl);
			
			get.setRequestHeader("Content-type", "text/html; charset=UTF-8");
			int re = client.executeMethod(get);
			logger.info("Return Code:{}",re);
			rtn = get.getResponseBodyAsString();
			logger.debug("response:{}",rtn);
		}catch(Exception e){
			logger.error("Exception ",e);
		}
		
		return rtn;
	}
	
/**	
	public static void main(String[] args) throws Exception{
		ReceiptMail rm = new ReceiptMail("http://localhost:8080/pay/issue/CardIssueForm.jsp");
//		String rtn = rm.getResource("tomatops1m01011607141829141389", "01");
		String rtn = rm.getResource("wizzpay01m01011708012055324074", "01");
		System.out.println("rtn ["+rtn+"]");
		
		System.out.println("**** mail send start ****");
		service.Mail sup = new service.Mail();
		kr.co.infinisoft.pg.common.mail.MailMessage msg = new kr.co.infinisoft.pg.common.mail.MailMessage();
		msg.setToAddr("hans@infinisoft.co.kr");
		//msg.setFromAddr("pg@tomatopay.net");
		msg.setSubject("[토마토페이] 신용카드 결제 내역 확인");
		msg.setContent(rtn);
		sup.sendAuth(msg);
		System.out.println("**** mail send end ****");
	}
**/	
	
} // end class

