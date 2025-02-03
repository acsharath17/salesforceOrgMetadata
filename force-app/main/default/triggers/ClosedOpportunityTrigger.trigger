trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    if(trigger.isAfter && trigger.isUpdate)
        opportunityTriggerHandler.createTask(trigger.new, trigger.oldMap, true);
        
    if(trigger.isAfter && trigger.isInsert)
        opportunityTriggerHandler.createTask(trigger.new, trigger.oldMap, false);
}