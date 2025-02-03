@RestResource(urlMapping='/apexSecurityRest')
global with sharing class ApexSecurityRest{
    @HttpGet
    global static contact doGet() {
        Id recordId = RestContext.request.params.get('id');
        Contact result;
        if (recordId == null) {
           throw new FunctionalException('Id parameter is required');
        }
        List<Contact> results = [SELECT id, Name,Description , Title, Top_Secret__c, Account.Name FROM Contact WHERE Id = :recordId];
        SObjectAccessDecision securityDecision = Security.stripInaccessible(AccessType.READABLE, results);
        contact con = (contact)securityDecision.getRecords()[0];
        con.Description = con.Account?.Name;
        
        return con;
      }
      public class FunctionalException extends Exception{}
      public class SecurityException extends Exception{}
}