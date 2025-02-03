public class display_case {
    
    public id parentId;
    
    public display_case(ApexPages.StandardController controller) {
        parentId = ApexPages.CurrentPage().getParameters().get('id');
    }
    
    public List<Case> getRel_case(){
        
        List<Case> ca = [Select id,Subject,status From Case Where AccountId =: parentId];
        
        return ca;
    
    }

}