public class wrapperDisplayController {
	
    
    @AuraEnabled
    public static List<Contact> getcons(){
        return [Select id,name,Email,Phone,FirstName,LastName,Department from Contact Limit 10];
    }
    
    
}