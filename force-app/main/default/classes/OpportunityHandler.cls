public class OpportunityHandler{
    
    public static void hello(Map<Id,Opportunity> OppMap){
        for(Opportunity opp : [Select id,Name,Account.Name from Opportunity WHERE Id IN: OppMap.KeySet()]){
            system.debug('Opp---------'+opp.Account.Name);
        }
    }
}