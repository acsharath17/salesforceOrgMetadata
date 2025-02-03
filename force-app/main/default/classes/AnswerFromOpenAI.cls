public class AnswerFromOpenAI implements Queueable, Database.AllowsCallouts {
    private List<String> paramFromResponse2;
    private string userQuestion;

    // Constructor to pass data to this job
    public AnswerFromOpenAI(List<String> paramFromResponse2, string userQuestion) {
        this.paramFromResponse2 = paramFromResponse2;
        this.userQuestion = userQuestion;
    }

    public void execute(QueueableContext context) {
        try {            
            // Perform the third API call            
            HttpResponse response = makeApiCall(paramFromResponse2,userQuestion);
            if (response.getStatusCode() != 200) {
                throw new CalloutException('Third API call failed with status code: ' + response.getStatusCode());
            }

            // Process the final response
            System.debug('Third API Call Response: ' + response.getBody());
            if (response.getStatusCode() == 200) {
                System.debug(response.getBody());
                Map<String, Object> responseBody = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                List<Object> choices = (List<Object>)responseBody.get('choices');
                if (choices.size() > 0) {
                    Map<String, Object> choice = (Map<String, Object>)choices.get(0);
                    Map<String,Object> mpMessages = (Map<String,Object>)choice.get('message');
    
                    String responseText = (String)mpMessages.get('content');
    
                    responseText = responseText != null ? responseText.trim() : '';
					system.debug('Response---'+responseText); 
                }                
            }
        } catch (Exception e) {
            System.debug('Error in ThirdApiCallQueueable: ' + e.getMessage());
        }
    }

    private HttpResponse makeApiCall(List<String> context,string userQuery) {
        string openAIEndPoint = 'https://api.openai.com/v1/chat/completions';
        string openAIKey='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';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(openAIEndPoint);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + openAIKey);
        request.setHeader('Content-Type', 'application/json');
        request.setTimeout(120000);

        String combinedContext = String.join(context,'\n');
        String prompt = 'Answer the question based on the following context:\n\n' + combinedContext + '\n\nQuestion: ' + userQuery + '\nAnswer:';
        
        Map<String, Object> PromptBody = new Map<String, Object>();
        PromptBody.put('role','user');
        PromptBody.put('content',prompt);
        List<Object> lstPrompts = new List<Object>();
        lstPrompts.add(PromptBody);

        Map<String, Object> payload = new Map<String, Object>{
            'model' => 'gpt-4-turbo',
            'messages' => lstPrompts,
            'temperature' => 0.7
        };

        request.setBody(JSON.serialize(payload));

        HttpResponse response = http.send(request);
        return response;
    }
}