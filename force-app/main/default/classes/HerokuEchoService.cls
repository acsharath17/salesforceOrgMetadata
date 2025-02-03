public with sharing class HerokuEchoService {
    @future(callout=true)
    public static void callEchoService(String messageToEcho) {
        try {
            // 1. Prepare the HTTP request
            HttpRequest req = new HttpRequest();
            // The endpoint must match the "Remote Site URL" domain + path
            // If your Remote Site URL is https://your-echo-app-name.herokuapp.com
            // then you can do:
            req.setEndpoint('https://project-one-9de2573d0880.herokuapp.com/echo');
            
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            
            // 2. Build the JSON body
            String requestBody = JSON.serialize(new Map<String, String>{
                'message' => messageToEcho
            });
            req.setBody(requestBody);

            // 3. Send the request
            Http http = new Http();
            HttpResponse res = http.send(req);

            // 4. Log the response
            System.debug('STATUS: ' + res.getStatusCode());
            System.debug('BODY: ' + res.getBody());

            // You could parse the JSON if you want:
            // Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            // String echoedMessage = (String)responseMap.get('echoedMessage');
            // System.debug('Echoed back: ' + echoedMessage);

        } catch(Exception e) {
            System.debug('Error during callout: ' + e.getMessage());
        }
    }
}