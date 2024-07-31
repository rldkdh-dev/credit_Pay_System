package mobile;
import java.io.*;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/**
 * XML Utility
 * 
 * @author ThiBD
 */
public class XMLUtil
{
	static Logger log = Logger.getLogger("LOG_ROOT");

    public static String doc2String(Document doc)
    {
        DOMSource domSource = new DOMSource(doc);
        StringWriter writer = new StringWriter();
        StreamResult result = new StreamResult(writer);
        TransformerFactory tf = TransformerFactory.newInstance();
        
        try {
            Transformer transformer = tf.newTransformer();
            transformer.transform(domSource, result);
        } catch(Exception ex) {
            log.info("Could not transform doc to String");
            log.info(ex.toString(), ex);
            ex.printStackTrace();        	
        }
        return writer.toString();
    }

    public static Document string2Doc(String xmlString)
    {
        DocumentBuilder parser = null;
        Document doc = null;
        try
        {
            StringReader adapteeReader = new StringReader(xmlString);
            InputSource input = new InputSource(adapteeReader);
            DocumentBuilderFactory dfactory = DocumentBuilderFactory.newInstance();
            dfactory.setNamespaceAware(true);
            parser = dfactory.newDocumentBuilder();
            doc = parser.parse(input);
        } catch(Exception ex) {
            log.info("Could not parse String to XML document");
            log.info(ex.toString(), ex);
            ex.printStackTrace();
        }
        return doc;
    }

    public static Document file2Doc(String fileName)
    {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        DocumentBuilder db = null;
        Document document = null;
        try {
            db = dbf.newDocumentBuilder();
            document = db.parse(fileName);
        } catch(Exception ex) {
            log.info("Could not parse String to XML document");
            log.info(ex.toString(), ex);
            ex.printStackTrace();
        }
        
        return document;
    }

    public static void doc2File(Document doc, String fileName)
        throws Exception
    {
        File encryptionFile = new File(fileName);
        FileOutputStream outStream = new FileOutputStream(encryptionFile);
        TransformerFactory factory = TransformerFactory.newInstance();
        Transformer transformer = factory.newTransformer();
        transformer.setOutputProperty("omit-xml-declaration", "no");
        transformer.setOutputProperty("indent", "yes");
        DOMSource source = new DOMSource(doc);
        StreamResult result = new StreamResult(outStream);
        transformer.transform(source, result);
        outStream.close();
    }
    
	public static String getElementData(Element node, String strNodeName)
	{
		NodeList nodeList = null;
		Element element = null;
		try
		{
			// <strNodeName> 해당 노드를 찾음
			nodeList = node.getElementsByTagName(strNodeName);
			if( nodeList.getLength() != 1 )
				return null;
			   
			// 해당 노드를 가져옴
			element = (Element)nodeList.item(0);
			   
			// 해당 노드의 값을 리턴
			return element.getTextContent();
		} catch(Exception ex) {
            log.info("Could not get element data, node name: " + strNodeName);
            log.info(ex.toString(), ex);
            ex.printStackTrace();
			return null;
		}
	}    
	
	public static Element getXMLElement(Document doc, String strElementName) {
		NodeList nodeList = null;
		Element element = null;
		try {
			// <strNodeName> 해당 노드를 찾음
			nodeList = doc.getElementsByTagName(strElementName);
			if( nodeList.getLength() != 1 )
				return null;
			   
			// 해당 노드를 가져옴
			element = (Element)nodeList.item(0);
			   
			// 해당 노드의 값을 리턴
			return element;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
	}	
	
	  public static String getNodeValByXMLdoc(Document doc, String eleTagName) {
	        if (doc == null) {
	            return null;
	        }

	        String eleVal = null;

	        NodeList list = doc.getElementsByTagName("*");

	        for (int i = 0; i < list.getLength(); i++) {
	            // Get element
	            Element element = (Element) list.item(i);

	            if (element.getNodeName().equals(eleTagName)) {
	                NodeList fstNode = element.getChildNodes();

	                if (fstNode.item(0)==null)
	                	eleVal =null;
	                else 
	                	eleVal = (fstNode.item(0)).getNodeValue();
	            }
	        }

	        return eleVal;
	    }
	  
	  /*@method; getNodeValueListByXMLdoc
	   * @purpose: get list value of nodes what have name is eleTagName
	   * 
	   * */
	  
		public static  String[] getNodeValueListByXMLdoc(Document doc, String eleTagName) {
	        if (doc == null) {
	            return null;
	        }

	        String[] eleVal = null;
	        Element e = doc.getDocumentElement();

	        NodeList list = doc.getElementsByTagName("*");

	        for (int i = 0; i < list.getLength(); i++) {
	            // Get element
	            Element element = (Element) list.item(i);

	            if (element.getNodeName().equals(eleTagName)) {
	                NodeList fstNode = element.getChildNodes();

	                if (fstNode.item(0)==null)
	                	eleVal =null;
	                else{ 
	                	String newNote = (fstNode.item(0)).getNodeValue();	                
	                	eleVal = addString2Array(eleVal, newNote);
	                }
	            }
	        }

	        return eleVal;
	    }
		
		private static String[] addString2Array(String[] orgStr, String newStr){
			if(orgStr==null){
				if(newStr==null) return null;
				
				String[] resultStr = new String[1];
				resultStr[0] = newStr;
				return resultStr;
			}
			
			if(newStr==null) return orgStr;
			
			int iLengOrg = orgStr.length;
			
			String[] resultStr = new String[iLengOrg+1];
			for(int i=0; i< iLengOrg; i++)
				resultStr[i] = orgStr[i];
			
			resultStr[iLengOrg] = newStr;
			
			return resultStr;
			
		}
		
}
