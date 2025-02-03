public class display_opp {
    
    public List<Opportunity> opp {get;set;}
    
    public display_opp(){
        
       /* opp = new List<Opportunity>();
        opp = [Select id,name,stagename,amount from opportunity];*/
    }
    
    public list<Opportunity> getall_opp(){
        list<opportunity> oppr = opp = [Select id,name,stagename,amount from opportunity limit 10];
        return oppr;
    }
    
    public void all(){
    opp = new List<Opportunity>();
        opp = [Select id,name,stagename,amount from opportunity limit 10];
    }

}