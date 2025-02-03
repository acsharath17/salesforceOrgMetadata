public class ToolingApiHelper {

    public static List<Map<String, String>> getRecentApexClassBodies() {
        List<Map<String, String>> apexClasses = new List<Map<String, String>>();

        // Get the session ID and instance URL
        String sessionId = UserInfo.getSessionId();
        String instanceUrl = string.valueOf(Url.getOrgDomainURL());

        // Tooling API endpoint for querying ApexClass metadata including Body (source code)
        String toolingApiEndpoint = instanceUrl + '/services/data/v57.0/tooling/query/?q=' +
            'SELECT+Id,+Name,+LastModifiedDate,+Body+FROM+ApexClass+ORDER+BY+LastModifiedDate+DESC+LIMIT+10';

        // Create HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(toolingApiEndpoint);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + sessionId);
        req.setHeader('Content-Type', 'application/json');

        Http http = new Http();
        HttpResponse res;
        
        try {
            res = http.send(req);
            if (res.getStatusCode() == 200) {
                String responseBody = res.getBody();
                
                // Parse JSON response
                Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
                List<Object> records = (List<Object>) jsonResponse.get('records');

                // Collect class data (Id, Name, Body)
                for (Object record : records) {
                    Map<String, Object> apexClass = (Map<String, Object>) record;
                    Map<String, String> classDetails = new Map<String, String>();
                    classDetails.put('Id', (String) apexClass.get('Id'));
                    classDetails.put('Name', (String) apexClass.get('Name'));
                    classDetails.put('Body', (String) apexClass.get('Body')); // Source code of the Apex class
                    apexClasses.add(classDetails);
                }
            } else {
                System.debug('Error: ' + res.getStatusCode() + ' ' + res.getStatus());
            }
        } catch (Exception e) {
            System.debug('Exception in Tooling API callout: ' + e.getMessage());
        }

        return apexClasses;
    }
}