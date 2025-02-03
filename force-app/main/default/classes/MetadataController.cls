public with sharing class MetadataController {

    public PageReference deleteField() {
        return null;
    }

 
    public MetadataService.AsyncResult result {get;set;}
 
    public PageReference createField()
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
         
        MetadataService.CustomField customField = new MetadataService.CustomField();
        customField.fullName = 'Test__c.TestField__c';
        customField.label = 'Test Field';
        customField.type_x = 'Text';
        customField.length = 42;
        //MetadataService.AsyncResult[] results =
        //service.create(new List<MetadataService.Metadata> { customField });
        
        // .. as per above ...
        //result = createService().create(new List<MetadataService.Metadata> { customField })[0];
        displayStatus();
        return null;
    }
 
    public PageReference checkStatus()
    {
        // Check status of the request
        //result = createService().checkStatus(new List<String> { result.Id })[0];
        displayStatus();
        return null;
    }
 
    private void displayStatus()
    {
        // Inspect the AsyncResult and display the result
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,
                result.done ? 'Request completed' : 'Request in progress...'));
        if(result.state == 'Error')
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, result.message));
        if(result.done)
            result = null;
    }
}