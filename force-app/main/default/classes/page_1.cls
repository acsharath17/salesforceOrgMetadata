public class page_1 {

    public string abc{get;set;}
    
    public string ParentId{get;set;}
    
    public Opportunity opp{get;set;}
    
    public ApexPages.StandardController controller1;
    
    public page_1(ApexPages.StandardController controller) {
        ParentId = ApexPages.CurrentPage().getParameters().get('Id');
        
        opp = [Select id,name,StageName from Opportunity Where Id =: ParentId];
    }
    
    
    
    public PageReference go(){
        Page_2 pp = new page_2( controller1);
        
        return page.Page_3;
    }

}