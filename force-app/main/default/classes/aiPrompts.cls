public with sharing class aiPrompts {
    public aiPrompts() {

    }

    public static string prompts(string type,string context,string userQuery,string recId){
        string promptString='';
        List<AI_Prompts__mdt> promptMetadata = [SELECT id,Label,Prompt__c FROM AI_Prompts__mdt];
        map<String,String> promptMap = new map<String,String>();
        for(AI_Prompts__mdt AP : promptMetadata){
            promptMap.put(AP.Label,AP.Prompt__c);
        }
        if(type=='Acceptance Criteria'){
            promptString = 'Act as a Salesforce product manager. Write a detailed user story for '+'\n Requirement :'+userQuery+'\n';
            promptString += 'Given the requirement and Salesforce metadata context below, generate the following:'+'\n';
            promptString += promptMap.get('Acceptance Criteria')+'\n';
            promptString += 'Salesforce metadata context : '+context;
        }

        if(type == 'Solution Options'){
            promptString = 'You are a Salesforce Technical Expert specializing in designing and implementing scalable solutions. Based on the user story and the metadata context of the Salesforce org provided below, generate the following: '+'\n';
            promptString += 'Acceptance Criteria :  '+userQuery+' \n';
            promptString += 'Metadata Context : '+context;
            promptString += 'For each approach: '+'\n'+promptMap.get('Solution Options');
        }

        if(type == 'Code Review'){
            promptString = promptMap.get('Code Review');
            promptString += '\n'+userQuery+' \n';
            promptString += 'Full Metadata Context : '+context;
        }

        if(type == 'User Story Document'){
            string metadataList = userStoryMetadata(recId);
            promptString = promptMap.get('User Story Document');
            promptString += 'Input '+'\n\n'+'Metadata List '+'\n\n'+ metadataList +'\n';
            promptString += 'Full Metadata Context : '+context;
        }
        system.debug('complete prompt String---'+promptString);
        return promptString;
    }

    @AuraEnabled
    public static Boolean checkJobStatus() {
        List<AsyncApexJob> job = [SELECT Status,MethodName,ApexClass.Name FROM AsyncApexJob WHERE ApexClass.Name IN('openAiAnswer','vectorDbSearch','createEmbeeding') AND Status != 'Completed'];
        boolean done = job.size() == 0 ? true : false;
        system.debug('done----'+job.size());
        return done;
    }

    public static string userStoryMetadata(string recordId){
        string metadataList = '';
        integer i=1;
        for(Metadata__c md : [SELECT id,Name,Metadata_Type__c FROM Metadata__c WHERE User_Story__c =: recordId]){
            metadataList += i+'. '+'Metadata Name : '+md.Name+'\n';
            metadataList += 'Metadata Type : '+md.Metadata_Type__c+'\n';
        }
        return metadataList;
    }
}