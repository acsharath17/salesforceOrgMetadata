public class serviceRequest {
	@AuraEnabled
    public static string getrecTypeId(){
        return Schema.SObjectType.House__c.getRecordTypeInfosByName().get('England').getRecordTypeId();
    }
}