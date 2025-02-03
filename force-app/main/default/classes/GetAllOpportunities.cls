public with sharing class GetAllOpportunities {
    
    
   
    @AuraEnabled
    public static List<Opportunity> getAllOps(){
        return [Select Id,Name, Amount, StageName,CloseDate,Type From Opportunity];    
    }
}