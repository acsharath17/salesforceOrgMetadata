public class custom1 {

    public id parentId;
    public list<contact> con{get;set;}
    
    public custom1(ApexPages.StandardController abc) {
        parentId = ApexPages.CurrentPage().getParameters().get('id');
        con = new List<contact>();
        con = [Select id,name FROM contact where AccountId =: parentId ];
    }

}