global with sharing class Quote_Approval {
    webservice static integer check_QLI(String parentid){
        integer a = [Select count() from QuoteLineItem Where QuoteId =: parentid];
        system.debug('aaaaaaaaaa'+[Select count() from QuoteLineItem Where QuoteId =: parentid]);
        return a;
    }
    
    webservice static String Submit_Approval(String parentid){
    	return 'You cannnot';    
    }
}