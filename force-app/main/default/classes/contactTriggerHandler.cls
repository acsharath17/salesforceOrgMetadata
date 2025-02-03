public class contactTriggerHandler {
	
    public static void dataFomAccount(List<contact> newContact){
        for(contact c : [Select Id,Name,Account.Name,Description from Contact WHERE Id IN: newContact ]){
            c.Description = c.Account.Name;
        }
    }
}