public class xml_request_to_adaptive_v2 {
	public String xmlRes(){
        Xmlstreamwriter xmlW = new Xmlstreamwriter();
        xmlW.writeStartDocument('utf-8','1.0');
        
        xmlW.writeStartElement(null,'Call', null);
        xmlW.writeAttribute(null,null,'Method','exportData');
        xmlW.writeAttribute(null,null,'callerName','Salesforce');
        
        xmlW.writeStartElement(null,'credentials', null);
        xmlW.writeAttribute(null,null,'login','implementer@opensocietyfoundations2.org');
        xmlW.writeAttribute(null,null,'password','test123');
        
        xmlW.writeStartElement(null,'version', null);
        xmlW.writeAttribute(null,null,'name','2015 January');
        xmlW.writeAttribute(null,null,'isDefault','false');
        
        xmlW.writeStartElement(null,'format', null);
        xmlW.writeAttribute(null,null,'useInternalCodes','true');
        xmlW.writeAttribute(null,null,'includeUnmappedItems','false');
        
        xmlW.writeStartElement(null,'filters', null);
        	
        	xmlW.writeStartElement(null,'Sheets', null);
        	xmlW.writeEndDocument();
        	xmlW.writeStartElement(null,'levels', null);
        	xmlW.writeEndDocument();
        	/*xmlW.writeStartElement(null,'timeSpan', null);
        	xmlW.writeAttribute(null,null,'start','Jan-2015');
        	xmlW.writeAttribute(null,null,'end','Jan-2015');
        	
        	
        	xmlW.writeStartElement(null,'Sheet', null);
        	xmlW.writeAttribute(null,null,'name','Budget Template');
        	xmlW.writeEndDocument();       
        	xmlW.writeEndDocument();*/
        
        		
        
        	/*xmlW.writeStartElement(null,'levels', null);
        	xmlW.writeStartElement(null,'level', null);
        	xmlW.writeAttribute(null,null,'name','Africa Regional Office : Advocacy &amp; Research (46776)');
        	xmlW.writeAttribute(null,null,'isRollup','true');
        	xmlW.writeEndDocument();
        	xmlW.writeEndDocument();
        
        	xmlW.writeStartElement(null,'timeSpan', null);
        	xmlW.writeAttribute(null,null,'start','Jan-2015');
        	xmlW.writeAttribute(null,null,'end','Jan-2015');
        	xmlW.writeEndDocument();*/
        
        xmlW.writeEndDocument(); // ending filter
        
        xmlW.writeEndDocument(); // ending format
        
        xmlW.writeEndDocument(); //ending version
        
        xmlW.writeEndDocument();// ending credentials
        
        xmlW.writeEndDocument(); //ending call
        
        xmlW.writeEndDocument();
        
        String xmlStringxmlRes = xmlW.getXmlString();
        System.debug('The XML :'+xmlW.getXmlString());     
        xmlW.close();
        
        System.HttpRequest request = new System.HttpRequest();
        request.setEndpoint('https://api.adaptiveinsights.com/api/v11');
        request.setHeader('Content-Type', 'application/xml');
        
        request.setMethod('GET');
        request.setBody(xmlStringxmlRes);
        
        System.HttpResponse response = new System.Http().send(request);
        string Response1 = response.getBody();
        Dom.Document doc = response.getBodyDocument();
        
        system.debug('AAAAAAAAAAAAAA'+response);
        system.debug('AAAAAAAAAAAAAA'+doc);
        system.debug('AAAAAAAAAAAAAA'+Response1);
        
        return null;
    }
}