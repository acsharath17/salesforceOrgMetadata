public with sharing class tiered_tables_v2 {

    public tiered_tables_v2(ApexPages.StandardSetController controller) {

    }
    
    public List<Account> getAcc(){
        return [Select id,name,BillingStreet,(Select id,name from Contacts) from Account];
    }

}