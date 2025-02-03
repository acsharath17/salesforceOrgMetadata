public with sharing class vectorDbSearch implements Queueable, Database.AllowsCallouts {
    private List<Double> paramFromResponse1;
	private string userQuestion;
    private string recId;
    private string type;
    
    // Constructor to pass data to this job
    public vectorDbSearch(List<Double> paramFromResponse1, string userQuestion,string recId,string type) {
        this.paramFromResponse1 = paramFromResponse1;
        this.userQuestion = userQuestion;
        this.recId = recId;
        this.type = type;
    }

    public void execute(QueueableContext context) {
        try {
            List<String> results = new List<String>();
            // Perform the second API call
            HttpResponse response = makeApiCall('https://sfcustomobjects-lll4zxo.svc.aped-4627-b74a.pinecone.io/query', paramFromResponse1);
            if (response.getStatusCode() != 200) {
                throw new CalloutException('Second API call failed with status code: ' + response.getStatusCode());
            }

            String paramFromResponse2 = response.getBody(); // Example extraction
			system.debug('response from pinecone---'+paramFromResponse2);
            
            if(response.getStatusCode() == 200){
                Map<String, Object> result = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                List<Object> matches = (List<Object>)result.get('matches');                
                for (Object matchObj : matches) {
                    Map<String, Object> match = (Map<String, Object>)matchObj;
                    Map<String, Object> metadata = (Map<String, Object>)match.get('metadata');
                    results.add((String)metadata.get('text'));
                }
                system.debug('embeeding size---'+results.size());
            	System.enqueueJob(new openAiAnswer(results,userQuestion,recId,type));
            }
            
        } catch (Exception e) {
            System.debug('Error in SecondApiCallQueueable: ' + e.getMessage());
        }
    }

    private HttpResponse makeApiCall(String url, List<Double> body) {
        string PINECONE_API_KEY = '9e1f0dfd-6c79-489d-94d2-d2336a6a4f99';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('POST');
        request.setHeader('Api-Key', PINECONE_API_KEY);
        request.setHeader('Content-Type', 'application/json');
        Map<String, Object> payload = new Map<String, Object>{
            'vector' => body,
            'topK' => 10,
            'includeValues' => false,
            'includeMetadata' => true
        };
        request.setBody(JSON.serialize(payload));
        return http.send(request);
    }

}