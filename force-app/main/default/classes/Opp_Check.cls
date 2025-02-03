public with sharing class Opp_Check {
    
    private final Opportunity acct;

    
    public Opp_Check(ApexPages.StandardController Stdcontroller) {
        acct = (Opportunity)stdController.getRecord();
        system.debug('AAAAAAAAAAAAAAAAA '+acct);
    }
    
    public String getGreeting() {
        return 'Hello '  + ' (' + acct.id + ')';
    }
   
    public void save_opp(){
        Opportunity opp = new Opportunity();
        opp.name = 'Test Opp';
        opp.Stagename = 'Prospecting';
        opp.CloseDate = system.today()+10;
        insert opp;    
    }

}