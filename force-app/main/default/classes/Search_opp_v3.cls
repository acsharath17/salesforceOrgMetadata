public class Search_opp_v3 {
    
    public string stage_name{get;set;}
    public string type_name{get;set;}
    
    public List<selectoption> getStage_name1(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Opportunity.StageName.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
            options.add(new Selectoption('None','--None--'));
            
            for( Schema.PicklistEntry f : ple)
            {
                options.add(new SelectOption(f.getLabel(), f.getValue()));
            }       
        return options;
    }
    
    public List<selectoption> getType_name1(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Opportunity.Type.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            options.add(new Selectoption('None','--None--'));
            for( Schema.PicklistEntry f : ple)
            {
                options.add(new SelectOption(f.getLabel(), f.getValue()));
            }       
        return options;
    }
    
    public List<wrap_opp> wrap{get;set;}
    
    public List<wrap_opp> getOpp_list(){
    
        string qry;
        
        qry = 'Select id,name,StageName,type,Amount From Opportunity Where name != null';
        
        if(Stage_name != null && Stage_name != 'None'){
            qry += ' and StageName =: stage_name';
        }
        
        if(Type_name != null && Type_name != 'None'){
            qry += ' and type =: type_name';
        }
        
        List<Opportunity> opp = database.query(qry);
        
        wrap = new List<wrap_opp>();
        
        for(Opportunity opty : opp){
            wrap.add(new wrap_opp(opty));    
        }
        
        return wrap;
        
    }
    
    public List<opportunity> sel_opp{get;set;}
    
    public void opp_sel(){
        sel_opp = new List<Opportunity>();
        
        for(Wrap_opp w : wrap){
            if(w.sel == true){
                sel_opp.add(w.op);
            }
        }
        
    }
    
    
    
    public class wrap_opp{
        public Opportunity op{get;set;}
        public boolean sel{get;set;}
        
        public wrap_opp(Opportunity p){
            op = p;
            sel = false;
        }
        
    }






















    
        
}