@isTest
public class actionFunctionController_Test{
    
    public static testmethod void test_controller(){
        actionFunctionController act = new actionFunctionController();
        act.priorityChanged();
        act.acc.CustomerPriority__c = 'High';
        act.priorityChanged();
        
    }
    
    public static testmethod void test_insert_con(){
        actionFunctionController act = new actionFunctionController(); 
        act.insert_contact();   
    }
    
}