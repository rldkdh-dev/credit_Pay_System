package service;

/**
 * Mail.java Class is Designed for providing 
 *
 * Copyright    Copyright (c) 2016
 * Company      Infinisoft Co.
 *
 * @Author      : 김봉민
 * @File        : service.Mail.java
 * @Version     : 1.0,
 * @See         : 
 * @Description : 메일발송 클래스
 * @Date        : 2017. 7. 10. - 오후 1:46:31
 * @ServiceID:
 * @VOID:
 * @Commnad:
 *
 **/

import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import kr.co.infinisoft.pg.common.db.SqlMapMgrP;
import kr.co.infinisoft.pg.common.mail.MailMessage;
import kr.co.infinisoft.pg.common.mail.MailTemplateManager;
import kr.co.infinisoft.pg.document.Box;
import mobile.DataModel;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class Mail {
	private static final Logger logger = LoggerFactory.getLogger(Mail.class);
	private String uid = null;
	private String usr_id = null;
	private String id_cl = null;

	public Mail() {	}

	public Mail(String strID, String strIDCl) {
		this.usr_id = strID;
		this.id_cl = strIDCl;
	}

	public Mail(String strUID, String strID, String strIDCl) {
		this.uid = strUID;
		this.usr_id = strID;
		this.id_cl = strIDCl;
	}

	/**
	 * 현금영수증 메일 생성
	 *@param  DataModel   : 거래 정보<br>
	 *@return int         : 0 <br>
	 *@throws SQLException <br>
	 *@throws Exception <br>
	 */
	public int insCashReceiptMail(DataModel map) throws SQLException, Exception {

		SqlMapClient client = SqlMapMgrP.getSqlMap();
		try {
			client.startTransaction(); 

			// Return : Insert PK Object
			client.insert("insCashMail", map);

			client.commitTransaction ();
		} finally {
			client.endTransaction ();
		}

		return 0;
	}  

	public MailMessage sendMailPayType(String mailId,Box param) throws Exception {
		MailMessage mail = new MailMessage();
		mail.setToAddr(param.getString("ord_email"));
		mail.setToName(param.getString("ord_nm"));

		try {
			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
			SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);

			MailTemplateManager.getInstance().mergeMail(client,mailId,mail,param);
		} catch(Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Error : " + e);
		}

		return mail;
	}

	public void send(MailMessage mailMessage) throws Exception {

		String host = "127.0.0.1";
		String port = "25";

		Properties props = new Properties(); 
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.from", "pg@innopay.co.kr");
		//		props.put("mail.smtp.from", mailMessage.getFromAddr());
		props.put("mail.transport.protocol","smtp");

		Session session = Session.getDefaultInstance(props);
		session.setDebug(true);

		MimeMessage message = new MimeMessage(session);
		try {
			putMimeMessage(message,mailMessage);
			Transport.send(message);
		}catch(MessagingException ex){
			throw ex;
		}catch(UnsupportedEncodingException ex1){
			throw ex1;
		}
	}

	public void sendAuth(MailMessage mailMessage) throws Exception {

		String host = "mail.infinisoft.co.kr";
		String port = "25";
		String smtpId = "hans@infinisoft.co.kr";
		String smtpPw = "hans123456";
		boolean ssl = false;

		Properties props = new Properties(); 
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.from", "pg@innopay.co.kr");
		props.put("mail.smtp.auth","true");
		props.put("mail.transport.protocol","smtp");

		//Use SSL
		if(ssl){
			props.put("mail.smtp.starttls.enable","true");
			props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
		}
		Authenticator auth = new UserAuthentication(smtpId, smtpPw);
		Session session = Session.getDefaultInstance(props, auth);
		//session.setDebug(true);

		MimeMessage message = new MimeMessage(session);
		try {
			putMimeMessage(message,mailMessage);
			Transport.send(message);
		}catch(MessagingException ex){
			throw ex;
		}catch(UnsupportedEncodingException ex1){
			throw ex1;
		}
	}

	public void putMimeMessage(MimeMessage mimeMessage,MailMessage mailMessage) throws MessagingException,UnsupportedEncodingException {
		mimeMessage.setFrom(new InternetAddress("pg@innopay.co.kr",MimeUtility.encodeText("InnoPay","UTF-8","B")));
		mimeMessage.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(mailMessage.getToAddr(),mailMessage.getToName(),"UTF-8")); 
		mimeMessage.setSubject(MimeUtility.encodeText(mailMessage.getSubject(),"UTF-8","B"));
		mimeMessage.setContent(mailMessage.getContent(), "text/html;charset=utf-8");
	}

	public static class UserAuthentication extends Authenticator {
		PasswordAuthentication pa;
		public UserAuthentication(String id, String password){ pa = new PasswordAuthentication(id, password); }
		public PasswordAuthentication getPasswordAuthentication(){ return pa; }
	}

	/**
	 * 메일발송내역 조회
	 *@param  HashMap     : 조회 구분, 조회 값<br>
	 *@return DataModel   : 조회결과 <br>
	 *@throws SQLException <br>
	 *@throws Exception <br>
	 */
	@SuppressWarnings("rawtypes")
	public List getMailSendSearch(DataModel map) throws SQLException, Exception {
		Reader reader = null;

		Charset charset = Charset.forName("UTF-8");
		Resources.setCharset(charset);
		reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);

		return client.queryForList("getMailSendSearch", map);
	}

	/**
	 * 메일발송내역 상세 조회
	 *@param  HashMap     : 조회 구분, 조회 값<br>
	 *@return DataModel   : 조회결과 <br>
	 *@throws SQLException <br>
	 *@throws Exception <br>
	 */
	@SuppressWarnings("rawtypes")
	public List getMailSendDetailSearch(DataModel map) throws SQLException, Exception {
		Reader reader = null;

		Charset charset = Charset.forName("UTF-8");
		Resources.setCharset(charset);
		reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);

		return client.queryForList("getMailSendDetailSearch", map);
	}

	public static void main(String[] args) {
		// TODO 자동 생성된 메소드 스텁

	}
} // end class

