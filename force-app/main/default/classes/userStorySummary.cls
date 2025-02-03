public with sharing class userStorySummary {
    public userStorySummary() {

    }
    @AuraEnabled(cacheable=false)
    public static string metadataSummary(string recId){
        string summary='';
        for(Metadata__c md : [SELECT id,Name,Change_Summary__c FROM Metadata__c WHERE User_Story__c =: recId]){
            summary = summary+md.Change_Summary__c+'\n\n';
        }
        system.debug('Summary----'+summary);
        string htmlContent= markdownDataConverter.markdownHtml(summary);
        return htmlContent;
    }

}