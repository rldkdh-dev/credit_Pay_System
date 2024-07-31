package util;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Hashtable;
import signgate.crypto.util.*;
import signgate.provider.SignGATE;
import java.security.*;


public class MallCertManager{
    public byte PRIVATE_KEY_VALUE[] = null;
    public byte SIGN_KEY_VALUE[] = null;
    public byte SIGN_CERT_VALUE[] = null;
    public byte ENC_PASSWORD_VALUE[] = null;
    public Hashtable CARD_PUBLIC_KEY_HASHS = null;
    public String cardPkPath = "";
    SignUtil su = null;
    
    @SuppressWarnings("rawtypes")
    public void init(String privateKeyPath, String signKeyPath, String signCertPath, String encPasswordPath)
            throws IOException {
        PRIVATE_KEY_VALUE = FileUtil.readBytesFromFileName(privateKeyPath);
        SIGN_KEY_VALUE = FileUtil.readBytesFromFileName(signKeyPath);
        SIGN_CERT_VALUE = FileUtil.readBytesFromFileName(signCertPath);
        ENC_PASSWORD_VALUE = FileUtil.readBytesFromFileName(encPasswordPath);
        CARD_PUBLIC_KEY_HASHS = new Hashtable();
//        System.out.println("PRIVATE_KEY_VALUE ["+new String(PRIVATE_KEY_VALUE)+"]");
//        System.out.println("SIGN_KEY_VALUE ["+new String(SIGN_KEY_VALUE)+"]");
//        System.out.println("SIGN_CERT_VALUE ["+new String(SIGN_CERT_VALUE)+"]");
//        System.out.println("ENC_PASSWORD_VALUE ["+new String(ENC_PASSWORD_VALUE)+"]");
    }
    
    public boolean isInit() {
        if(PRIVATE_KEY_VALUE!=null && SIGN_KEY_VALUE!=null && SIGN_CERT_VALUE!=null 
                && ENC_PASSWORD_VALUE!=null) {
            return true;
        }else {
            return false;
        }
    }
    
    public MallCertManager(String _cardPkPath) {
        cardPkPath = _cardPkPath;
    }
    
    @SuppressWarnings("unchecked")
    private byte[] getCardPublicKeyValue() throws Exception {
        byte keyValue[] = (byte[]) CARD_PUBLIC_KEY_HASHS.get(cardPkPath);
        if (keyValue == null) {
            keyValue = FileUtil.readBytesFromFileName(cardPkPath);
            CARD_PUBLIC_KEY_HASHS.put(cardPkPath, keyValue);
        }
        return keyValue;
    }
    
    public String[] encrypt(String orginalMsg) throws Exception {
        String signCert = CertUtil.derToPem(SIGN_CERT_VALUE);
        CipherUtil cipher = new CipherUtil();
        byte bSessionKey[] = RandomUtil.genRand(16);
        String ret[] = new String[4];
        try {
            System.out.println("bSessionKey ["+bSessionKey+"]");
            if (!cipher.encryptInitBySeed(bSessionKey))
                throw new Exception("세션키 생성 및 초기화에 실패하였습니다. [" + cipher.getErrorMsg() + "]");
            System.out.println("orginalMsg ["+orginalMsg+"]");
            byte bEncryptedOriginalMsg[] = cipher.encryptUpdate(orginalMsg.getBytes());
            if (bEncryptedOriginalMsg == null)
                throw new Exception("원문메시지 암호화에 실패하였습니다. [" + cipher.getErrorMsg() + "]");
            cipher.encryptFinal();
            System.out.println("bEncryptedOriginalMsg ["+bEncryptedOriginalMsg+"]");
            String sEncryptedOriginalMsg = Base64Util.encode(bEncryptedOriginalMsg);
            byte ServerKmCert[] = getCardPublicKeyValue();
            System.out.println("ServerKmCert ["+ServerKmCert.toString()+"]");
            System.out.println("******** 1 *******");
            cipher = new CipherUtil("RSA");
            System.out.println("cipher ["+cipher.toString()+"]");
            if (!cipher.encryptInit(ServerKmCert))
                throw new Exception("RSA 암호화 객체 초기화에 실패하였습니다. [" + cipher.getErrorMsg() + "]");
            byte bEncryptedSessionKey[] = cipher.encryptUpdate(bSessionKey);
            System.out.println("bEncryptedSessionKey ["+bEncryptedSessionKey.toString()+"]");
            if (bEncryptedSessionKey == null) {
                throw new Exception("세션키 암호화에 실패하였습니다. [" + cipher.getErrorMsg() + "]");
            } else {
               // cipher.encryptFinal();
                String sEncryptedSessionKey = Base64Util.encode(bEncryptedSessionKey);
                System.out.println("sEncryptedSessionKey ["+sEncryptedSessionKey+"]");
                String passwd = CipherUtil.decryptString(new String(ENC_PASSWORD_VALUE));
                System.out.println("passwd ["+passwd+"]");
                if(new SignGATE().isEmpty()) {
                    SignGATE.addProvider();    
                }
                System.out.println("**** SignGATE ["+new SignGATE().toString()+"]["+new SignGATE().size()+"]");
//                SignUtil su = new SignUtil();
//                su = new SignUtil();
                
//                System.out.println("SIGN_KEY_VALUE ["+new String(SIGN_KEY_VALUE)+"]");
//                su.signInit(SIGN_KEY_VALUE, passwd);
                KeyUtil keyutil = new KeyUtil(SIGN_KEY_VALUE);
                PrivateKey privatekey = keyutil.getPrivateKey(passwd);
                System.out.println("privatekey ["+privatekey.toString()+"]");
                Signature sign = Signature.getInstance("SHA1withRSA", "SignGATE");
                System.out.println("init algorithm ["+sign.getAlgorithm()+"]");
                sign.initSign(privatekey);
                System.out.println("orginalMsg bytes ["+orginalMsg.getBytes().toString()+"]");
                
//                Provider pro = new SignGATE();
//                Enumeration em = pro.keys();
//                while(em.hasMoreElements()) {
//                    String key = (String)em.nextElement();
//                    String value = pro.getProperty(key);
//                    System.out.println("["+key+"]["+value+"]");
//                }

//                su.signUpdate(orginalMsg.getBytes());
//                
//                byte bSignedValue[] = su.signFinal();
                sign.update(orginalMsg.getBytes());
                byte bSignedValue[] = sign.sign();
                
                String sSignedValue = Base64Util.encode(bSignedValue);

                ret[0] = sEncryptedSessionKey;
                ret[1] = sEncryptedOriginalMsg;
                ret[2] = signCert;
                ret[3] = sSignedValue;
                return ret;
            }
            
        }catch(Exception e) {
//            System.out.println("SignUtil error ["+su.getErrorMsg()+"]["+su.getStackTraceMsg()+"]");
            System.out.println(e.getMessage());
            e.printStackTrace();
            throw e;
        }
        
    } // end method

    public String decrypt(String k1, String k2, String k3, String k4) throws Exception {
        String sEncryptedSessionKey = k1.trim();
        String sEncryptedData = k2.trim();
        String sMallSignCert = k3.trim();
        String sSignedValue = k4.trim();
        CipherUtil cipher = new CipherUtil();
        byte encPasswd[] = ENC_PASSWORD_VALUE;
        String passwd = CipherUtil.decryptString(new String(encPasswd));
        cipher = new CipherUtil("RSA");
        byte ServerKmKey[] = PRIVATE_KEY_VALUE;
        if (!cipher.decryptInit(ServerKmKey, passwd))
            throw new Exception("비대칭키 초기화에 실패하였습니다. [" + cipher.getErrorMsg() + "]");
        byte bDecryptedSessionKey[] = cipher.decryptUpdate(Base64Util.decode(sEncryptedSessionKey));
        if (bDecryptedSessionKey == null)
            throw new Exception("암호화된 세션키 복호화에 실패하였습니다. [" + cipher.getErrorMsg() + "]");
        cipher.encryptFinal();
        cipher = new CipherUtil();
        if (!cipher.decryptInit(bDecryptedSessionKey))
            throw new Exception("대칭키  복호화 초기화 실패하였습니다. [" + cipher.getErrorMsg() + "]");
        byte bDecryptedOriginalMsg[] = cipher.decryptUpdate(Base64Util.decode(sEncryptedData));
        if (bDecryptedOriginalMsg == null)
            throw new Exception("암호화된 메시지 복호화에 실패하였습니다. [" + cipher.getErrorMsg() + "]");
        cipher.decryptFinal();
        String sDecryptedOriginalMsg = new String(bDecryptedOriginalMsg);
        byte bMallSignCert[] = CertUtil.pemToDer(sMallSignCert);
        //SignUtil su = new SignUtil();
        su = new SignUtil();
        su.verifyInit(bMallSignCert);
        su.verifyUpdate(bDecryptedOriginalMsg);
        boolean bRet = su.verifyFinal(Base64Util.decode(sSignedValue));
        if (!bRet)
            throw new Exception("전자서명 검증  실패. [" + su.getErrorMsg() + "]");
        CertUtil cu = new CertUtil(bMallSignCert);
        String AllowedPolicyOIDs[] = {"1.2.410.200004.5.2.1.4", "1.2.410.200004.5.2.1.2", "1.2.410.200004.5.2.1.1",
                "1.2.410.200004.5.1.1.5", "1.2.410.200004.5.1.1.7", "1.2.410.200005.1.1.1", "1.2.410.200005.1.1.5",
                "1.2.410.200004.5.3.1.9", "1.2.410.200004.5.3.1.2", "1.2.410.200004.5.3.1.1", "1.2.410.200004.5.4.1.1",
                "1.2.410.200004.5.4.1.2", "1.2.410.200012.1.1.1", "1.2.410.200012.1.1.3"};
        if (!cu.isValidPolicyOid(AllowedPolicyOIDs))
            throw new Exception("허용되지 않는 정책의 인증서입니다");
        else
            return sDecryptedOriginalMsg;
    }
    
    public static void main(String[] args) throws Exception{
        String defaultPath = "C:/eclipse_workspace2/InfiniPG_ipay_new/src/main/resources";
        String certPath = "C:/eclipse_workspace2/InfiniPG_ipay_new/src/main/webapp/cert/real";
        String privateKeyPath = certPath+"/rocomo/kmPri.key";
        String signKeyPath    = certPath+"/rocomo/signPri.key";
        String signCertPath   = certPath+"/rocomo/signCert.der";
        String encPasswordPath= certPath+"/rocomo/EncPasswd";
        String cardPkPath   = "C:/eclipse_workspace2/InfiniPG_ipay_new/src/main/webapp/cert/real/card/kmCert_lotte.der";  
        String originalMsg = "order_currency=410|order_cardname=LOTTECARD|IOS_RETURN_APP=|apvl_chain_no_lt=1248702232|xid=1248702232202001071716021892591589999999|order_mname=테스트가맹점|businessType=P";
        
//        MallCertManager certMgr = new MallCertManager(cardPkPath);
//        certMgr.init(privateKeyPath, signKeyPath, signCertPath, encPasswordPath);
//        System.out.println("originalMsg["+originalMsg+"]");
//        String[] encData = certMgr.encrypt(originalMsg);
//        for(int i=0;i<encData.length;i++) {
//            System.out.println(encData[i]);
//        }
        MallCertManager certMgr = new MallCertManager(cardPkPath);
        certMgr.init(privateKeyPath, signKeyPath, signCertPath, encPasswordPath);
        SignGATE.addProvider();
        KeyUtil keyutil = new KeyUtil(certMgr.SIGN_KEY_VALUE);
        String passwd = CipherUtil.decryptString(new String(certMgr.ENC_PASSWORD_VALUE));
        
        PrivateKey privatekey = keyutil.getPrivateKey(passwd);
        Signature sign = Signature.getInstance("SHA1withRSA", "SignGATE");
        System.out.println("init algorithm ["+sign.getAlgorithm()+"]");
        sign.initSign(privatekey);
        System.out.println("orginalMsg bytes ["+originalMsg.getBytes().toString()+"]");

//        su.signUpdate(orginalMsg.getBytes());
//        
//        byte bSignedValue[] = su.signFinal();
        sign.update(originalMsg.getBytes());
        byte bSignedValue[] = sign.sign();
        
        String sSignedValue = Base64Util.encode(bSignedValue);
        System.out.println("sSignedValue ["+sSignedValue+"]");
    }
    
} // end class
