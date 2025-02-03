public with sharing class ApexClassFetcher {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> fetchApexClasses() {
        String instanceUrl = string.valueOf(Url.getOrgDomainURL());
        String toolingApiEndpoint = instanceUrl + '/services/data/v57.0/tooling/query/?q=' +
            'SELECT+Id,+Name,+Body,+LastModifiedDate+FROM+ApexClass+ORDER+BY+LastModifiedDate+DESC+LIMIT+10';
        String sessionId = UserInfo.getSessionId();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(toolingApiEndpoint);
        req.setMethod('GET');
        String q = 'SELECT Id, Name, Body FROM ApexClass ORDER BY LastModifiedDate DESC LIMIT 10';
        //req.setEndpoint(req.getEndpoint() + '?q=' + EncodingUtil.urlEncode(q, 'UTF-8'));
        req.setHeader('Authorization', 'Bearer ' + sessionId);
        req.setHeader('Content-Type', 'application/json');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            List<Object> records = (List<Object>) jsonResponse.get('records');
            List<Map<String, Object>> apexClasses = new List<Map<String, Object>>();
            for (Object record : records) {
                Map<String, Object> apexClass = (Map<String, Object>) record;
                apexClasses.add(apexClass);
            }
            return apexClasses;
        } else {
            throw new CalloutException('Failed to fetch Apex Classes. Status code: ' + res.getStatusCode() + ', Body: ' + res.getBody());
        }
    }
}