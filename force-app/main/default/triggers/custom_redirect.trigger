trigger custom_redirect on Bank__c (before insert) {
    
    /*if(trigger.isInsert){
        custom_Save.re_direct();
    }*/
    
    for(Bank__c b : trigger.new){
       custom_Save cc = new custom_Save();
       cc.re_direct();
       system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
    }
    
}