public class Shiva_Example_1 {
    
    public List<Opportunity> opp{get;set;}
    
    public Shiva_Example_1(){
        opp = new List<Opportunity>([Select id,name,StageName,Amount From Opportunity limit 5]);
    }

}