public class Exception_Examples {
	
    public void query_Exception(){
        
        List<Account> acc = [Select id,name from Account]; //100 records
        Account acc1 = [Select id,name,phone from Account limit 1]; // query exception if u remove limit 1
        
        string acc_type = acc1.type; // sObject exception
    }
    
    Public void List_Exception(){
        List<integer> ii = new List<integer>();
        ii.add(10);
        ii.add(11);
        
        
        integer a = ii[0];
        integer b = ii[1];
        //integer c = ii[2];
        
        List<Account> aa = [Select name from Account];
        system.debug(aa);
        account acc = aa[1000];
        
    }
    
    
    public void null_pointer(){
        integer a;
        /*if(a == null)
            a=0;*/
        
        try{
        	integer b = 10 + a;    
        }catch(Exception e){
            
        }
        
    }
    
    public void DML_Exception(){
        
        Contact c1 = new contact();
        c1.FirstName = 'Sharat 1';
        try{
        	insert c1;    
        }catch(Exception e){
        	system.debug('Error Message'+ e.getMessage());    
        }
            
        
        contact c = new contact();
        c.lastname = 'Sharat';
        insert c;
    }
    
    
    
}