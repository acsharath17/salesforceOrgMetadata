public with sharing class tiered_tables_controller {
    
    public List<ResourceWrapper> wrappers{get;set;}
    
    public tiered_tables_controller(){
        wrappers = new List<ResourceWrapper>();
        for(Account aa : [Select id,name,Industry,Phone,Revenue__c,Website,Type from Account]){
            wrappers.add(new ResourceWrapper(aa));
        }
    }
    
    
    public class ResourceWrapper
    {
    //Week data for both the Original and Working values
    public Account customerAcc{get; set;}
 
    //Drilldown data
    public List<Contact> resources{get; set;}
    public List<Opportunity> opps{get; set;}
 
    public ResourceWrapper(Account acc)
    {
      this.customerAcc = acc;
      resources = acc.Contacts;
      opps = acc.Opportunities;
    }
    }
}