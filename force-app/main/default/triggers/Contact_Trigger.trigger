trigger Contact_Trigger on Contact (after insert , after update) {
    
    if(trigger.isAfter && trigger.isUpdate){
        List<Contact> con = new List<Contact>();
        
        for(Integer i = 0 ; i <= 150 ; i++){
            Account aa = [Select Id,Name from Account Limit 1];
        }
        //update con;
    }
}