package mobile;

import java.util.List;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ibatis.sqlmap.client.SqlMapClient;

/**
 * <pre>
 * </pre>
 * 
 * @id      : $Id: MailSendBean.java 516 2011-09-30 08:52:41Z cretty $
 * @version : $Revision: 516 $
 * @author  : $Author: cretty $
 */
public class MailSendBean
{
	/** logger */
	private static final Logger logger = LoggerFactory.getLogger(MailSendBean.class);
	
	/** MailSMTP */
	private MailSMTP smtp = null;
	
	/**
	 * Constructor
	 * @param config
	 */
	public MailSendBean(){
		smtp = new MailSMTP();
	}
	
	/**
	 * doSendMail
	 */
	public synchronized void doSendMail(MailMessage mailMessage){
		logger.debug("doSendMail");
		try {
			smtp.send(mailMessage);
		}catch(Exception ex){
			logger.error("Send Mail Error",ex);
		}
	}
	
	/**
	 * doSendMail
	 */
	public synchronized void doSendMail(List<MailMessage> list){
		logger.debug("doSendMail");
		try {
			smtp.send(list);
		}catch(Exception ex){
			logger.error("Send Mail Error",ex);
		}
	}

}