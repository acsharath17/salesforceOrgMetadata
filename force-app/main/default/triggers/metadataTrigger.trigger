trigger metadataTrigger on Metadata__c (after Update) {
    for(Metadata__c md : trigger.new){
        if(md.Generate_Summary__c && !trigger.oldMap.get(md.Id).Generate_Summary__c){
            System.enqueueJob(new EmbeddingsFromOpenAI(md.Id));
        }        
    }
}