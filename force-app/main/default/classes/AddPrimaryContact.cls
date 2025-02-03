public class AddPrimaryContact implements Queueable{
    private string bState;
    private Contact cont;
    
    public AddPrimaryContact(Contact con, string state){
        bState = state;
        cont = [Select Id,FirstName,LastName,Email,MobilePhone,AccountId from Contact LIMIT 1];
    }
    
    public void execute(QueueableContext QC){
        
        List<Contact> conList = new List<Contact>();
        for(Account acc : [Select Id,name from Account WHERE BillingState =: bState LIMIT 200]){
            Contact Con = cont.clone(false,false,false,false);
            con.AccountId = acc.Id;
            conList.add(con);
        }
        insert conList;    
    }
}