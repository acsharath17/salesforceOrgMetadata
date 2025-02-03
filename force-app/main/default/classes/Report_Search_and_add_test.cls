@isTest
public class Report_Search_and_add_test{

    private static testmethod void test_search(){
        
        Schedule_Report__c sch = new Schedule_Report__c();
        sch.Start_Date__c = System.now();
        sch.End_Date__c = system.now()+5;
        sch.Email_Addresses__c = 'achsharath@gmail.com , sharath@gmail.com';
        insert sch;
        
        Reports_Sceduled__c rep_sch = new Reports_Sceduled__c();
        rep_sch.Report_Folder__c = 'Folder Name';
        rep_sch.Report_Id__c = 'a0hO00000041q7d';
        rep_sch.Report_Name__c = 'Report Name';
        rep_sch.Scheduler__c = sch.id;
        insert rep_sch;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(Sch);
        
        PageReference pageRef = Page.Schedule_report;
        pageRef.getParameters().put('id', String.valueOf(sch.Id));
        Test.setCurrentPage(pageRef);
        
        Report_Search_and_add RS = new Report_Search_and_add(sc);
        RS.selected_folder_name = 'Folder Name';
        RS.searchString = 'test';
        RS.getFolder_name();
        RS.update_available_report();
        RS.add_to_selected();
        RS.toSelect = rep_sch.id;
        RS.add_to_selected();
        RS.remove_selected();
        RS.rep_sch_id = rep_sch.id;
        RS.go_next();
        RS.onSave();
        RS.onCancel();
        
        RS.go_back();
        RS.save_new();
    }
}