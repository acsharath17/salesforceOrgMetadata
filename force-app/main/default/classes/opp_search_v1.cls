public  class opp_search_v1 {

    public opp_search_v1(ApexPages.StandardController controller) {

    }
    
    public string selected_stage{get;set;}
    public string acc{get;set;}
    public List<Opportunity> opp {get;set;}
    public List<wrap_opp> opp_list{get;set;}
    
    public List<Opportunity> getall_opp(){
    
        opp = new List<Opportunity>();
        string qry = 'Select id,name , stagename from opportunity Where name != null';
        
        if(selected_stage != null){
            qry += ' and StageName =: selected_stage';
        }
        
        system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA '+qry);
        opp = database.query(qry);
        
        return opp;
        
    }
    
    public List<Wrap_opp> getwrap_opty(){
        
        opp_list = new List<Wrap_opp>();
        
        string qry = 'Select id,name , stagename,Amount from opportunity Where name != null';
        
        system.debug('VVVVVVVVVVVVVVV'+selected_stage);
        if(selected_stage != null){
            system.debug('DDDDDDDDDDDDDDD'+selected_stage);
            system.debug('DDDDDDDDDDDDDDD'+qry);
            qry += ' and StageName =: selected_stage';
        }
        
        system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA '+qry);
        List<Opportunity> opp = database.query(qry);
        
        for(Opportunity p : opp){
            opp_list.add(new wrap_opp(p));
        }
        
        return opp_list;
        
    }
    
    public List<Opportunity> selected_opp{get;set;}
    
    public void sel_opp(){
        selected_opp = new List<Opportunity>();
        
        for(wrap_opp w : opp_list){
            if(w.sel == true){
                selected_opp.add(w.opp);
            }
        }
        
    }
    
    public List<Opportunity> getopp_name(){
        list<Opportunity> opp1 = [Select name,stagename from opportunity];
        return opp1;
    }
    
    Public List<selectOption> getAcc_name(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new Selectoption('None','--None--'));
        
        for(Account aa : [Select id,name from Account]){
            options.add(new Selectoption(aa.id,aa.name));
        }
        return options;
        
    }
    
    public List<selectoption> getStage_name(){
        List<SelectOption> options = new List<SelectOption>();
        
        Schema.DescribeFieldResult fieldResult = Opportunity.StageName.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
            
            options.add(new Selectoption('None','--None--'));
            
            for( Schema.PicklistEntry f : ple)
            {
                options.add(new SelectOption(f.getValue(), f.getLabel()));
            }       
        return options;
    }
    
    public List<selectoption> getAcc_name1(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new Selectoption('None','--None--'));
        
        for(Account aa : [Select id,name from Account]){
            options.add(new SelectOption(aa.id,aa.name));
        }
    return options;    
    }
    
    public class wrap_opp{
        public Opportunity opp{get;set;}
        public boolean sel {get;set;}
        
        public wrap_opp(Opportunity p){
            opp = p;
            sel = false;
        }
    
    }

}