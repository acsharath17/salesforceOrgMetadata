trigger Account_Update_Example_2 on Account (before insert , before update , after insert , after update) {
    
    if(trigger.isBefore){
        
        for(Account a : trigger.new){
        
        if(a.Type == 'Prospect'){
            a.AnnualRevenue = 1000;
        }else         
            if(a.Type == 'Customer - Direct'){
                a.AnnualRevenue = 2000;
            }else{
                a.AnnualRevenue = null;
            }
        }        
    }
    
    
    
        
}