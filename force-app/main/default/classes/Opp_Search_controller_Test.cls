@isTest
public class Opp_Search_controller_Test{
    
    public static testmethod void test_Opp(){
        
        Account acc = new Account();
        acc.name = 'Test Class';
        insert acc;
        
        contact cc = new contact();
        cc.lastname = 'Sharat';
        cc.AccountId = acc.id;
        insert cc;
        
        acc.name = 'Update Account';
        update acc;
        
        Opp_Search_controller opp = new Opp_Search_controller();
        opp.sel_stage = 'Prospecting';
        opp.sel_acc = 'Account Name';
        opp.getStage_name();
        opp.getOpp_records();
        opp.getAcc_Name();    
    }
    
}