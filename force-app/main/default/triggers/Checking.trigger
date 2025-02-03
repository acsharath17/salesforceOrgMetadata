trigger Checking on Opportunity (After Insert) {
    OpportunityHandler.Hello(Trigger.NewMap);    
}