public class xml_request_to_adaptive {

    public String xmlRes(){
        Xmlstreamwriter xmlW = new Xmlstreamwriter();
        xmlW.writeStartDocument('utf-8','1.0');
        
        xmlW.writeStartElement(null,'Call', null);
        xmlW.writeAttribute(null,null,'Method','exportSheets');
        xmlW.writeAttribute(null,null,'callerName','Salesforce');
        
        xmlW.writeStartElement(null,'credentials', null);
        xmlW.writeAttribute(null,null,'login','implementer@opensocietyfoundations2.org');
        xmlW.writeAttribute(null,null,'password','test123');
        
        xmlW.writeEndDocument();// ending credentials
        
        xmlW.writeEndDocument(); //ending call
        
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