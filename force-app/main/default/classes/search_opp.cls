public class search_opp {
    public string Opp_stage{get;set;}
    public string Opp_type{get;set;}
    
    
    public List<selectoption> getStage_name(){
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
    
    public List<selectoption> getType_name(){
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
    public LIST<wrap_opp> opp_list{get;set;}
    
    Public List<wrap_opp> getOpp_result(){
        string qry;
        
        qry = 'Select id,name,StageName,Type,CloseDate,Amount From Opportunity where name != null';
        if(Opp_stage != null && Opp_stage != 'None'){
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ '+Opp_stage);
            qry += ' and StageName =: opp_stage';
        }
        If(Opp_type != null && Opp_type != 'None'){
            system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ '+ opp_type);
            qry += ' and Type =: opp_type';
        }
        List<opportunity> res = new List<Opportunity>();
        system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAA'+qry);
        res = database.query(qry);
        opp_list = new List<wrap_opp>();
        for(Opportunity p : res){
            opp_list.add(new wrap_opp(p));
        }
        return opp_list;
    }
    
    public List<opportunity> sel {get;set;}
    
    public void sel_opp(){
        sel = new List<Opportunity>();
        for(wrap_opp p : opp_List){
            if(p.selected == true){
                sel.add(p.opty);
            }
        }
        
    }
    
    public class wrap_opp{
        public Opportunity opty{get;set;}
        public boolean selected {get;set;}
        
        public wrap_opp(Opportunity pp){
            opty = pp;
            selected = false;
        }
    }
    
}