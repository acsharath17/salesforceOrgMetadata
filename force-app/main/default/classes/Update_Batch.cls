global class Update_Batch implements Database.Batchable<sObject>{
    String query;
     
    global Database.querylocator start(Database.BatchableContext BC){
        Query = 'Select id,name,Status,phone From Lead where isConverted = false';   
        return Database.getQueryLocator(query); //50 million
    }
 
    global void execute(Database.BatchableContext BC, List<Lead> scope){
        
        list<Lead> lead_update = new List<Lead>();
        
        for(integer i =0 ; i < scope.size() ; i++){
            if(scope[i].Status == 'Working - Contacted'){
                scope[i].phone = '23239664';
            }
            
            lead_Update.add(scope[i]);
            
        }
        
        update lead_Update;
        
        /*for(Lead ld : scope){
            if(ld.Status == 'Working - Contacted')
        }*/
        
    }
     
    global void finish(Database.BatchableContext BC){
    }
}