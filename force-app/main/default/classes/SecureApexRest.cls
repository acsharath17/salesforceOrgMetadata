@RestResource(urlMapping='/secureApexRest')
global with sharing class SecureApexRest {
    @HttpGet
    global static Contact doGet(){
        Id recordId = RestContext.request.params.get('id');
        Contact result;
        if (recordId == null){
            throw new FunctionalException('Id parameter is required');
        }
        
        
        try{
            List<Contact> results = [SELECT id, Name, Secret_Key__c FROM Contact WHERE Id = :recordId WITH SECURITY_ENFORCED];
            return results[0];
        }catch(System.QueryException e){
            throw new SecurityException('You don\'t have access to all contact fields required to use this API');
        }
        
        
        
    }
    public class FunctionalException extends Exception{}
    public class SecurityException extends Exception{}
}