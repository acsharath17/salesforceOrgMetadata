global class ValidateCreditHold{
    webservice static string CheckCreditHold(String acc_id){
        
        string Reason;
        
        Account acc = [Select id,name,credit_hold__c,Credit_Hold_Reason__c,AccountSource From Account WHERE id =: acc_id];
        
        if(acc.credit_hold__c == true){
            
            if(acc.Credit_Hold_Reason__c == 'Soft'){
                Reason = System.Label.Credit_Hold_Soft_Hold;
            }else if(acc.Credit_Hold_Reason__c == 'Hard'){
                Reason = System.Label.Credit_Hold_Hard_Hold;
            }
            
        }else {
        
            Reason = updatePrepayment(acc);
            
        }
        return null;
    }
    
    webservice static string updatePrepayment(Account acc){
        string val;
        Account a = acc;
        a.AccountSource = 'Phone Inquiry';
        try{
            update a;
            val = 'Success';
        }catch(Exception e){
            val = e.getMessage();
        }
        return val;
    }
    
    public class CreditCheckResponse{
        
    }
}