public class ToolingApiExample {

    public static void callToolingApi() {
        // Get the session ID (used for authorization)
        String sessionId = UserInfo.getSessionId();

        // Get the instance URL (required for the endpoint)
        String instanceUrl = string.valueOf(Url.getOrgDomainURL());

        // Tooling API endpoint for querying the 10 most recently modified ApexClass metadata
        String toolingApiEndpoint = instanceUrl + '/services/data/v57.0/tooling/query/?q=' +
            'SELECT+Id,+Name,+Body,+LastModifiedDate+FROM+ApexClass+ORDER+BY+LastModifiedDate+DESC+LIMIT+10';

        // Create an HTTP request to the Tooling API
        HttpRequest req = new HttpRequest();
        req.setEndpoint(toolingApiEndpoint);
        req.setMethod('GET');

        // Add the session ID to the request headers for authorization
        req.setHeader('Authorization', 'Bearer ' + sessionId);
        req.setHeader('Content-Type', 'application/json');

        // Send the request using Http class
        Http http = new Http();
        HttpResponse res;
        
        try {
            res = http.send(req);

            // Check if the response is successful
            if (res.getStatusCode() == 200) {
                // Parse the response (which will be in JSON format)
                String responseBody = res.getBody();
                System.debug('Tooling API Response: ' + responseBody);
                
                // You can use JSON.deserialize to parse the response if needed
            } else {
                System.debug('Error: ' + res.getStatusCode() + ' ' + res.getStatus());
            }
        } catch (Exception e) {
            System.debug('Exception in Tooling API callout: ' + e.getMessage());
        }
    }
}