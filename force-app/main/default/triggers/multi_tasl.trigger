trigger multi_tasl on Schedule_Report__c (after insert , after update) {
    
    datetime frm_time;
    datetime to_time;
    id partid;
    
    for(Schedule_Report__c t : trigger.new){
        frm_time = t.Start_Date__c;
        to_time = t.End_Date__c;
        partid = t.id;
    }
    
    schedule_report sr = new schedule_report();
    
    if(trigger.isInsert){
    system.debug('DDDDDDDDDDDDDDDDDDDDDDDDD '+frm_time+ ' DDDDDDDDDDDDDDDDDDDDD '+to_time+' DDDDDDDDDDDDDDDDD '+partid);
    sr.create_Task(frm_time,to_time,partid);
    }
    
    if(trigger.isUpdate){
    system.debug('DDDDDDDDDDDDDDDDDDDDDDDDD '+frm_time+ ' DDDDDDDDDDDDDDDDDDDDD '+to_time+' DDDDDDDDDDDDDDDDD '+partid);
    sr.update_task(frm_time,to_time,partid);
    }
    
}