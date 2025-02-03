public class opp_wrapper {
    
    public List<Inner_Class> opp1{get;set;}
    
    public list<Opportunity> sel_opp{get;set;}
    
    public List<Inner_Class> getAll_Opp(){
    
        List<Opportunity> opp = [Select id,name,stagename from Opportunity limit 10];
        
        opp1 = new List<Inner_Class>();
        
        for(Opportunity pp : [Select id,name,stagename from Opportunity limit 10]){
        
            opp1.add(new inner_class(pp));    
        }
        
        return opp1;
    } 
    
    public void show_sel(){
        sel_opp = new List<Opportunity>();
        
        for(Inner_Class IC : opp1){
            if(IC.sel == true){
                sel_opp.add(IC.opty);
            }    
        }
        
    }
    
    public class inner_class{
        public opportunity opty{get;set;}
        public boolean sel{get;set;}
        
        public inner_Class(Opportunity p){
            opty = p;
            sel = false;
        }
    }

}