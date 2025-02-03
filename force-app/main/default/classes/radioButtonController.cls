public class radioButtonController {
	@AuraEnabled
    public static List<Contact> getContacts(id accId){
        return [Select Name from Contact where AccountId =: accId];
    }
}