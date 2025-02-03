public with sharing class Opp_Search_controller {
    
    public string sel_stage{get;set;}
    public string sel_acc{get;set;}
    
    public List<selectoption> getStage_name(){
    
        List<SelectOption> options = new List<SelectOption>();
        
        Schema.DescribeFieldResult fieldResult = Opportunity.StageName.getDescribe();
        
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
            
            options.add(new Selectoption('None','--None--'));
            //options.add(new Selectoption('New','New'));
            
            for( Schema.PicklistEntry f : ple)
            {
                options.add(new SelectOption(f.getValue(), f.getLabel()));
            }       
        return options;
    }
    
    public List<Opportunity> getOpp_records(){
    
        string qry = 'select id,name,stagename, Amount from Opportunity Where Name != null';
        
        if(sel_stage != null && sel_stage != 'None'){
            qry += ' and StageName =: sel_stage';
        }
        
        List<Opportunity> opp = Database.query(qry);
        
        return opp;
    
    }
    
    public List<SelectOption> getAcc_Name(){
        List<SelectOption> options = new List<SelectOption>();
        
        options.add(new Selectoption('None','--None--'));
        
        LIst<Account> acc = [Select id,name from Account];
        
        for(Account a : acc){
            options.add(new SelectOption(a.id,a.name));
        }
        
        return options;
            
    }

}