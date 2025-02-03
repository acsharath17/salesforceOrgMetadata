public with sharing class PineconeUploader {
    @AuraEnabled
    public static void uploadEmbeddings(List<Map<String, Object>> embeddings) {
        String pineconeApiKey = '9e1f0dfd-6c79-489d-94d2-d2336a6a4f99'; // Securely store and retrieve this key
        String pineconeEnvironment = 'YOUR_PINECONE_ENVIRONMENT';
        String indexName = 'YOUR_INDEX_NAME';

        Http http = new Http();

        HttpRequest req = new HttpRequest();
        //req.setEndpoint('https://' + indexName + '-' + pineconeEnvironment + '.pinecone.io/vectors/upsert');
        req.setEndpoint('https://sforgmetadata-lll4zxo.svc.aped-4627-b74a.pinecone.io/vectors/upsert');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Api-Key', pineconeApiKey);

        List<Map<String, Object>> vectors = new List<Map<String, Object>>();

        for (Integer i = 0; i < embeddings.size(); i++) {
            Map<String, Object> embeddingData = embeddings[i];
            String embeddingId = String.valueOf(i);
            List<Object> embedding = (List<Object>) embeddingData.get('embedding');

            Map<String, Object> vector = new Map<String, Object>();
            vector.put('id', embeddingId);
            vector.put('values', embedding);

            Map<String, Object> metadata = new Map<String, Object>();
            metadata.put('text', embeddingData.get('text')); // Include original text if needed

            vector.put('metadata', metadata);

            vectors.add(vector);
        }

        Map<String, Object> payload = new Map<String, Object>();
        payload.put('vectors', vectors);

        String jsonPayload = JSON.serialize(payload);
        req.setBody(jsonPayload);

        HTTPResponse res = http.send(req);

        if (res.getStatusCode() != 200) {
            throw new CalloutException('Failed to upload embeddings to Pinecone. Status code: ' + res.getStatusCode() + ', Body: ' + res.getBody());
        }
    }
}