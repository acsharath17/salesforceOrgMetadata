public with sharing class openAIService {
    private static final String API_KEY = System.label.chatGPTAPIKey; // Replace with your actual API key
    private static final String ENDPOINT_URL = 'https://api.openai.com/v1/chat/completions';

    /**
     * @description Method to generate response from ChatGPT
     */
    @AuraEnabled(cacheable=false)
    public static String generateResponse(String messageText) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ENDPOINT_URL);
        req.setMethod('POST');
        req.setTimeout(1000*120);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Bearer ' + API_KEY); // Add the API key to the request header

        // Set the request body
        String prompt = 'You are a helpful assistant.\nUser: ' + messageText + '\nAssistant:';
        System.debug(prompt); 

        Map<String, Object> systemPromptBody = new Map<String, Object>();
		systemPromptBody.put('role','system');
        systemPromptBody.put('content','you are a salesforce expert and you to provide detailed implementation plan for the given user story or fetaure requested and where ever possible suggest multiple options with pros and cons for the same');

        Map<String, Object> PromptBody = new Map<String, Object>();
        PromptBody.put('role','user');
        PromptBody.put('content',messageText);

        List<Object> lstPrompts = new List<Object>();
        lstPrompts.add(systemPromptBody);
        lstPrompts.add(PromptBody);

        Map<String, Object> requestBody = new Map<String, Object>();
        requestBody.put('messages', lstPrompts);
        requestBody.put('model', 'gpt-3.5-turbo');
        //requestBody.put('max_tokens', 50);
        //requestBody.put('n', 1);
        //requestBody.put('stop', new List<String>{'\n'});

        req.setBody(JSON.serialize(requestBody));
        System.debug('Request Body: ' + req.getBody());

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            System.debug(res.getBody());
            Map<String, Object> responseBody = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            List<Object> choices = (List<Object>)responseBody.get('choices');
            if (choices.size() > 0) {
                Map<String, Object> choice = (Map<String, Object>)choices.get(0);
                Map<String,Object> mpMessages = (Map<String,Object>)choice.get('message');

                String responseText = (String)mpMessages.get('content');

                responseText = responseText != null ? responseText.trim() : '';
                //system.debug('Response Text: ' + responseText);
                return responseText;
            }
        } else {
            System.debug('Error: ' + res.getStatusCode() + ' ' + res.getStatus());
            throw new ChatGPTException('Error: Unable to generate response from ChatGPT.');
        }

        return '';
    }
     /**
     * @description Custom exception class
     */
    public class ChatGPTException extends Exception {}
}