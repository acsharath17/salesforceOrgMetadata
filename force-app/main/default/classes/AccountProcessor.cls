public class AccountProcessor{
    @future
    public static void countContacts(List<Id> Ids){
        List<Account> acc = new List<Account>();
        for(Account aa : [Select id,name,Number_of_Contacts__c,(Select id,name from Contacts) from Account WHERE Id IN: Ids]){
            integer con_Size = aa.Contacts.Size();            
            aa.Number_of_Contacts__c = con_Size;
            acc.add(aa);
        }
        if(!acc.isEmpty())
            update acc;
    }
}