public class opportunityTriggerHandler{
    public static void createTask(List<Opportunity> newRecords, map<Id,Opportunity> oldRecords , boolean updateTrigger){
        List<Task> createTask = new List<Task>();
        if(updateTrigger){
            for(Opportunity opp : newRecords){
                if(oldRecords.get(opp.Id).StageName != 'Closed Won' && opp.StageName == 'Closed Won'){
                    Task t = new Task();
                    t.whatId = opp.Id;
                    t.subject = 'Follow Up Test Task';
                    createTask.add(t);
                }        
            }
        }else{
            for(Opportunity opp : newRecords){
                if(opp.StageName == 'Closed Won'){
                    Task t = new Task();
                    t.whatId = opp.Id;
                    t.subject = 'Follow Up Test Task';
                    createTask.add(t);
                }        
            }    
        }
        if(!createTask.isEmpty())
            insert createTask;       
    }
            
}