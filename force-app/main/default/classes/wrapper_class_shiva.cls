public class wrapper_class_shiva {
    
    List<wrap> w {get;set;}
    
    public List<Account> sel_acc {get;set;}
    
    public List<wrap> getwrap_acc(){
        w = new List<wrap>();
        
        for(Account aa : [Select id,name,phone From Account WHERE name != 'Salesforce' Limit 10]){
            w.add(new wrap(aa));
        }
        return w;    
    }
    
    public List<Account> getall_account(){
        return [Select id,name,phone from Account WHERE name != 'Salesforce' Limit 10 ];
    }
    
    public void selected(){
        sel_acc = new List<Account>();
        
        for(wrap ww : w){
            if(ww.sel == true){
                sel_acc.add(ww.acc);    
            }
        }
        
    }
    
    public class wrap{
        public boolean sel{get;set;}
        Public Account acc{get;set;}
        
        public wrap(Account a){
            acc = a;
            sel = false;
        }
    }
    
}