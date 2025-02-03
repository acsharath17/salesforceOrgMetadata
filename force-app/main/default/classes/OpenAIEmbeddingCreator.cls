public with sharing class OpenAIEmbeddingCreator {
    @AuraEnabled
    public static List<Map<String, Object>> createEmbeddings(List<String> dataChunks) {
        List<Map<String, Object>> embeddings = new List<Map<String, Object>>();
        String apiKey = System.label.chatGPTAPIKey;
        
        Http http = new Http();

        for (String chunk : dataChunks) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.openai.com/v1/embeddings');
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', 'Bearer ' + apiKey);

            Map<String, Object> payload = new Map<String, Object>();
            payload.put('input', chunk);
            payload.put('model', 'text-embedding-ada-002');

            String jsonPayload = JSON.serialize(payload);
            req.setBody(jsonPayload);

            HTTPResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                List<Object> data = (List<Object>) jsonResponse.get('data');
                if (!data.isEmpty()) {
                    Map<String, Object> embeddingData = (Map<String, Object>) data[0];
                    embeddings.add(embeddingData);
                }
            } else {
                throw new CalloutException('Failed to create embeddings. Status code: ' + res.getStatusCode() + ', Body: ' + res.getBody());
            }
        }
        return embeddings;
    }
}