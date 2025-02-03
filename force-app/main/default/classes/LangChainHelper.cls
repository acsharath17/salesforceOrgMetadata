public class LangChainHelper {

    // LangChain API Endpoint and API Key (replace with your actual endpoint and key)
    static final String LANGCHAIN_API_URL = 'https://your-langchain-endpoint/api/chunking';
    static final String LANGCHAIN_API_KEY = 'your-langchain-api-key';

    // Method to call LangChain to create data chunks from Apex class bodies
    public static void createChunksFromApexClassBodies(List<Map<String, String>> apexClasses) {
        // Prepare the request payload
        Map<String, Object> requestBody = new Map<String, Object>();
        List<String> classBodies = new List<String>();

        // Extract and combine the class bodies (source code) to send to LangChain
        for (Map<String, String> apexClass : apexClasses) {
            classBodies.add(apexClass.get('Body'));
        }
        requestBody.put('text', String.join(classBodies, ' ')); // Combine all class bodies into a single string

        String jsonBody = JSON.serialize(requestBody);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(LANGCHAIN_API_URL);
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + LANGCHAIN_API_KEY);
        req.setHeader('Content-Type', 'application/json');
        req.setBody(jsonBody);

        Http http = new Http();
        HttpResponse res;

        try {
            res = http.send(req);
            if (res.getStatusCode() == 200) {
                String responseBody = res.getBody();
                System.debug('LangChain Response: ' + responseBody);

                // Parse and handle the response as necessary
                Map<String, Object> langChainResponse = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
                List<Object> chunks = (List<Object>) langChainResponse.get('chunks');
                for (Object chunk : chunks) {
                    System.debug('Chunk: ' + chunk);
                }
            } else {
                System.debug('Error: ' + res.getStatusCode() + ' ' + res.getStatus());
            }
        } catch (Exception e) {
            System.debug('Exception in LangChain API callout: ' + e.getMessage());
        }
    }
}