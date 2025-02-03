global class GoogleChartsController_new {
    @RemoteAction   
    global static AggregateResult[] loadOpps() {
        return [select name nm , SUM(Amount) amt from Opportunity Group by name limit 10];
    } 
    
    @RemoteAction   
    global static AggregateResult[] loadOpps2() {
        return [select name nm , SUM(Amount) amt from Opportunity Group by name limit 10];
    } 
    
    @RemoteAction   
    global static AggregateResult[] loadOpps3() {
        return [select name nm , SUM(Amount) amt from Opportunity Group by name limit 10];
    }
    
    @RemoteAction   
    global static AggregateResult[] loadOpps4() {
        return [select name nm , SUM(Amount) amt from Opportunity Group by name limit 10];
    }
    
}