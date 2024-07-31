package mobile;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
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


import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * SMTP 메일전송
 * 
 * @id      : $Id: MailSMTP.java 739 2011-10-19 08:41:15Z cretty $
 * @version : $Revision: 739 $
 * @author  : $Author: cretty $
 */
public class MailSMTP
{
	/** logger */
	private static final Logger logger = LoggerFactory.getLogger(MailSMTP.class);

	/** Host */
	private String host = null;
	/** Port */
	private String port = null;
	
	/** SMTP ID */
	private String smtpId = null;
	/** SMTP PW */
	private String smtpPw = null;
	
	/** props */
    private Properties props = null; 
	/** Auth */
    private Authenticator auth = null;
    
	/**
	 * Constructor
	 * @param config
	 */
	public MailSMTP(){
		host = "127.0.0.1";
		port = "25";
		
		props = new Properties(); 
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.from", "pg@innopay.co.kr");
		props.put("mail.transport.protocol","smtp");
		props.put("mail.smtp.connectiontimeout", "5000");
		props.put("mail.smtp.timeout", "3000");
		
		props.put("mail.mime.encodeeol.strict", "true");
		
		if(StringUtils.isNotEmpty(smtpId) && StringUtils.isNotEmpty(smtpPw) ){
			logger.info("SMTP id/pw :{}/{}",smtpId,smtpPw);
			props.put("mail.smtp.auth","true");
			auth = new UserAuthentication(smtpId, smtpPw);
		}

	}
	
	/**
	 * send
	 * @param mailMessage
	 * @throws Exception
	 */
	public void send(MailMessage mailMessage) throws Exception {
		logger.debug("send");
        Session session = Session.getDefaultInstance(props,auth);
        session.setDebug(true);
        MimeMessage message = new MimeMessage(session);
        
        Transport transport = null;
        try {
        	putMimeMessage(message,mailMessage);
        	
	        transport = session.getTransport("smtp");
	        transport.connect();
	        if( !transport.isConnected() ) {
	        	throw new Exception("MailSend sendEmail - FAILED TO CONNECT to SMTP SERVER ");
	        }
	        transport.sendMessage(message,message.getAllRecipients());
	        logger.debug("send ok");
        }catch(Exception ex){
        	throw ex;
        }finally{
        	if(transport != null) try{ transport.close(); }catch(Exception exx){}
        }
	}
	
	/**
	 * send
	 * @param list
	 * @throws Exception
	 */
	public void send(List<MailMessage> list) throws Exception {
		logger.debug("send");
        Session session = Session.getDefaultInstance(props,auth);
        //session.setDebug(true);
        
        Transport transport = null;
        try {
        	ArrayList<MimeMessage> mmList = new ArrayList<MimeMessage>();
            MimeMessage message = null;
        	MailMessage mailMessage = null;
            for(int i=0;i<list.size();i++){
            	mailMessage = list.get(i);
            	message = new MimeMessage(session);    	
            	message.setSentDate(new java.util.Date());
            	putMimeMessage(message,mailMessage);
            	mmList.add(message);
            }
        	
	        transport = session.getTransport("smtp");
	        transport.connect();
	        if( !transport.isConnected() ) {
	        	throw new Exception("MailSend sendEmail - FAILED TO CONNECT to SMTP SERVER " );
	        }
	        for(int i=0;i<mmList.size();i++){
	            message = mmList.get(i);
	            transport.sendMessage(message,message.getAllRecipients());
	        }
	        logger.debug("send ok");
        }catch(Exception ex){
        	throw ex;
        }finally{
        	if(transport != null) try{ transport.close(); }catch(Exception exx){}
        }
	}
		
	public static void putMimeMessage(MimeMessage mimeMessage,MailMessage mailMessage) throws MessagingException,UnsupportedEncodingException {
		mimeMessage.setFrom(new InternetAddress("pg@innopay.co.kr",MimeUtility.encodeText("INNOPAY","UTF-8","B")));
		mimeMessage.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(mailMessage.getToAddr(),mailMessage.getToName(),"UTF-8")); 
		mimeMessage.setSubject(MimeUtility.encodeText(mailMessage.getSubject(),"UTF-8","B"));
		mimeMessage.setContent(StringUtils.defaultString(mailMessage.getContent()), "text/html;charset=UTF-8");
	}
	
	public static class UserAuthentication extends Authenticator {
		 PasswordAuthentication pa;
		 public UserAuthentication(String id, String password){ pa = new PasswordAuthentication(id, password); }
		 public PasswordAuthentication getPasswordAuthentication(){ return pa; }
	}
	
	public static void main(String [] args) throws Exception {
		logger.debug("start");
		
		Properties prop = new Properties();
		prop.put("smtp.host","127.0.0.1");
		prop.put("smtp.port","25");
		
		MailSMTP msb = new MailSMTP();
		
		MailMessage msg = new MailMessage();
		msg.setToAddr("test@test.com");
		msg.setToName("test");
		msg.setSubject("테스트");
		msg.setContent("테스트 데이터");
		msb.send(msg);
		
		ArrayList<MailMessage> list = new ArrayList<MailMessage>();
		list.add(msg);
		msb.send(list);
		logger.debug("done");
	}
}