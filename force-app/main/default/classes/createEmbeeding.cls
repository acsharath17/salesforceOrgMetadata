public with sharing class createEmbeeding implements Queueable, Database.AllowsCallouts {
    private string userQuestion;
    private string recId;
    private string type;
    public createEmbeeding (string userQuestion, string recId,string type){
        this.userQuestion = userQuestion;
        this.recId = recId;
        this.type = type;
    }
    
    public void execute(QueueableContext context) {
        try {
            List<Double> embeddings = new List<Double>();
            // Perform the first API call
            HttpResponse response = makeApiCall(userQuestion);
            if (response.getStatusCode() == 200) {
                Map<String, Object> result = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                List<Object> data = (List<Object>)result.get('data');
                system.debug('response size---'+data.size());
                if (data.isEmpty()) {
                    throw new CalloutException('No embedding data returned from OpenAI.');
                }
                
                Map<String, Object> embeddingData = (Map<String, Object>)data[0];
                List<Object> embedding = (List<Object>)embeddingData.get('embedding');
                // Convert List<Object> to List<Double>
                
                for (Object value : embedding) {
                    embeddings.add((Double)value);
                }
            }else{
                system.debug('Status code--'+response.getStatusCode());
                //throw new CalloutException('OpenAI Embedding API call failed: ' + response.getBody());
            }

            // Extract data from response1 if needed
            //String paramFromResponse1 = response.getBody(); // Example extraction

            // Chain the second API call
            system.debug('embeeding size---'+embeddings.size());
            System.enqueueJob(new vectorDbSearch(embeddings,userQuestion,recId,type));
        } catch (Exception e) {
            System.debug('Error in FirstApiCallQueueable: ' + e.getMessage());
        }
       
    }

    private HttpResponse makeApiCall(string inputText) {
        string OPENAI_API_KEY = System.Label.Open_AI_API_Key;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.openai.com/v1/embeddings');
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + OPENAI_API_KEY);
        request.setHeader('Content-Type', 'application/json');

        Map<String, Object> payload = new Map<String, Object>{
            'input' => inputText,
            'model' => 'text-embedding-ada-002'
        };

        request.setBody(JSON.serialize(payload));

        HttpResponse response = http.send(request);
        
        return response;

    }
}