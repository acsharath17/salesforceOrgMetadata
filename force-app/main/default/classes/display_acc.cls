public class display_acc {
    
    public id parentid;
    public List<Contact> con {get;set;}
    
    public display_acc(ApexPages.StandardController controller) {
        parentId = ApexPages.currentpage().getParameters().get('id');
        //con = new List<Contact>();
        
        //con = [Select lastname,firstname from contact Where AccountId =: parentId];
    }
    
    public List<Contact> getcont(){
    
        con = new List<Contact>();
        
        con = [Select lastname,firstname from contact Where AccountId =: parentId];
        
        return con; 
    }

}