public with sharing class parentAndChildController {

    

    Public static List<Account> getaccountAndContacts(){
        return [Select Id,Name,(Select Id,Name,Email,MobilePhone from Contacts) from Account limit 50];
    }

}