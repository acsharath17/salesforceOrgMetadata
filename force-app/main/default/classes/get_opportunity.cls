public class get_opportunity {
    
    public List<Opportunity> opp = new List<Opportunity>();
    public List<Opportunity> opp1 {get;set;}
    
    public get_Opportunity(){
        opp1 = new List<Opportunity>();
        opp1 = [Select id,name,Amount,StageName From Opportunity];
    }
    
    public list<Opportunity> getOpp_List(){
        opp = [Select id,name,Amount,owner.name,Account.name From Opportunity];
        return opp;
    }
    
}