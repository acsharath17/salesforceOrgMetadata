public class accountTriggerHandler{
    
    public static void postalCodeCopy(list<Account> acc){
        for(Account aa : acc){
            if(aa.Match_Billing_Address__c && aa.BillingPostalCode!= null)
                aa.ShippingPostalCode = aa.BillingPostalCode;
        }
    }
}