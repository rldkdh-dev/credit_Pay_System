package mobile;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Sms.java Class is Designed for providing 
 *
 * Copyright    Copyright (c) 2016
 * Company      Infinisoft Co.
 *
 * @Author      : �?�?�?
 * @File        : kr.co.infinisoft.pg.common.sms.Sms.java
 * @Version     : 1.0,
 * @See         : 
 * @Description : 
 * @Date        : 2017. 3. 6. - ?��?? 3:25:53
 * @ServiceID:
 * @VOID:
 * @Commnad:
 *
 **/


public class Sms {
	private static final Logger logger = LoggerFactory.getLogger(Sms.class);

	private String msg_type		= "1";	//	1:SMS 2: SMS URL 3:MMS 4:MMS URL
	private String dstaddr		= null;	// ???? ????�???
	private String callback		= "15443267";	// �??? ????�??? (?��??? �???�??��? ????????)
	private String stat			= "0";	// 0:???��??�? 1:?��??�? 2:?��????�? 3:결과????
	private String subject		= null;	// ??�?
	private String text			= null;	// ?��??
	
	public Sms() {	}

	public String getMsg_type() {
		return msg_type;
	}

	public void setMsg_type(String msg_type) {
		this.msg_type = msg_type;
	}

	public String getDstaddr() {
		return dstaddr;
	}

	public void setDstaddr(String dstaddr) {
		this.dstaddr = dstaddr;
	}

	public String getCallback() {
		return callback;
	}

	public void setCallback(String callback) {
		this.callback = callback;
	}

	public String getStat() {
		return stat;
	}

//	public void setStat(String stat) {
//		this.stat = stat;
//	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Override
	public String toString() {
		return "Sms [msg_type=" + msg_type + ", dstaddr=" + dstaddr
				+ ", callback=" + callback + ", stat=" + stat + ", subject="
				+ subject + ", text=" + text + "]";
	}
	
	
} // end class

