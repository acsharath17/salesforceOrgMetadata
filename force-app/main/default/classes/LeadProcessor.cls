global class LeadProcessor implements Database.Batchable<sObject>{
    
    global Database.QueryLocator Start(Database.BatchableContext bc){
        string qstring = 'Select Id,Name,LeadSource from Lead';
        return Database.getQueryLocator(qstring);
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> records){
        List<Lead> leads = new List<Lead>();
        for(Lead led : records){
            led.LeadSource = 'Dreamforce';
            leads.add(led);
        }
        if(!leads.isEmpty())
            update leads;
    } 
    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    } 
}