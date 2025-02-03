public class sdsdd {
	public list<Account> ab = new List<Account>();
    
    public void update_acc(){
        
        for(Account acc : [Select name,phone from Account]){ //200
            
            if(acc.phone == '2323665'){
                
            }
            ab.add(acc);
        }
        update ab;
        
    }
    
}