public with sharing class opp_search {
    
    public string sel_stage{get;set;}
    public string sel_type{get;set;}
    
    
    
    public opp_search(ApexPages.StandardController controller) {

    }
    
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
    
    public list<Opportunity> getOpp_List(){
        string qry;
        
        qry = 'Select id,name,StageName,Amount From Opportunity Where Name != null';
        
        system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA '+sel_stage);
        system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB '+sel_type);
        
        if(sel_stage != null && sel_stage != 'None' ){
            qry += ' and StageName =: sel_stage';
        }
        
        system.debug('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD '+qry);
        
        if(sel_type != null && sel_type != 'None'){
            qry += ' and Type =: sel_type';
        }
        
        system.debug('VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV '+qry);
        
        List<opportunity> opp = database.query(qry); 
        return opp;
        
    }

}