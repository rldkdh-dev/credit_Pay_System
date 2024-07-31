package util;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

public class NetUtil {
	private NetUtil() {}
	
	private static class NetUtilHolder {
		final static NetUtil netUtil = new NetUtil();
	}
	
	public static NetUtil getInstance() {
		return NetUtilHolder.netUtil;
	}
	
	public String getHostName() {
		try {
			return InetAddress.getLocalHost().getHostName();
		} catch (UnknownHostException e) {
			return "";
		}
	}

	public String getURL(HttpServletRequest request) {
		Enumeration<?> param = request.getParameterNames();

		StringBuffer strParam = new StringBuffer();
		StringBuffer strURL = new StringBuffer();

		if (param.hasMoreElements()) {
			strParam.append("?");
		}

		while (param.hasMoreElements()) {
			String name = (String) param.nextElement();
			String value = request.getParameter(name);

			strParam.append(name + "=" + value);

			if (param.hasMoreElements()) {
				strParam.append("&");
			}
		}

		strURL.append(request.getRequestURI());
		strURL.append(strParam);

		return strURL.toString();
	}

	/**
	 * 서버 IP 구하기
	 * @return
	 */
	public String getServerIP() {
		String ip = "";
		try {
			boolean isLoopBack = true;
			Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces();
			while(en.hasMoreElements()) {
				NetworkInterface ni = en.nextElement();
				if (ni.isLoopback()) continue;

				Enumeration<InetAddress> inetAddresses = ni.getInetAddresses();
				while(inetAddresses.hasMoreElements()) { 
					InetAddress ia = inetAddresses.nextElement();
					if (ia.getHostAddress() != null && ia.getHostAddress().indexOf(".") != -1) {
						ip = ia.getHostAddress();
						isLoopBack = false;
						break;
					}
				}
				if (!isLoopBack)
					break;
			}
		} catch (SocketException e1) {
			e1.printStackTrace();
		}
		return ip;
	}

	/**
	 * ContextPath를 포함하지 않는 WAS Serve URL을 구한다.
	 * @param request
	 * @return
	 */
	public String getServerShortURL(HttpServletRequest request) {
		String url = null;
		
		//http 포트사용시 추가
		if (request.getServerPort() == 80 || request.getServerPort() == 443) {
			url = request.getScheme() + "://" + request.getServerName() ;
	    } else {
	    	url = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort();
	    }   
		
		return url;
	}
	
	public String getClientIP(HttpServletRequest request) {
		String clientIP = request.getHeader("X-Forwarded-For");
//		request.getHeader("WL-Proxy-Client-IP");
//		request.getHeader("Proxy-Client-IP");
//		request.getHeader("X-Forwarded-For");
//		request.getHeader("REMOTE_ADDR");
		if(clientIP == null || clientIP.length() == 0 || clientIP.toLowerCase().equals("unknown")) {
			clientIP = request.getHeader("REMOTE_ADDR");
		}
		if(clientIP == null || clientIP.length() == 0 || clientIP.toLowerCase().equals("unknown")) {
			clientIP = request.getRemoteAddr();
		}
		return clientIP;
	}

}
