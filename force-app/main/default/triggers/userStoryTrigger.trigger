trigger userStoryTrigger on User_Story__c (after update) {
    for(User_Story__c us: trigger.new){
        if(us.Generate_Summary__c && !trigger.oldMap.get(us.Id).Generate_Summary__c){
            System.enqueueJob(new EmbeddingsFromOpenAI(us.Id));
        }       
    }
}