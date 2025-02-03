trigger Expense_trigger on Expense__c (before Insert,Before Update) {
    
    Map<string,Area_Pin__c> areaCodes = Area_Pin__c.getAll();
    integer aa = 0;
    for(Expense__c ee : trigger.new){
        aa += 1;
        ee.Area_Code__c = string.valueOf(aa);
        system.debug('AutoNumber--------'+ee.Area_Code__c );
        if(ee.Area__c != null){
            ee.Area_Code__c = areaCodes.get(ee.Area__c).PIN__c;
        }
            
    }
}