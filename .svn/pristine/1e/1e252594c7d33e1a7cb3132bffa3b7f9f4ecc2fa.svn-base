<%@ page contentType="text/html; charset=euc-kr"%>
<%!
   String TeleditBinPath = "/home/jboss/TeleditClient_M64_Thread";


	
	public Map Parsor( String output , String delimiter){
		Map retval = null;

		String[] step1 = null;
		String[] step2 = null;

		int stepc;

		retval = new HashMap();

		step1 = output.split(delimiter);
		for(stepc = 0; stepc < step1.length; stepc++){
			step2 = step1[stepc].split("=");
			
			if(step2.length < 2) continue;
			
			retval.put(step2[0].trim(), step2[1].trim());
		}

		return retval;
	}


	public String MakeFormInput(Map map , String[] arr) {
		StringBuffer ret = new StringBuffer();

		if(arr != null){
			for(int i = 0; i < arr.length; i++)
				if(map.containsKey(arr[i]))
					map.remove(arr[i]);
		}

		Iterator i = map.keySet().iterator();
		while(i.hasNext()){
			String key = (String)i.next();
			String value = (String)map.get(key);
			
			ret.append("<INPUT TYPE=\"HIDDEN\" NAME=\"");
			ret.append(key);
			ret.append("\" VALUE=\"");
			ret.append(value);
			ret.append("\">");
			ret.append('\n');
		}

		return ret.toString();
	}

	
	public String MakeFormInputHTTP(Map HTTPVAR , String arr) {
		StringBuffer ret = new StringBuffer();
		String key = "";
		String[] value = null;

		Iterator i = HTTPVAR.keySet().iterator();
		while(i.hasNext()){
			key = (String)i.next();
			if(key.equals(arr)) continue;

			value = (String[])HTTPVAR.get(key);
			
			for(int j = 0; j < value.length; j++){
				ret.append("<INPUT TYPE=\"HIDDEN\" NAME=\"");
				ret.append(key);
				ret.append("\" VALUE=\"");
				if(key.equals("ItemName")) ret.append(toEuckr(value[j]));
				else ret.append(value[j]);
				ret.append("\">");
				ret.append('\n');
			}
		}

		return ret.toString();
	}

	
	public void MakeAddtionalInput( Map Trans, Map HTTPVAR, String[] Names ){
		for(int i = 0; i < Names.length; i++){
			if(HTTPVAR.containsKey(Names[i])){
				String[] a = (String[])HTTPVAR.get(Names[i]);
				Trans.put(Names[i], a[0]);
			}
		}
	}

	
	public void MakeItemInfo( Map TransR , String ItemAmt , String ItemCode , String ItemName) {
		TransR.put("ItemType", "Amount");
		TransR.put("ItemCount", "1");

		StringBuffer ItemInfo = new StringBuffer();
		ItemInfo.append(ItemCode.substring(0, 1));
		ItemInfo.append("|");
		ItemInfo.append(ItemAmt);
		ItemInfo.append("|1|");
		ItemInfo.append(ItemCode);
		ItemInfo.append("|");
		ItemInfo.append(ItemName);

		TransR.put("ItemInfo", ItemInfo.toString());
	}

	
	public String MakeParam( Map Trans ) {
		Iterator i = Trans.keySet().iterator();
		StringBuffer tmpRet = new StringBuffer();
		
		while(i.hasNext()){
			String key = (String)i.next();
			String value = (String)Trans.get(key);

			tmpRet.append(key);
			tmpRet.append("=");
			tmpRet.append(value);
			tmpRet.append(";");
		}

		return tmpRet.toString();
	}

	
	public Map CallTeledit(String bin, Map Trans) {
		Process p = null;
		InputStream is = null;
		String output = "";
		int buf;

		String arg = MakeParam(Trans);
		String[] ExecCmd = new String[] { TeleditBinPath + "/" + bin , arg };

		try{
			p = Runtime.getRuntime().exec( ExecCmd );
			is = p.getInputStream();

			while( (buf = is.read() ) != -1)
				output += (char)buf;

			is.close();
		}catch(Exception e){
			return null;
		}

		return Parsor(output, "\n");
	}

	
	public String toEuckr(String str){
		if(str == null) return "";
		try{
			return new String(str.getBytes("8859_1"),"euc-kr");
		}catch(IOException e){ return ""; }
	}
	
	
	public String AddInfo(String TelNum, String Iden) {
		StringBuffer Info = new StringBuffer();
		boolean AH = true;

		String[] Tok = new String[]{"TEL","IDEN"};
		for(int i = 0; i < Tok.length; i++){
			String Name = Tok[i].toUpperCase();

			if(Name.equals("")) continue;
			
			if(Name.equals("TEL")){
				if(AH) Info.append("|TelNum=");
				else Info.append("|");

				Info.append(TelNum);
			}else if(Name.equals("IDEN")){
				if(AH) Info.append("|Iden=");
				else Info.append("|");
					
				Info.append(Iden);
			}else{
				Info.append("|");
			}
		}

		return Info.toString();
	}
%>
