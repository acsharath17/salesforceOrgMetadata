public class ParentChildSample_2 {
    public static void InsertParentChild(){
        Date dt = Date.today();
dt = dt.addDays(7);

List<sObject> lstSobject = new List<sObject>();

Opportunity newOpportunity1 = new Opportunity(Name='OpportunityWithAccountInsert1',StageName='Prospecting',CloseDate=dt);        
Account accountReference = new Account(MyExtID__c='12345'); 
newOpportunity1.Account = accountReference;
lstSobject.add(newOpportunity1);

Opportunity newOpportunity2 = new Opportunity(Name='OpportunityWithAccountInsert2',StageName='Prospecting',CloseDate=dt);        
Account accountReference1 = new Account(MyExtID__c='123456'); 
newOpportunity2.Account = accountReference1;
lstSobject.add(newOpportunity2);

Account parentAccount1 = new Account(Name='Hallie',MyExtID__c='12345'); 
lstSobject.add(parentAccount1);
Account parentAccount2 = new Account(Name='Hallie',MyExtID__c='123456'); 
lstSobject.add(parentAccount2);

Database.SaveResult[] results = Database.insert(lstSobject);

for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
            System.debug('Successfully created ID: '
                  + results[i].getId());
            } else {
            System.debug('Error: could not create sobject '
                  + 'for array element ' + i + '.');
            System.debug('   The error reported was: '
                  + results[i].getErrors()[0].getMessage() + '\n');
            }
        }
    }
}