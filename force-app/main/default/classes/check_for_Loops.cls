public class check_for_Loops {
    
    public void check(){
        List<Account> acc = [Select id,name from Account limit 10];
        
        list<contact> cc = [select id,name from contact];
        
        list<account> acnt = new List<Account>();
        
        integer ia = 0;
       
        for(Account a : acc){
            a.name = 'Salesforce1';
            acnt.add(a);
        }
        
        update acnt;
       
       
       /* for(integer i=0 ; i<acc.size() ; i++){
            
            list<contact> ccc = [select id,name from contact];
            acc[i].name = 'Salesforce';
            
            update acc[i];
            
            acnt.add(acc[i]);
            
            ia++;
            system.debug('Number of quries'+ia);
            
        }
        
        update acnt;*/
            
    }
    
}