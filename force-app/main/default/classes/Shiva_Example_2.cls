public class Shiva_Example_2 {

    public Shiva_Example_2(ApexPages.StandardController controller) {

    }
    
    public List<Opportunity> opp {get;set;}
    
    public void Opp_List(){
        Opp = new List<Opportunity>([Select id,name,StageName,Amount From Opportunity limit 5]);
    }
    
    public List<Opportunity> getall_opp(){ // No need to call this methods through button in page
    
        /*
        Both Contructor and all get method will executed automatically once the page is loaded but the difference is constructor can be called only once
        where as get method can be called multiple times.
        */
    
        List<Opportunity> opp = [Select id,name,StageName,Amount From Opportunity Limit 5];
        return Opp;
    }

}