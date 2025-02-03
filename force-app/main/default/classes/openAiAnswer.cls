public with sharing class openAiAnswer implements Queueable, Database.AllowsCallouts {
    private List<String> paramFromResponse2;
    private string userQuestion;
    private string recId;
    private string type;

    // Constructor to pass data to this job
    public openAiAnswer(List<String> paramFromResponse2, string userQuestion, string recId,string type) {
        this.paramFromResponse2 = paramFromResponse2;
        this.userQuestion = userQuestion;
        this.recId = recId;
        this.type = type;
    }

    public void execute(QueueableContext context) {
        try {            
            // Perform the third API call            
            HttpResponse response = makeApiCall(paramFromResponse2,userQuestion,type);
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
                    if(recId != null && responseText != null && string.valueOf(Id.valueOf(recId).getSObjectType()) == 'User_Story__c'){
                        User_Story__c us = [SELECT Id,Name,Acceptance_Criteria__c,Technical_Requirement__c,Technical_Solution__c,User_Story_Summary__c FROM User_Story__c WHERE id =: recId];
                        system.debug('type----'+type);
                        if(type=='Acceptance Criteria'){
                            us.Acceptance_Criteria__c = responseText;
                        }
                        if(type=='Solution Options'){
                            system.debug('tech block----');
                            us.Technical_Solution__c = responseText;
                        }
                        if(type == 'User Story Document'){
                            us.User_Story_Summary__c = responseText;
                        }
                        
                        update us;
                    }

                    if(recId != null && responseText != null && string.valueOf(Id.valueOf(recId).getSObjectType()) == 'Metadata__c'){
                        Metadata__c md = [SELECT Id,Name,Change_Summary__c,Code_Review_Summary__c FROM Metadata__c WHERE id =: recId];
                        if(type == 'Metadata'){
                            md.Change_Summary__c = responseText;
                        }
                        if(type == 'Code Review'){
                            md.Code_Review_Summary__c = responseText;
                        }
                        
                        update md;
                    } 
                }                
            }
        } catch (Exception e) {
            System.debug('Error in ThirdApiCallQueueable: ' + e.getMessage());
        }
    }

    private HttpResponse makeApiCall(List<String> context,string userQuery,string type) {
        string prompt = '';
        string openAIEndPoint = 'https://api.openai.com/v1/chat/completions';
        string openAIKey= System.Label.Open_AI_API_Key;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(openAIEndPoint);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + openAIKey);
        request.setHeader('Content-Type', 'application/json');
        request.setTimeout(120000);

        String combinedContext = String.join(context,'\n');
        if(type == 'Metadata'){
            prompt = 'Answer the question based on the following context:\n\n' + combinedContext + '\n\nQuestion: ' + userQuery + '\nAnswer:';
        }else{
            prompt = aiPrompts.prompts(type,combinedContext,userQuery,recId);
        } 
        system.debug('Full Prompt---'+prompt);
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

    private static void markdownHtml(string markdownContent){
        string gitHubToken = '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';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.github.com/markdown');
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + gitHubToken);
        request.setHeader('X-GitHub-Api-Version', '2022-11-28');
        request.setHeader('Accept', 'application/vnd.github+json');
        //request.setTimeout(120000);
        request.setBody(markdownContent);
        HttpResponse response = http.send(request);
    }
}