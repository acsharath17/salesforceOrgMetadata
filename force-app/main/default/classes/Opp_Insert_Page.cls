public  class Opp_Insert_Page {
    
    public Opportunity pp {get;set;}
    public Opportunity opp {get;set;}
    public string dd{get;set;}
    
    public string Opp_name{get;set;}
    public string opp_Stage{get;set;}
    
    public Opp_Insert_Page(){
        pp = new Opportunity();
        opp = new Opportunity();
    }
    
    public pagereference insert_opp(){
        
        
        opp.name = opp_name;
        opp.CloseDate = system.today();
        opp.StageName = opp_Stage;
        insert opp;
        dd = opp.id;
        return page.detail_Page;
    }

}