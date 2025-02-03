public class AccountUtils {
 public static List<Account> accountsByState(string stateAbe)
    {
        List<Account> acc= [SELECT name FROM Account where BillingState =: stateAbe];
        
        return acc;
    }
}