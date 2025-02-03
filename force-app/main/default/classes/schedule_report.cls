public class schedule_report{

    

    
    public void create_Task(datetime frm , datetime to, id parentId ){
        
        date from_date = date.valueof(frm);
        date to_date = date.valueof(to);
        //long diff = to_date - from_date;*/
        
        integer differ = from_date.daysBetween(to_date);
        
        integer incr = 0;
        list<Scheduled_Times__c> S_time = new list<Scheduled_Times__c>();
        for(integer i = 0 ; i < differ ; i++){
            Scheduled_Times__c ST = new Scheduled_Times__c();
            incr = incr + 1;
            ST.Schedule_Time__c = frm + incr;
            ST.Status__c = 'Scheduled';
            ST.Schedule_Report__c = parentId;
            S_time.add(ST);            
               
        }
        insert S_time;
         
    }
    
    public void update_task(datetime frm , datetime to, id parentId){
    
        date from_date = date.valueof(frm);
        date to_date = date.valueof(to);
        //long diff = to_date - from_date;*/
        integer incr = 0;
        integer differ = from_date.daysBetween(to_date);
        
        list<Scheduled_Times__c> del_task = [Select id from Scheduled_Times__c Where Schedule_Report__c =: parentId and Status__c != 'Completed'];
        delete del_task;
        
        list<Scheduled_Times__c> Sc_time = new list<Scheduled_Times__c>();
        
        for(integer i = 0 ; i < differ ; i++){
            
            Scheduled_Times__c STm = new Scheduled_Times__c();
            incr = incr + 1;
            STm.Schedule_Time__c = frm + incr;
            STm.Status__c = 'Scheduled';
            STm.Schedule_Report__c = parentId;
            Sc_time.add(STm);   
        }
        insert Sc_time;
    
    }
    
}