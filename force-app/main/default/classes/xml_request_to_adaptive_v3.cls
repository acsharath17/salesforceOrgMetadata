public class xml_request_to_adaptive_v3 {
    public void ab(){
        string xml_string = '<?xml version="1.0" encoding="utf-8"?>';
        xml_string += '<Call Method="exportData" callerName="Salesforce">';
        xml_string += '<credentials login="implementer@opensocietyfoundations2.org" password="test123">';
        xml_string += '<version name="2015 January" isDefault="false">';
        xml_string += '<format useInternalCodes="true" includeUnmappedItems="false">';
        xml_string += '<filters>';
        
        xml_string += '<Sheets><Sheet name="Budget Template"></Sheet></Sheets>';
        xml_string += '<levels><level name="Africa Regional Office : Advocacy &amp; Research (46776)" isRollup="true" includeDescendants="true"/></levels>';
        xml_string += '<timeSpan start="Jan-2015" end="Jan-2015"/>';
                    
        xml_string += '</filters>';
    
        xml_string += '<dimensions><dimension name= "Budget Type"/></dimensions>';
        
        xml_string += '</format>';
        xml_string += '</version>';
        xml_string += '</credentials>';
        xml_string += '</Call>';
        XmlStreamReader xsr = new XmlStreamReader(xml_String);
        system.debug(xsr);
        system.debug(xml_String);
        
        System.HttpRequest request = new System.HttpRequest();
        request.setEndpoint('https://api.adaptiveinsights.com/api/v11');
        request.setHeader('Content-Type', 'text/xml');
        
        request.setMethod('GET');
        request.setBody(xml_String);
        
        System.HttpResponse response = new System.Http().send(request);
        string Response1 = response.getBody();
        Dom.Document doc = response.getBodyDocument();
        
    }
}