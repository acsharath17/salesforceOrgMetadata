@RestResource(urlMapping='/Account/*/contacts')
global with sharing class AccountManager {
	
    @HttpGet
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        string accId = request.requestURI.substring(request.requestURI.lastIndexof('/')-18 , request.requestURI.lastIndexof('/'));
        List<Account> acc = [Select Id,Name,(Select Id,Name from Contacts) from Account WHERE Id =: accId];
        return acc[0];
    }
}