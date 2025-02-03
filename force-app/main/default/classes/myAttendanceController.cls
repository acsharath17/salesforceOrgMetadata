public class myAttendanceController {
    public Id contactId;
    public Integer attendedCount{get;set;}
    public Integer partialCount{get;set;}
    public Integer absentCount{get;set;}        
    public myAttendanceController(){
        attendedCount = 50;
        partialCount = 30;
        absentCount = 20;
        User loggedInUser = [Select Id,contactId FROM User WHERE ID=:userinfo.getUserId()];
        contactId = loggedInUser.contactId;
        /*List<AggregateResult> aggList =[Select Attendence_Status__c,Count(Id) FROM Attendance__c WHERE Enrollment__r.Student__c=:contactId GROUP BY Attendence_Status__c];
        for(AggregateResult aggResult:aggList){
            if(aggResult.get('Attendence_Status__c')=='Partially Attended'){
                partialCount= (Integer)aggResult.get('expr0');
            }else if(aggResult.get('Attendence_Status__c')=='Attended'){
                attendedCount = (Integer)aggResult.get('expr0');
            }else if(aggResult.get('Attendence_Status__c')=='Absent'){
                absentCount= (Integer)aggResult.get('expr0');
            }
        }*/
    }
}