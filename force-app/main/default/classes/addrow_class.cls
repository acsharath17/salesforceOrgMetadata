public class addrow_class {

    public Hotel__c hotl{get;set;}
    
    public List<Hotel__c> HH {get;set;}

    public addrow_class(ApexPages.StandardSetController controller) {
        HH = new List<Hotel__c>();
    }
    
    public void add_row(){
        hotl = new Hotel__c();
        Hotel__c h = new Hotel__c();
        h.name = hotl.name;
        HH.add(hotl);
    }
    
    public pagereference save_rec(){
        insert HH;
        return null;
    }

}