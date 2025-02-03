public class ParentChildSample {
	public static void InsertParentChild() {
        Date dt = Date.today();
        dt = dt.addDays(7);
        List<Opportunity> opp = new List<Opportunity>();
        List<Account> acc = new List<Account>();
        List<sObject> lstSobject = new List<sObject>();
   		
        
        Account acnt = [Select id,For_ExternalId__c From Account Order By Createddate desc limit 1];
        integer ex = integer.valueof(acnt.For_ExternalId__c) + 1;
        
        for(Integer i = 0; i < 3; i++){
            ex = ex + i;
            string ex_id = 'External '+string.valueof(ex);
            system.debug('AAAAAAAAAAAAAA '+ex_id);
            Opportunity newOpportunity = new Opportunity(Name='OpportunityWithAccountInsert ' +i,StageName='Prospecting',CloseDate=dt);        
            Account accountReference = new Account(MyExtID__c=ex_id); 
            newOpportunity.Account = accountReference;
            Account parentAccount = new Account(Name='Hallie '+i, MyExtID__c = ex_id);
            system.debug('DDDDDDDDDDDDDDDDDD'+newOpportunity.Account);
            
            lstSobject.add(newOpportunity);
            lstSobject.add(parentAccount);
            
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@ '+lstSobject);
            
           
            
        }
        
        
		Database.SaveResult[] results = Database.insert(lstSobject);
        
        
       // Database.SaveResult[] results = Database.insert(acc,opp);
       // Database.SaveResult[] results = Database.insert(new sObject[] {acc1,opp1});

        for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
                System.debug('Successfully created ID: '+ results[i].getId());
            } else {
                System.debug('Error: could not create sobject '+ 'for array element ' + i + '.');
                System.debug(' The error reported was: '+ results[i].getErrors()[0].getMessage() + '\n');
            }
        }
    }
}