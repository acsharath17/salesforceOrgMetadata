public with sharing class packageGeneratorController {
    public packageGeneratorController() {

    }

    @AuraEnabled(cacheable=true)
    public static string getMetadata(){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:xmlGenerator/query/?q=Select+id,FullName+from+ValidationRule'); 
        req.setTimeout(6000);
        req.setMethod('GET');
        //req.setHeader('Content-Type', 'application/json');
        HttpResponse res = h.send(req);  
        string body = res.getBody();
        system.debug(body);
        return body;
    }
}