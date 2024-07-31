<%@ page import="kr.co.danal.jsinbi.*"%>
<%@ page import="java.net.*, java.util.*, java.text.*, java.io.*, javax.crypto.*, javax.crypto.spec.*, java.security.*, org.apache.commons.codec.binary.Base64 "%>
<%!
	/*****************************************************
	 * �ٳ� �ſ�ī�� ����
	 *****************************************************/

	/*****************************************************
	 * ������ �ʿ��� Function �� ������ ����
	 *
	 * ������ ���� ���ǻ��� �����ø� ������������� ���� �ֽʽÿ�.
	 * DANAL Commerce Division Technique supporting Team 
	 * EMail : tech@danal.co.kr	 
	 ******************************************************/

	/******************************************************
	 *  DN_CREDIT_URL	: ���� ���� ����
	 ******************************************************/
	static final String DN_CREDIT_URL = "https://tx-creditcard.danalpay.com/credit/";

	/******************************************************
	 *  Set Timeout
	 ******************************************************/
	static final int DN_CONNECT_TIMEOUT = 5000;
	static final int DN_TIMEOUT = 30000; //SO_TIMEOUT setting.

	static final String ERC_NETWORK_ERROR = "-1";
	static final String ERM_NETWORK = "Network Error";

	/******************************************************
	 *  CPID, CRYPTOKEY 		: �ٳ����� ������ �帰 CPID, ��/��ȣȭ pwd
	 ******************************************************/
	public String CPID = "A010035072"; // �Ǽ��񽺸� ���ؼ��� �ݵ�� ��ü�ʿ�.
	private String CRYPTOKEY = "9eea73123a3e5a37b8fcfda4985f708b7bcad3747dc4264434f01e2fb3f76ec2";// ��ȣȭKey. �Ǽ��񽺸� ���ؼ��� �ݵ�� ��ü�ʿ�.
	private String IVKEY = "d7d02c92cb930b661f107cb92690fc83"; // IV ������.

	public String TEST_AMOUNT = "301";

	public Map CallCredit(Map REQ_DATA, boolean Debug) {

		String REQ_STR = toEncrypt(data2str(REQ_DATA));
		REQ_STR = "CPID=" + CPID + "&DATA=" + REQ_STR;

		HttpClient hc = new HttpClient();
		hc.setConnectionTimeout(DN_CONNECT_TIMEOUT);
		hc.setTimeout(DN_TIMEOUT);

		int Result = hc.retrieve("POST", DN_CREDIT_URL, REQ_STR, "euc-kr", "euc-kr");

		String RES_STR = "";
		if (Result == HttpClient.EOK && hc.getResponseCode() == 200) {
			RES_STR = hc.getResponseBody();
		} else {
			RES_STR = "RETURNCODE=" + ERC_NETWORK_ERROR + "&RETURNMSG="
					+ ERM_NETWORK + "( " + Result + "/" + hc.getResponseCode()
					+ " )";
		}

		if (Debug) {
			System.out.println("Req[" + REQ_STR + "]");
			System.out.println("Ret[" + Result + "/" + hc.getResponseCode()	+ "]");
			System.out.println("Res[" + RES_STR + "]");
		}

		Map resMap = str2data(RES_STR);
		RES_STR = (String) resMap.get("DATA");

		if (RES_STR != null && !"".equals(RES_STR)) { //��ȣȭ�� �������䰪
			RES_STR = toDecrypt((String) resMap.get("DATA"));
			return str2data(RES_STR);
		} else {
			return resMap;
		}
	}

	public Map str2data(String str) {
		Map map = new HashMap();
		String[] st = str.split("&");

		for (int i = 0; i < st.length; i++) {
			int index = st[i].indexOf('=');
			if (index > 0)
				map.put(st[i].substring(0, index), urlDecode(st[i].substring(index + 1)));
		}

		return map;
	}

	public String data2str(Map data) {
		Iterator i = data.keySet().iterator();
		StringBuffer sb = new StringBuffer();
		while (i.hasNext()) {
			Object key = i.next();
			Object value = data.get(key);

			sb.append(key.toString());
			sb.append('=');
			sb.append(urlEncode(value.toString()));
			sb.append('&');
		}

		if (sb.length() > 0) {
			return sb.substring(0, sb.length() - 1);
		} else {
			return "";
		}
	}

	public Map getReqMap(HttpServletRequest req) {
		Map reqMap = req.getParameterMap();
		Map retMap = new HashMap();

		Set entSet = reqMap.entrySet();
		Iterator it = entSet.iterator();
		while (it.hasNext()) {
			Map.Entry et = (Map.Entry) it.next();
			Object v = et.getValue();
			if (v instanceof String) {
				String tt = (String) v;
				retMap.put(et.getKey(), tt);
			} else if (v instanceof String[]) {
				String[] tt = (String[]) v;
				retMap.put(et.getKey(), tt[0]);
			} else {
				retMap.put(et.getKey(), v.toString());
			}
		}
		return retMap;
	}

	/*
	 *  urlEncode
	 */
	public String urlEncode(Object obj) {
		if (obj == null)
			return null;

		try {
			return URLEncoder.encode(obj.toString(), "EUC-KR");
		} catch (Exception e) {
			return obj.toString();
		}
	}

	/*
	 *  urlDecode
	 */
	public String urlDecode(Object obj) {
		if (obj == null)
			return null;

		try {
			return URLDecoder.decode(obj.toString(), "EUC-KR");
		} catch (Exception e) {
			return obj.toString();
		}
	}

	public String toEncrypt(String originalMsg) {
		String AESMode = "AES/CBC/PKCS5Padding";
		String SecetKeyAlgorithmString = "AES";

		IvParameterSpec ivspec = new IvParameterSpec(
				hexToByteArray(IVKEY));
		SecretKey keySpec = new SecretKeySpec(hexToByteArray(CRYPTOKEY),
				SecetKeyAlgorithmString);
		try {
			Cipher cipher = Cipher.getInstance(AESMode);
			cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivspec);
			byte[] encrypted = cipher.doFinal(originalMsg.getBytes());
			return new String(Base64.encodeBase64(encrypted));
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	public String toDecrypt(String originalMsg) {
		String AESMode = "AES/CBC/PKCS5Padding";
		String SecetKeyAlgorithmString = "AES";

		IvParameterSpec ivspec = new IvParameterSpec(
				hexToByteArray(IVKEY));
		SecretKey keySpec = new SecretKeySpec(hexToByteArray(CRYPTOKEY),
				SecetKeyAlgorithmString);
		try {
			Cipher cipher = Cipher.getInstance(AESMode);
			cipher.init(Cipher.DECRYPT_MODE, keySpec, ivspec);
			byte[] decrypted = cipher.doFinal(Base64.decodeBase64(originalMsg
					.getBytes()));
			String retValue = new String(decrypted);
			return retValue;
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	private byte[] hexToByteArray(String hex) {
		if (hex == null || hex.length() == 0) {
			return null;
		}

		byte[] ba = new byte[hex.length() / 2];
		for (int i = 0; i < ba.length; i++) {
			ba[i] = (byte) Integer
					.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
		}
		return ba;
	}%>