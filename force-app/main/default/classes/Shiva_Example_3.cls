public class Shiva_Example_3 {
    
    public List<Opportunity> opp {get;set;}
    public string selected_stage{get;set;}
    
    public Shiva_Example_3(ApexPages.StandardController controller) {

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
    
    public List<Opportunity> getOpp_Search(){
        
        opp = new List<Opportunity>();
        
        string qry = 'Select id,name , stagename,Amount from opportunity Where name != null'; 
        
        if(selected_stage != null){
            qry += ' and StageName =: selected_stage';
        }
        
        opp = database.query(qry);
        
        return opp;   
    }

}