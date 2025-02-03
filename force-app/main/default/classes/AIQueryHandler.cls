public with sharing class AIQueryHandler {

    // Replace with your actual API keys and endpoints
    private static final String OPENAI_API_KEY = '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';
    private static final String OPENAI_EMBEDDING_ENDPOINT = 'https://api.openai.com/v1/embeddings';
    private static final String OPENAI_COMPLETION_ENDPOINT = 'https://api.openai.com/v1/chat/completions';
    
    private static final String PINECONE_API_KEY = '9e1f0dfd-6c79-489d-94d2-d2336a6a4f99';
    private static final String PINECONE_ENDPOINT = 'https://sfcustomobjects-lll4zxo.svc.aped-4627-b74a.pinecone.io/query';

    public static String processUserQuery(String userQuery) {
        // Step 1: Generate embeddings from OpenAI
        List<Double> embeddings = getEmbeddingsFromOpenAI(userQuery);

        // Step 2: Search in Pinecone using the embeddings
        List<String> pineconeResults = searchInPinecone(embeddings);

        // Step 3: Get a tailored answer from OpenAI
        String finalAnswer = getAnswerFromOpenAI(userQuery, pineconeResults);

        return finalAnswer;
    }

    @AuraEnabled(cacheable=false)
    public static List<Double> getEmbeddingsFromOpenAI(String inputText) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(OPENAI_EMBEDDING_ENDPOINT);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + OPENAI_API_KEY);
        request.setHeader('Content-Type', 'application/json');

        Map<String, Object> payload = new Map<String, Object>{
            'input' => inputText,
            'model' => 'text-embedding-ada-002'
        };

        request.setBody(JSON.serialize(payload));

        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            List<Object> data = (List<Object>)result.get('data');
            if (data.isEmpty()) {
                throw new CalloutException('No embedding data returned from OpenAI.');
            }
            Map<String, Object> embeddingData = (Map<String, Object>)data[0];
            List<Object> embedding = (List<Object>)embeddingData.get('embedding');
            // Convert List<Object> to List<Double>
            List<Double> embeddings = new List<Double>();
            for (Object value : embedding) {
                embeddings.add((Double)value);
            }
            return embeddings;
        } else {
            throw new CalloutException('OpenAI Embedding API call failed: ' + response.getBody());
        }
    }

    @AuraEnabled(cacheable=false)
    public static List<String> searchInPinecone(List<Double> embeddings) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(PINECONE_ENDPOINT);
        request.setMethod('POST');
        request.setHeader('Api-Key', PINECONE_API_KEY);
        request.setHeader('Content-Type', 'application/json');

        Map<String, Object> payload = new Map<String, Object>{
            'vector' => embeddings,
            'topK' => 50,
            'includeValues' => false,
            'includeMetadata' => true
        };

        request.setBody(JSON.serialize(payload));

        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            List<Object> matches = (List<Object>)result.get('matches');
            List<String> results = new List<String>();
            for (Object matchObj : matches) {
                Map<String, Object> match = (Map<String, Object>)matchObj;
                Map<String, Object> metadata = (Map<String, Object>)match.get('metadata');
                results.add((String)metadata.get('text'));
            }
            return results;
        } else {
            throw new CalloutException('Pinecone API call failed: ' + response.getBody());
        }
    }

    @AuraEnabled(cacheable=false)
    public static String getAnswerFromOpenAI(String userQuery, List<String> context) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(OPENAI_COMPLETION_ENDPOINT);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + OPENAI_API_KEY);
        request.setHeader('Content-Type', 'application/json');

        String combinedContext = String.join(context,'\n');
        String prompt = 'Answer the question based on the following context:\n\n' + combinedContext + '\n\nQuestion: ' + userQuery + '\nAnswer:';
        
        Map<String, Object> PromptBody = new Map<String, Object>();
        PromptBody.put('role','user');
        PromptBody.put('content',prompt);
        List<Object> lstPrompts = new List<Object>();
        lstPrompts.add(PromptBody);

        /*Map<String, Object> payload = new Map<String, Object>{
            'model' => 'gpt-3.5-turbo',
            'messages' => lstPrompts,
            'max_tokens' => 200,
            'temperature' => 0.7
        };*/

        Map<String, Object> payload = new Map<String, Object>{
            'model' => 'gpt-3.5-turbo',
            'messages' => lstPrompts,
            'temperature' => 0.7
        };

        request.setBody(JSON.serialize(payload));

        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            System.debug(response.getBody());
            Map<String, Object> responseBody = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            List<Object> choices = (List<Object>)responseBody.get('choices');
            if (choices.size() > 0) {
                Map<String, Object> choice = (Map<String, Object>)choices.get(0);
                Map<String,Object> mpMessages = (Map<String,Object>)choice.get('message');

                String responseText = (String)mpMessages.get('content');

                responseText = responseText != null ? responseText.trim() : '';
                //system.debug('Response Text: ' + responseText);
                return responseText;
            }
            return null;
        } else {
            throw new CalloutException('OpenAI Completion API call failed: ' + response.getBody());
        }
    }
    
    @AuraEnabled(cacheable=false)
    public static String getAnswerFromOpenAI2(String userQuery) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(OPENAI_COMPLETION_ENDPOINT);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + OPENAI_API_KEY);
        request.setHeader('Content-Type', 'application/json');

        //String combinedContext = String.join(context,'\n');
        String prompt = 'Answer the question:\n\n' + '\n\nQuestion: ' + userQuery + '\nAnswer:';
        
        Map<String, Object> PromptBody = new Map<String, Object>();
        PromptBody.put('role','user');
        PromptBody.put('content',prompt);
        List<Object> lstPrompts = new List<Object>();
        lstPrompts.add(PromptBody);

        /*Map<String, Object> payload = new Map<String, Object>{
            'model' => 'gpt-3.5-turbo',
            'messages' => lstPrompts,
            'max_tokens' => 200,
            'temperature' => 0.7
        };*/

        Map<String, Object> payload = new Map<String, Object>{
            'model' => 'gpt-3.5-turbo',
            'messages' => lstPrompts,
            'temperature' => 0.7
        };

        request.setBody(JSON.serialize(payload));

        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            System.debug(response.getBody());
            Map<String, Object> responseBody = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            List<Object> choices = (List<Object>)responseBody.get('choices');
            if (choices.size() > 0) {
                Map<String, Object> choice = (Map<String, Object>)choices.get(0);
                Map<String,Object> mpMessages = (Map<String,Object>)choice.get('message');

                String responseText = (String)mpMessages.get('content');

                responseText = responseText != null ? responseText.trim() : '';
                //system.debug('Response Text: ' + responseText);
                return responseText;
            }
            return null;
        } else {
            throw new CalloutException('OpenAI Completion API call failed: ' + response.getBody());
        }
    }
}