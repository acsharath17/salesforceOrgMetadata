public class DomNamespaceSample
{
    public void sendRequest(String endpoint)
    {
        // Create the request envelope
        DOM.Document doc = new DOM.Document();
        
        String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
        String xsi = 'http://www.w3.org/2001/XMLSchema-instance';
        String serviceNS = 'http://www.myservice.com/services/MyService/';
        
        dom.XmlNode envelope
            = doc.createRootElement('Envelope', soapNS, 'soapenv');
        envelope.setNamespace('xsi', xsi);
        envelope.setAttributeNS('schemaLocation', soapNS, xsi, null);
        
        dom.XmlNode body
            = envelope.addChildElement('Body', soapNS, null);
        
        body.addChildElement('echo', serviceNS, 'req').
           addChildElement('category', serviceNS, null).
           addTextNode('classifieds');
        
        System.debug('AAAAAAAAAAAAAAAAA'+doc.toXmlString());
        
        // Send the request
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(endpoint);
        req.setHeader('Content-Type', 'text/xml');
        
        req.setBodyDocument(doc);
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        System.assertEquals(200, res.getStatusCode());
        
        dom.Document resDoc = res.getBodyDocument();
        
        envelope = resDoc.getRootElement();
        
        String wsa = 'http://schemas.xmlsoap.org/ws/2004/08/addressing';
        
        dom.XmlNode header = envelope.getChildElement('Header', soapNS);
        System.assert(header != null);
        
        String messageId
            = header.getChildElement('MessageID', wsa).getText();
        
        System.debug(messageId);
        System.debug(resDoc.toXmlString());
        System.debug(resDoc);
        System.debug(header);
        
        System.assertEquals(
         'http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous',
         header.getChildElement(
           'ReplyTo', wsa).getChildElement('Address', wsa).getText());
        
        
        System.assertEquals(
          envelope.getChildElement('Body', soapNS).
              getChildElement('echo', serviceNS).
              getChildElement('something', 'http://something.else').
              getChildElement(
                'whatever', serviceNS).getAttribute('bb', null),
                'cc');
        
        System.assertEquals('classifieds',
          envelope.getChildElement('Body', soapNS).
              getChildElement('echo', serviceNS).
              getChildElement('category', serviceNS).getText());
    }
}